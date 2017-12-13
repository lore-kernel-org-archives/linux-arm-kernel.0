From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Wed, 13 Dec 2017 09:03:21 +0000
Subject: [PATCH] drm: Fix possible deadlock in drm_mode_config_cleanup()
In-Reply-To: <20171213085720.6059-1-m.szyprowski@samsung.com>
References: <CGME20171213085736eucas1p28d10718330c5c2eac834bd26786c84fc@eucas1p2.samsung.com>
 <20171213085720.6059-1-m.szyprowski@samsung.com>
Message-ID: <151315580179.4445.15893201408981715923@mail.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Marek Szyprowski (2017-12-13 08:57:20)
> drm_mode_config_cleanup() might be called from a workqueue context (for
> example in error path handling of deferred probe), so it must not call
> flush_scheduled_work(), because it would deadlock in such case. Replace
> that call with explicit counting of the scheduled connector free works
> and waiting until it reaches zero.
> 
> Fixes: a703c55004e1 ("drm: safely free connectors from connector_iter")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This fixes the issue discussed in the following thread:
> https://www.spinics.net/lists/arm-kernel/msg622332.html
> ---
>  drivers/gpu/drm/drm_connector.c   |  6 +++++-
>  drivers/gpu/drm/drm_mode_config.c |  6 +++++-
>  include/drm/drm_mode_config.h     | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 0b7e0974e6da..7620ac1ad1b1 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -161,6 +161,8 @@ static void drm_connector_free_work_fn(struct work_struct *work)
>  
>         drm_mode_object_unregister(dev, &connector->base);
>         connector->funcs->destroy(connector);
> +       atomic_dec(&dev->mode_config.connector_free_works);
> +       wake_up_all(&dev->mode_config.connector_free_queue);
>  }
>  
>  /**
> @@ -552,8 +554,10 @@ EXPORT_SYMBOL(drm_connector_list_iter_begin);
>  static void
>  drm_connector_put_safe(struct drm_connector *conn)
>  {
> -       if (refcount_dec_and_test(&conn->base.refcount.refcount))
> +       if (refcount_dec_and_test(&conn->base.refcount.refcount)) {
> +               atomic_inc(&conn->dev->mode_config.connector_free_works);
>                 schedule_work(&conn->free_work);
> +       }
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 6ffe952142e6..cca443faebd8 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -381,6 +381,7 @@ void drm_mode_config_init(struct drm_device *dev)
>         idr_init(&dev->mode_config.tile_idr);
>         ida_init(&dev->mode_config.connector_ida);
>         spin_lock_init(&dev->mode_config.connector_list_lock);
> +       init_waitqueue_head(&dev->mode_config.connector_free_queue);
>  
>         drm_mode_create_standard_properties(dev);
>  
> @@ -431,8 +432,11 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>                 drm_connector_put(connector);
>         }
>         drm_connector_list_iter_end(&conn_iter);
> +
>         /* connector_iter drops references in a work item. */
> -       flush_scheduled_work();
> +       wait_event(dev->mode_config.connector_free_queue,
> +                  !atomic_read(&dev->mode_config.connector_free_works));
> +
>         if (WARN_ON(!list_empty(&dev->mode_config.connector_list))) {
>                 drm_connector_list_iter_begin(dev, &conn_iter);
>                 drm_for_each_connector_iter(connector, &conn_iter)
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index a0afeb591dcb..83a7db997e83 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -413,6 +413,19 @@ struct drm_mode_config {
>          * &struct drm_connector_list_iter to walk this list.
>          */
>         struct list_head connector_list;
> +       /**
> +        * @pending_connector_free_works:
> +        *
> +        * Number of scheduled connector->free_work instances, see
> +        * drm_connector_put_safe().
> +        */
> +       atomic_t connector_free_works;
> +       /**
> +        * @pending_connector_free_queue:
> +        *
> +        * Wait queue for waiting until connector->free_work is finished.
> +        */
> +       wait_queue_head_t connector_free_queue;

Just move from a system_wq to a local wq?
-Chris
