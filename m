From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 08 Feb 2012 09:53:23 +1100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F31AB63.3020301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/12 02:19, Thierry Reding wrote:

Hi Thierry,

A few comments below,

~Ryan

> This commit modifies the PWM core to support multiple PWMs per struct
> pwm_chip. It achieves this in a similar way to how gpiolib works, by
> allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
> starting at a given offset (pwm_chip.base >= 0). A chip specifies how
> many PWMs it controls using the npwm member. Each of the functions in
> the pwm_ops structure gets an additional argument that specified the PWM
> number (it can be converted to a per-chip index by subtracting the
> chip's base).
> 
> The total maximum number of PWM devices is currently fixed to 64, but
> can easily be made configurable via Kconfig.

It would be better to make the code handle arbitrary numbers of PWMs. A
Kconfig knob becomes annoying when you have more than one platform
configured into the kernel.

> The patch is incomplete in that it doesn't convert any existing drivers
> that are now broken.


Does this patch actually break the drivers in terms of not building or
running? If so, can this patch series be reworked a bit to allow the old
PWM framework to be used until all of the drivers are converted?

> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v2:
>   - add 'struct device *dev' field to pwm_chip, drop label field
>   - use radix tree for PWM descriptors
>   - add pwm_set_chip_data() and pwm_get_chip_data() functions to allow
>     storing and retrieving chip-specific per-PWM data
> 
> TODO:
>   - pass chip-indexed PWM number (PWM descriptor?) to drivers
>   - merge with Sascha's patch
> 
>  drivers/pwm/core.c  |  287 ++++++++++++++++++++++++++++++++++++++-------------
>  include/linux/pwm.h |   37 +++++--
>  2 files changed, 242 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 71de479..a223bd6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -17,154 +17,292 @@
>   *  along with this program; see the file COPYING.  If not, write to
>   *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
> +
>  #include <linux/module.h>
> +#include <linux/of_pwm.h>
>  #include <linux/pwm.h>
> +#include <linux/radix-tree.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  
> +#define MAX_PWMS 1024
> +
>  struct pwm_device {
> -	struct			pwm_chip *chip;
> -	const char		*label;
> +	const char *label;
> +	unsigned int pwm;
> +};
> +
> +struct pwm_desc {
> +	struct pwm_chip		*chip;
> +	void			*chip_data;
>  	unsigned long		flags;
>  #define FLAG_REQUESTED	0
>  #define FLAG_ENABLED	1
> -	struct list_head	node;
> +	struct pwm_device	pwm;
>  };


Do pwm_desc and pwm_device really need to be separate structs?
pwm_device only has two fields, which could easily be added to pwm_desc
(and rename it to pmw_device if you like). They are both opaque
structures, so it makes no difference to the users of the framework.

 
> -static LIST_HEAD(pwm_list);
> -
>  static DEFINE_MUTEX(pwm_lock);
> +static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
> +static RADIX_TREE(pwm_desc_tree, GFP_KERNEL);

I missed any discussion of this from v1, but why was this approach
chosen? The bitmap arbitrarily limits the maximum number of PWMs and is
also a little bit (nitpicky) wasteful when a platform doesn't need
anywhere near 1024 PWMs.

In most cases I would expect that platforms only have a handful of PWMs
(say less than 32), in which case a list lookup isn't too bad.

As someone else mentioned, it might be best to drop the global numbering
scheme and have each pwm_chip have its own numbering for its PWMs. So
requesting a PWM would first require getting a handle to the PWM chip it
is on. If a chip has a fixed number of PWMs (e.g. set a registration
time) then the PWMs within a chip can just be an array with O(1) lookup.

> +static struct pwm_desc *pwm_to_desc(unsigned int pwm)
> +{
> +	return radix_tree_lookup(&pwm_desc_tree, pwm);
> +}
> +
> +static struct pwm_desc *alloc_desc(unsigned int pwm)
> +{
> +	struct pwm_desc *desc;
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return NULL;
>  
> -static struct pwm_device *_find_pwm(int pwm_id)
> +	return desc;
> +}
> +
> +static void free_desc(unsigned int pwm)
> +{
> +	struct pwm_desc *desc = pwm_to_desc(pwm);
> +
> +	radix_tree_delete(&pwm_desc_tree, pwm);
> +	kfree(desc);
> +}
> +
> +static int alloc_descs(int pwm, unsigned int from, unsigned int count)

>  {

You don't really need the from argument. There is only one caller for
alloc_descs and it passes 0 for from. So you could re-write this as:

	static int alloc_descs(int pwm, unsigned int count)
	{
		unsigned int from = 0;
		...

		if (pwm > MAX_PWMS)
			return -EINVAL;
		if (pwm >= 0)
			from = pwm;

> -	struct pwm_device *pwm;
> +	unsigned int start;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	if (pwm >= 0) {
> +		if (from > pwm)
> +			return -EINVAL;
> +
> +		from = pwm;
> +	}


This doesn't catch some caller errors:

	if (pwm > MAX_PWMS || from > MAX_PWMS)
		return -EINVAL;

> +
> +	start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, from,
> +			count, 0);

Do the PWM indexes need to be contiguous for a given PWM chip? You could
probably grab each bit individually. That said, I think a better
solution is to have per-chip numbering.

> -	list_for_each_entry(pwm, &pwm_list, node) {
> -		if (pwm->chip->pwm_id == pwm_id)
> -			return pwm;
> +	if ((pwm >= 0) && (start != pwm))


Don't need the inner parens.

> +		return -EEXIST;
> +
> +	if (start + count > MAX_PWMS)
> +		return -ENOSPC;


Is this possible? Can bitmap_find_next_zero_area return a start position
where the count would exceed the maximum?

> +
> +	for (i = start; i < start + count; i++) {
> +		struct pwm_desc *desc = alloc_desc(i);
> +		if (!desc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		radix_tree_insert(&pwm_desc_tree, i, desc);
>  	}
>  
> -	return NULL;
> +	bitmap_set(allocated_pwms, start, count);
> +
> +	return start;
> +
> +err:
> +	for (i--; i >= 0; i--)


Nitpick:

	while (--i >= 0)

is a bit simpler.

> +		free_desc(i);
> +
> +	return ret;
> +}
> +
> +static void free_descs(unsigned int from, unsigned int count)
> +{
> +	unsigned int i;
> +
> +	for (i = from; i < from + count; i++)
> +		free_desc(i);
> +
> +	bitmap_clear(allocated_pwms, from, count);
>  }
>  
>  /**
> - * pwmchip_add() - register a new pwm
> - * @chip: the pwm
> - *
> - * register a new pwm. pwm->pwm_id must be initialized. if pwm_id < 0 then
> - * a dynamically assigned id will be used, otherwise the id specified,
> + * pwm_set_chip_data - set private chip data for a PWM
> + * @pwm: PWM number
> + * @data: pointer to chip-specific data
>   */
> -int pwmchip_add(struct pwm_chip *chip)
> +int pwm_set_chip_data(unsigned int pwm, void *data)


This interface is a bit ugly. Shouldn't the user need to have a handle
to the pwm_device in order to access the chip_data? Why should callers
be able to set/grab chip data from random PWMs?

>  {
> -	struct pwm_device *pwm;
> -	int ret = 0;
> +	struct pwm_desc *desc = pwm_to_desc(pwm);
>  
> -	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
> -	if (!pwm)
> -		return -ENOMEM;
> +	if (!desc)
> +		return -EINVAL;
>  
> -	pwm->chip = chip;
> +	desc->chip_data = data;
> +	return 0;
> +}
> +
> +/**
> + * pwm_get_chip_data - get private chip data for a PWM
> + * @pwm: PWM number
> + */
> +void *pwm_get_chip_data(unsigned int pwm)
> +{

> +	struct pwm_desc *desc = pwm_to_desc(pwm);
> +
> +	return desc ? desc->chip_data : NULL;
> +}
> +
> +/**
> + * pwmchip_add() - register a new PWM chip
> + * @chip: the PWM chip to add
> + *
> + * Register a new PWM chip. If pwm->base < 0 then a dynamically assigned base
> + * will be used.
> + */
> +int pwmchip_add(struct pwm_chip *chip)
> +{
> +	unsigned int i;
> +	int ret;
>  
>  	mutex_lock(&pwm_lock);
>  
> -	if (chip->pwm_id >= 0 && _find_pwm(chip->pwm_id)) {
> -		ret = -EBUSY;
> +	ret = alloc_descs(chip->base, 0, chip->npwm);
> +	if (ret < 0)
>  		goto out;
> +
> +	chip->base = ret;
> +	ret = 0;
> +
> +	/* initialize descriptors */
> +	for (i = chip->base; i < chip->base + chip->npwm; i++) {
> +		struct pwm_desc *desc = pwm_to_desc(i);
> +
> +		if (!desc) {
> +			pr_debug("pwm: descriptor %u not initialized\n", i);


Should this be a WARN_ON?

> +			continue;
> +		}
> +
> +		desc->chip = chip;
>  	}
>  
> -	list_add_tail(&pwm->node, &pwm_list);
> +	of_pwmchip_add(chip);
> +
>  out:
>  	mutex_unlock(&pwm_lock);
> -
> -	if (ret)
> -		kfree(pwm);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_add);
>  
>  /**
> - * pwmchip_remove() - remove a pwm
> - * @chip: the pwm
> + * pwmchip_remove() - remove a PWM chip
> + * @chip: the PWM chip to remove
>   *
> - * remove a pwm. This function may return busy if the pwm is still requested.
> + * Removes a PWM chip. This function may return busy if the PWM chip provides
> + * a PWM device that is still requested.
>   */
>  int pwmchip_remove(struct pwm_chip *chip)
>  {
> -	struct pwm_device *pwm;
> +	unsigned int i;
>  	int ret = 0;
>  
>  	mutex_lock(&pwm_lock);
>  
> -	pwm = _find_pwm(chip->pwm_id);
> -	if (!pwm) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> +	for (i = chip->base; i < chip->base + chip->npwm; i++) {
> +		struct pwm_desc *desc = pwm_to_desc(i);
>  
> -	if (test_bit(FLAG_REQUESTED, &pwm->flags)) {
> -		ret = -EBUSY;
> -		goto out;
> +		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
> +			ret = -EBUSY;
> +			goto out;
> +		}
>  	}
>  
> -	list_del(&pwm->node);
> +	free_descs(chip->base, chip->npwm);
> +	of_pwmchip_remove(chip);
>  
> -	kfree(pwm);
>  out:
>  	mutex_unlock(&pwm_lock);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_remove);
>  
> +/**
> + * pwmchip_find() - iterator for locating a specific pwm_chip
> + * @data: data to pass to match function
> + * @match: callback function to check pwm_chip
> + */
> +struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
> +						       void *data))
> +{
> +	struct pwm_chip *chip = NULL;
> +	unsigned long i;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	for_each_set_bit(i, allocated_pwms, MAX_PWMS) {
> +		struct pwm_desc *desc = pwm_to_desc(i);
> +
> +		if (!desc || !desc->chip)
> +			continue;
> +
> +		if (match(desc->chip, data)) {
> +			chip = desc->chip;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&pwm_lock);
> +
> +	return chip;
> +}
> +EXPORT_SYMBOL_GPL(pwmchip_find);


So, propreitary modules are not allowed to use PWMs?

> +
>  /*
>   * pwm_request - request a PWM device
>   */
> -struct pwm_device *pwm_request(int pwm_id, const char *label)
> +struct pwm_device *pwm_request(int pwm, const char *label)
>  {
> -	struct pwm_device *pwm;
> +	struct pwm_device *dev;
> +	struct pwm_desc *desc;
>  	int ret;
>  
> +	if ((pwm < 0) || (pwm >= MAX_PWMS))


Don't need the inner parens.

> +		return ERR_PTR(-ENOENT);


-EINVAL maybe?

> +
>  	mutex_lock(&pwm_lock);
>  
> -	pwm = _find_pwm(pwm_id);
> -	if (!pwm) {
> -		pwm = ERR_PTR(-ENOENT);
> -		goto out;
> -	}
> +	desc = pwm_to_desc(pwm);
> +	dev = &desc->pwm;


This looks wrong. If the pwm_desc being requested doesn't exist, won't
this oops?

>  
> -	if (test_bit(FLAG_REQUESTED, &pwm->flags)) {
> -		pwm = ERR_PTR(-EBUSY);
> +	if (test_bit(FLAG_REQUESTED, &desc->flags)) {
> +		dev = ERR_PTR(-EBUSY);
>  		goto out;
>  	}
>  
> -	if (!try_module_get(pwm->chip->ops->owner)) {
> -		pwm = ERR_PTR(-ENODEV);
> +	if (!try_module_get(desc->chip->ops->owner)) {
> +		dev = ERR_PTR(-ENODEV);
>  		goto out;
>  	}
>  
> -	if (pwm->chip->ops->request) {
> -		ret = pwm->chip->ops->request(pwm->chip);
> +	if (desc->chip->ops->request) {
> +		ret = desc->chip->ops->request(desc->chip, pwm);
>  		if (ret) {
> -			pwm = ERR_PTR(ret);
> +			dev = ERR_PTR(ret);
>  			goto out_put;
>  		}
>  	}
>  
> -	pwm->label = label;
> -	set_bit(FLAG_REQUESTED, &pwm->flags);
> +	dev->label = label;
> +	dev->pwm = pwm;
> +	set_bit(FLAG_REQUESTED, &desc->flags);
>  
>  	goto out;
>  
>  out_put:
> -	module_put(pwm->chip->ops->owner);
> +	module_put(desc->chip->ops->owner);
>  out:
>  	mutex_unlock(&pwm_lock);
>  
> -	return pwm;
> +	return dev;
>  }
>  EXPORT_SYMBOL_GPL(pwm_request);
>  
> @@ -173,16 +311,19 @@ EXPORT_SYMBOL_GPL(pwm_request);
>   */
>  void pwm_free(struct pwm_device *pwm)
>  {
> +	struct pwm_desc *desc = container_of(pwm, struct pwm_desc, pwm);
> +
>  	mutex_lock(&pwm_lock);

pwm_lock is used to protect global addition and removal from the
radix/tree bitmap. Here you are also using it to protect the fields of a
specific pwm device? Maybe it would be better to have a per pwm device
lock for this?

> -	if (!test_and_clear_bit(FLAG_REQUESTED, &pwm->flags)) {
> +	if (!test_and_clear_bit(FLAG_REQUESTED, &desc->flags)) {
>  		pr_warning("PWM device already freed\n");
>  		goto out;
>  	}
>  
>  	pwm->label = NULL;
> +	pwm->pwm = 0;


Why do this? Isn't index 0 a valid PWM index?a

>  
> -	module_put(pwm->chip->ops->owner);
> +	module_put(desc->chip->ops->owner);
>  out:
>  	mutex_unlock(&pwm_lock);
>  }
> @@ -193,7 +334,9 @@ EXPORT_SYMBOL_GPL(pwm_free);
>   */
>  int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> -	return pwm->chip->ops->config(pwm->chip, duty_ns, period_ns);
> +	struct pwm_desc *desc = container_of(pwm, struct pwm_desc, pwm);
> +	return desc->chip->ops->config(desc->chip, pwm->pwm, duty_ns,
> +			period_ns);
>  }
>  EXPORT_SYMBOL_GPL(pwm_config);
>  
> @@ -202,8 +345,10 @@ EXPORT_SYMBOL_GPL(pwm_config);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (!test_and_set_bit(FLAG_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip);
> +	struct pwm_desc *desc = container_of(pwm, struct pwm_desc, pwm);
> +
> +	if (!test_and_set_bit(FLAG_ENABLED, &desc->flags))
> +		return desc->chip->ops->enable(desc->chip, pwm->pwm);
>  
>  	return 0;
>  }
> @@ -214,7 +359,9 @@ EXPORT_SYMBOL_GPL(pwm_enable);
>   */
>  void pwm_disable(struct pwm_device *pwm)
>  {
> -	if (test_and_clear_bit(FLAG_ENABLED, &pwm->flags))
> -		pwm->chip->ops->disable(pwm->chip);
> +	struct pwm_desc *desc = container_of(pwm, struct pwm_desc, pwm);
> +
> +	if (test_and_clear_bit(FLAG_ENABLED, &desc->flags))
> +		desc->chip->ops->disable(desc->chip, pwm->pwm);
>  }
>  EXPORT_SYMBOL_GPL(pwm_disable);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index df9681b..0f8d105 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -32,37 +32,50 @@ void pwm_disable(struct pwm_device *pwm);
>  struct pwm_chip;
>  
>  /**
> - * struct pwm_ops - PWM operations
> + * struct pwm_ops - PWM controller operations
>   * @request: optional hook for requesting a PWM
>   * @free: optional hook for freeing a PWM
>   * @config: configure duty cycles and period length for this PWM
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
> + * @owner: helps prevent removal of modules exporting active PWMs
>   */
>  struct pwm_ops {
> -	int			(*request)(struct pwm_chip *chip);
> -	void			(*free)(struct pwm_chip *chip);
> -	int			(*config)(struct pwm_chip *chip, int duty_ns,
> +	int			(*request)(struct pwm_chip *chip,
> +						unsigned int pwm);
> +	void			(*free)(struct pwm_chip *chip,
> +						unsigned int pwm);
> +	int			(*config)(struct pwm_chip *chip,
> +						unsigned int pwm, int duty_ns,
>  						int period_ns);
> -	int			(*enable)(struct pwm_chip *chip);
> -	void			(*disable)(struct pwm_chip *chip);
> +	int			(*enable)(struct pwm_chip *chip,
> +						unsigned int pwm);
> +	void			(*disable)(struct pwm_chip *chip,
> +						unsigned int pwm);
>  	struct module		*owner;
>  };
>  
>  /**
> - * struct pwm_chip - abstract a PWM
> - * @label: for diagnostics
> - * @owner: helps prevent removal of modules exporting active PWMs
> - * @ops: The callbacks for this PWM
> + * struct pwm_chip - abstract a PWM controller
> + * @dev: device providing the PWMs
> + * @ops: callbacks for this PWM controller
> + * @base: number of first PWM controlled by this chip
> + * @npwm: number of PWMs controlled by this chip
>   */
>  struct pwm_chip {
> -	int			pwm_id;
> -	const char		*label;
> +	struct device		*dev;
>  	struct pwm_ops		*ops;
> +	int			base;
> +	unsigned int		npwm;
>  };
>  
> +int pwm_set_chip_data(unsigned int pwm, void *data);
> +void *pwm_get_chip_data(unsigned int pwm);
> +
>  int pwmchip_add(struct pwm_chip *chip);
>  int pwmchip_remove(struct pwm_chip *chip);
> +struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
> +						       void *data));
>  #endif
>  
>  #endif /* __LINUX_PWM_H */
