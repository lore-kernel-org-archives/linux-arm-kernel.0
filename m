From: pza@pengutronix.de (Philipp Zabel)
Date: Sat, 30 Jan 2016 12:38:37 +0100
Subject: [PATCH v3 3/3] reset: Add support for shared reset controls
In-Reply-To: <1453918516-3078-4-git-send-email-hdegoede@redhat.com>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160130113837.GA25528@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Jan 27, 2016 at 07:15:16PM +0100, Hans de Goede wrote:
> In some SoCs some hw-blocks share a reset control. Add support for this
> setup by adding new:
> 
> reset_control_get_shared()
> devm_reset_control_get_shared()
> devm_reset_control_get_shared_by_index()
> 
> methods to get a reset_control. Note that this patch omits adding of_
> variants, if these are needed later they can be easily added.
> 
> This patch also changes the behavior of the existing exclusive
> reset_control_get() variants, if these are now called more then once
> for the same reset_control they will return -EBUSY. To catch existing
> drivers triggering this error (there should not be any) a WARN_ON(1)
> is added in this path.

Which is a good thing.

> When a reset_control is shared, the behavior of reset_control_assert /
> deassert is changed, for shared reset_controls these will work like the
> clock-enable/disable and regulator-on/off functions. They will keep a
> deassert_count, and only (re-)assert the reset after reset_control_assert
> has been called as many times as reset_control_deassert was called.
> 
> Calling reset_control_assert without first calling reset_control_deassert
> is not allowed on a shared reset control. Calling reset_control_reset is
> also not allowed on a shared reset control.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

All three patches look very nice. I'll give them a test-drive next week.
So far I have one small issue, and I like Stephens suggestion of
elaborating on how shared resets are to be used a bit more.

> ---
>  drivers/reset/core.c  | 61 ++++++++++++++++++++++++++++++++-------
>  include/linux/reset.h | 79 +++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 114 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index e439ae2..5554585 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -8,6 +8,7 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> +#include <linux/atomic.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -29,12 +30,16 @@ static LIST_HEAD(reset_controller_list);
>   * @id: ID of the reset controller in the reset
>   *      controller device
>   * @refcnt: Number of gets of this reset_control
> + * @shared: Is this a shared (1), or an exclusive (0) reset_control?
> + * @deassert_cnt: Number of times this reset line has been deasserted
>   */
>  struct reset_control {
>  	struct reset_controller_dev *rcdev;
>  	struct list_head list;
>  	unsigned int id;
>  	unsigned int refcnt;
> +	int shared;

Could we make this an
	enum reset_control_type type;

enum reset_control_type {
	RESET_CONTROL_EXCLUSIVE,
	RESET_CONTROL_SHARED,
};
instead?

[...]
> @@ -147,7 +180,7 @@ EXPORT_SYMBOL_GPL(reset_control_status);
>  
>  static struct reset_control *__reset_control_get(
>  				struct reset_controller_dev *rcdev,
> -				unsigned int index)
> +				unsigned int index, int shared)
>  {
>  	struct reset_control *rstc;
>  
> @@ -155,6 +188,10 @@ static struct reset_control *__reset_control_get(
>  
>  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
>  		if (rstc->id == index) {
> +			if (!rstc->shared || !shared) {

Then this would have to be

			if ((rstc->type == RESET_CONTROL_EXCLUSIVE) ||
			    (type == RESET_CONTROL_EXCLUSIVE)) {
...

[...]
> @@ -78,7 +78,8 @@ static inline struct reset_control *__devm_reset_control_get(
>  #endif /* CONFIG_RESET_CONTROLLER */
>  
>  /**
> - * reset_control_get - Lookup and obtain a reference to a reset controller.
> + * reset_control_get - Lookup and obtain an exclusive reference to a
> + *                     reset controller.
>   * @dev: device to be reset by the controller
>   * @id: reset line name
>   *
> @@ -92,17 +93,34 @@ static inline struct reset_control *__must_check reset_control_get(
>  #ifndef CONFIG_RESET_CONTROLLER
>  	WARN_ON(1);
>  #endif
> -	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0);
> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);

... but these would't be as opaque:

	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0,
				      RESET_CONTROL_EXCLUSIVE);

[...]
>  /**
> - * of_reset_control_get - Lookup and obtain a reference to a reset controller.
> + * reset_control_get_shared - Lookup and obtain a shared reference to a
> + *                            reset controller.
> + * @dev: device to be reset by the controller
> + * @id: reset line name
> + *
> + * Returns a struct reset_control or IS_ERR() condition containing errno.

How about addressing Stephen's suggestion by extending this kerneldoc comment a
bit?

> + * Use of id names is optional.
> + */
> +static inline struct reset_control *reset_control_get_shared(
> +					struct device *dev, const char *id)
> +{
> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 1);

	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0,
				      RESET_CONTROL_SHARED);

[...]

best regards
Philipp
