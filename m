From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 11 Dec 2017 23:28:40 +0100
Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi
 #3228-staging
In-Reply-To: <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
References: <680389204.71.1512980755810.JavaMail.jenkins@ip-172-30-0-246>
 <51e6d7fb-ac9e-a59f-ea63-ad06219b429d@collabora.com>
 <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
Message-ID: <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Marek and Shuah to cc list]

On Mon, Dec 11, 2017 at 6:05 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Mon, Dec 11, 2017 at 11:30 AM, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>> Hi Daniel,
>>
>> Please see below, I've had several bisection results pointing at
>> that commit over the week-end on mainline but also on linux-next
>> and net-next.  While the peach-pi is a bit flaky at the moment
>> and is likely to have more than one issue, it does seem like this
>> commit is causing some well reproducible kernel hang.
>>
>> Here's a re-run with v4.15-rc3 showing the issue:
>>
>>   https://lava.collabora.co.uk/scheduler/job/1018478
>>
>> and here's another one with the change mentioned below reverted:
>>
>>   https://lava.collabora.co.uk/scheduler/job/1018479
>>
>> They both show a warning about "unbalanced disables for lcd_vdd",
>> I don't know if this is related as I haven't investigated any
>> further.  It does appear to reliably hang with v4.15-rc3 and
>> boot most of the time with the commit reverted though.
>>
>> The automated kernelci.org bisection is still an experimental
>> tool and it may well be a false positive, so please take this
>> result with a pinch of salt...
>
> The patch just very minimal moves the connector cleanup around (so
> timing change), but except when you unload a driver (or maybe that
> funny EPROBE_DEFER stuff) it shouldn't matter. So if you don't have
> more info than "seems to hang a bit more" I have no idea what's wrong.
> The patch itself should work, at least it survived quite some serious
> testing we do on everything.
> -Daniel
>

Marek was pointing to a different culprit [0] in this [1] thread. I
see that both commits made it to v4.15-rc3, which is the first version
where boot fails. So maybe is a combination of both? Or rather
reverting one patch masks the error in the other.

I've access to the machine but unfortunately not a lot of time to dig
on this, I could try to do it in the weekend though.

[0]: https://patchwork.kernel.org/patch/10067711/
[1]: https://www.spinics.net/lists/arm-kernel/msg622152.html

Best regards,
Javier

>> Hope this helps!
>>
>> Best wishes,
>> Guillaume
>>
>>
>> -------- Forwarded Message --------
>> Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi #3228-staging
>> Date: Mon, 11 Dec 2017 08:25:55 +0000 (UTC)
>> From: kernelci.org bot <bot@kernelci.org>
>> To: guillaume.tucker at collabora.com
>>
>> Bisection result for mainline/master (v4.15-rc3) on peach-pi
>>
>> Good known revision:
>>
>>     c6b3e96 Merge branch 'for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>>
>> Bad known revision:
>>
>>     50c4c4e Linux 4.15-rc3
>>
>> Extra parameters:
>>
>>     Tree:      mainline
>>     Branch:    master
>>     Target:    peach-pi
>>     Lab:       lab-collabora
>>     Defconfig: exynos_defconfig
>>     Plan:      boot
>>
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit a703c55004e1c5076d57e43771b3e11117796ea0
>> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Date:   Mon Dec 4 21:48:18 2017 +0100
>>
>>     drm: safely free connectors from connector_iter
>>         In
>>         commit 613051dac40da1751ab269572766d3348d45a197
>>     Author: Daniel Vetter <daniel.vetter@ffwll.ch>
>>     Date:   Wed Dec 14 00:08:06 2016 +0100
>>             drm: locking&new iterators for connector_list
>>         we've went to extreme lengths to make sure connector iterations
>> works
>>     in any context, without introducing any additional locking context.
>>     This worked, except for a small fumble in the implementation:
>>         When we actually race with a concurrent connector unplug event, and
>>     our temporary connector reference turns out to be the final one, then
>>     everything breaks: We call the connector release function from
>>     whatever context we happen to be in, which can be an irq/atomic
>>     context. And connector freeing grabs all kinds of locks and stuff.
>>         Fix this by creating a specially safe put function for
>> connetor_iter,
>>     which (in this rare case) punts the cleanup to a worker.
>>         Reported-by: Ben Widawsky <ben@bwidawsk.net>
>>     Cc: Ben Widawsky <ben@bwidawsk.net>
>>     Fixes: 613051dac40d ("drm: locking&new iterators for connector_list")
>>     Cc: Dave Airlie <airlied@gmail.com>
>>     Cc: Chris Wilson <chris@chris-wilson.co.uk>
>>     Cc: Sean Paul <seanpaul@chromium.org>
>>     Cc: <stable@vger.kernel.org> # v4.11+
>>     Reviewed-by: Dave Airlie <airlied@gmail.com>
>>     Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>     Link:
>> https://patchwork.freedesktop.org/patch/msgid/20171204204818.24745-1-daniel.vetter at ffwll.ch
>>
>> diff --git a/drivers/gpu/drm/drm_connector.c
>> b/drivers/gpu/drm/drm_connector.c
>> index 25f4b2e..4820141 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -152,6 +152,16 @@ static void drm_connector_free(struct kref *kref)
>>         connector->funcs->destroy(connector);
>>  }
>>  +static void drm_connector_free_work_fn(struct work_struct *work)
>> +{
>> +       struct drm_connector *connector =
>> +               container_of(work, struct drm_connector, free_work);
>> +       struct drm_device *dev = connector->dev;
>> +
>> +       drm_mode_object_unregister(dev, &connector->base);
>> +       connector->funcs->destroy(connector);
>> +}
>> +
>>  /**
>>   * drm_connector_init - Init a preallocated connector
>>   * @dev: DRM device
>> @@ -181,6 +191,8 @@ int drm_connector_init(struct drm_device *dev,
>>         if (ret)
>>                 return ret;
>>  +      INIT_WORK(&connector->free_work, drm_connector_free_work_fn);
>> +
>>         connector->base.properties = &connector->properties;
>>         connector->dev = dev;
>>         connector->funcs = funcs;
>> @@ -529,6 +541,18 @@ void drm_connector_list_iter_begin(struct drm_device
>> *dev,
>>  }
>>  EXPORT_SYMBOL(drm_connector_list_iter_begin);
>>  +/*
>> + * Extra-safe connector put function that works in any context. Should only
>> be
>> + * used from the connector_iter functions, where we never really expect to
>> + * actually release the connector when dropping our final reference.
>> + */
>> +static void
>> +drm_connector_put_safe(struct drm_connector *conn)
>> +{
>> +       if (refcount_dec_and_test(&conn->base.refcount.refcount))
>> +               schedule_work(&conn->free_work);
>> +}
>> +
>>  /**
>>   * drm_connector_list_iter_next - return next connector
>>   * @iter: connectr_list iterator
>> @@ -561,7 +585,7 @@ drm_connector_list_iter_next(struct
>> drm_connector_list_iter *iter)
>>         spin_unlock_irqrestore(&config->connector_list_lock, flags);
>>         if (old_conn)
>> -               drm_connector_put(old_conn);
>> +               drm_connector_put_safe(old_conn);
>>         return iter->conn;
>>  }
>> @@ -580,7 +604,7 @@ void drm_connector_list_iter_end(struct
>> drm_connector_list_iter *iter)
>>  {
>>         iter->dev = NULL;
>>         if (iter->conn)
>> -               drm_connector_put(iter->conn);
>> +               drm_connector_put_safe(iter->conn);
>>         lock_release(&connector_list_iter_dep_map, 0, _RET_IP_);
>>  }
>>  EXPORT_SYMBOL(drm_connector_list_iter_end);
>> diff --git a/drivers/gpu/drm/drm_mode_config.c
>> b/drivers/gpu/drm/drm_mode_config.c
>> index cda8bfa..cc78b3d 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -431,6 +431,8 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>>                 drm_connector_put(connector);
>>         }
>>         drm_connector_list_iter_end(&conn_iter);
>> +       /* connector_iter drops references in a work item. */
>> +       flush_scheduled_work();
>>         if (WARN_ON(!list_empty(&dev->mode_config.connector_list))) {
>>                 drm_connector_list_iter_begin(dev, &conn_iter);
>>                 drm_for_each_connector_iter(connector, &conn_iter)
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index df9807a..a4649c5 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -916,6 +916,14 @@ struct drm_connector {
>>         uint8_t num_h_tile, num_v_tile;
>>         uint8_t tile_h_loc, tile_v_loc;
>>         uint16_t tile_h_size, tile_v_size;
>> +
>> +       /**
>> +        * @free_work:
>> +        *
>> +        * Work used only by &drm_connector_iter to be able to clean up a
>> +        * connector from any context.
>> +        */
>> +       struct work_struct free_work;
>>  };
>>   #define obj_to_connector(x) container_of(x, struct drm_connector, base)
>> -------------------------------------------------------------------------------
>>
>>
>> Git bisection log:
>>
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [c6b3e9693f8a32ba3b07e2f2723886ea2aff4e94] Merge branch 'for-linus'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect good c6b3e9693f8a32ba3b07e2f2723886ea2aff4e94
>> # bad: [50c4c4e268a2d7a3e58ebb698ac74da0de40ae36] Linux 4.15-rc3
>> git bisect bad 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36
>> # bad: [e9ef1fe312b533592e39cddc1327463c30b0ed8d] Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>> git bisect bad e9ef1fe312b533592e39cddc1327463c30b0ed8d
>> # bad: [77071bc6c472bb0b36818f3e9595114cdf98c86d] Merge tag 'media/v4.15-2'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>> git bisect bad 77071bc6c472bb0b36818f3e9595114cdf98c86d
>> # bad: [4066aa72f9f2886105c6f747d7f9bd4f14f53c12] Merge tag
>> 'drm-fixes-for-v4.15-rc3' of git://people.freedesktop.org/~airlied/linux
>> git bisect bad 4066aa72f9f2886105c6f747d7f9bd4f14f53c12
>> # bad: [96980844bb4b74d2e7ce93d907670658e39a3992] Merge tag
>> 'drm-intel-fixes-2017-12-07' of git://anongit.freedesktop.org/drm/drm-intel
>> into drm-fixes
>> git bisect bad 96980844bb4b74d2e7ce93d907670658e39a3992
>> # bad: [120a264f9c2782682027d931d83dcbd22e01da80] drm/exynos: gem: Drop
>> NONCONTIG flag for buffers allocated without IOMMU
>> git bisect bad 120a264f9c2782682027d931d83dcbd22e01da80
>> # good: [2bf257d662509553ae226239e7dc1c3d00636ca6] drm/ttm: roundup the
>> shrink request to prevent skip huge pool
>> git bisect good 2bf257d662509553ae226239e7dc1c3d00636ca6
>> # good: [db8f884ca7fe6af64d443d1510464efe23826131] Merge branch
>> 'drm-fixes-4.15' of git://people.freedesktop.org/~agd5f/linux into drm-fixes
>> git bisect good db8f884ca7fe6af64d443d1510464efe23826131
>> # bad: [bd3a3a2e92624942a143e485c83e641b2492d828] Merge tag
>> 'drm-misc-fixes-2017-12-06' of git://anongit.freedesktop.org/drm/drm-misc
>> into drm-fixes
>> git bisect bad bd3a3a2e92624942a143e485c83e641b2492d828
>> # bad: [a703c55004e1c5076d57e43771b3e11117796ea0] drm: safely free
>> connectors from connector_iter
>> git bisect bad a703c55004e1c5076d57e43771b3e11117796ea0
>> # first bad commit: [a703c55004e1c5076d57e43771b3e11117796ea0] drm: safely
>> free connectors from connector_iter
>> -------------------------------------------------------------------------------
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
