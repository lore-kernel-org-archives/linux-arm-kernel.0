From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 May 2014 08:19:24 -0500
Subject: [PATCH] of: Add of_platform_depopulate() helper
In-Reply-To: <1399981836-24837-1-git-send-email-pawel.moll@arm.com>
References: <1399981836-24837-1-git-send-email-pawel.moll@arm.com>
Message-ID: <CAL_JsqLj5Jy1-fvtDYm=CH8J5R-okKyKxP4X-htONuzQWreVRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 6:50 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> Drivers can us of_platform_populate() to create
> platform devices for children of the device
> main node (this can particularly happen in case
> of MFD devices). Unfortunately, there was no
> standard way of removing such sub-devices when
> the main one is being removed.
>
> This patch adds of_platform_depopulate() as
> a complementary operation for the _populate()
> one. It removes all platform and amba devices
> that have been created from the Device Tree,
> but leaves all other ones untouched (returning
> -EBUSY in such case).
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/of/platform.c       | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_platform.h |  5 +++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 2d0c8b7..b5c49c3 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -495,4 +495,56 @@ int of_platform_populate(struct device_node *root,
>         return rc;
>  }
>  EXPORT_SYMBOL_GPL(of_platform_populate);
> +
> +static int of_platform_device_destroy(struct device *dev, void *data)
> +{
> +       int *parents_children_left = data;

You are not really tracking how many children are left, so this can
just be a bool.

> +       int my_children_left = 0;
> +
> +       /* Do not touch devices not populated from the device tree */
> +       if (!dev->of_node || !of_node_check_flag(dev->of_node, OF_POPULATED)) {
> +               (*parents_children_left)++;
> +               return 0;
> +       }
> +
> +       device_for_each_child(dev, &my_children_left,
> +                       of_platform_device_destroy);

Can't you call of_platform_depopulate here?

> +       if (my_children_left) {
> +               (*parents_children_left)++;
> +               return 0;
> +       }
