From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 19 Jan 2012 11:03:00 -0800
Subject: [PATCH] pinctrl: pin configuration states
In-Reply-To: <1326725496-28928-1-git-send-email-linus.walleij@stericsson.com>
References: <1326725496-28928-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB15E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Monday, January 16, 2012 7:52 AM:
> This introduce a pin configuration state structure and activation
> functions similar to the pinmux map. It basically names a few
> states and define the custom configuration values to be applied to
> groups and pins alike when switching to a certain state.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Maybe this is closer to what people want for configuring the pins
> in their platforms? I am not fully satisfied with this solution
> because it basically maintains status quo of the big static tables
> found in many ARM SoCs, but it does instill a common scheme for
> doing it.

At a pretty high conceptual level, this looks good. I've got some specific
comments below though. Overall, moving in the right direction for me.

> Also there is no way for a pinmux and its associated device to
> switch states in this solution. However one does not exclude the
> other, we might want per-device associated pinmux and group
> states *also*.

Yes, I think per-device states are a primary use-case...

> diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h

> +/**
> + * struct pin_config_state - configuration for an array of pins
> + * @name: name of this configuration state
> + * @ctrl_dev: the pin control device to be used for this state, may be NULL
> + *	if you provide .ctrl_dev_name instead (this is more common)
> + * @ctrl_dev_name: the name of the device controlling this specific state,
> + *	the name must be the same as in your struct device*, may be NULL if
> + *	you provide .ctrl_dev instead
> + * @pin_configs: array of pin configuration tuples
> + * @nr_pin_configs: number of pin_configuration tuples in the array
> + * @pin_group_configs: array of pin group configuration tuples
> + * @nr_pin_group_configs: number of pin_group_configuration tuples in the array
> + * @apply_on_init: whether this configuration shall be auto-applied when
> + *	the pin controller is registered
> + * @apply_on_exit: whether this configuration shall be auto-applied when
> + *	the pin controller is unregistered
> + */
> +struct pin_config_state {
> +	const char *name;
> +	struct device *ctrl_dev;
> +	const char *ctrl_dev_name;
> +	const struct pin_config *pin_configs;
> +	unsigned nr_pin_configs;
> +	const struct pin_group_config *pin_group_configs;
> +	unsigned nr_pin_group_configs;
> +	bool apply_on_init;
> +	bool apply_on_exit;
> +};

In the long-run for per-device states, I think you'll need the per-
device fields that the pinmux mapping table has:

        struct device *dev;
        const char *dev_name;

In that case, .apply_on_init/.apply_on_exit don't really apply that well.
I'd suggest combining those two fields into a "bool hog" field just like
the pinmux mapping table, and defining that .name name must be "init" or
"exit" when .hog==true. That seems more in line with devices using the
.name field to define which states happen when.

That then makes the lookup structure of this new pin config table the
Same as the existing lookup structure of the pinmux mapping table.

Bikeshedding a but, the names init/fini are a slightly more match pair,
but perhaps less understandable? Probe/remove match the Linux driver
model better, but wouldn't map as well to device tree which isn't supposed
to be influenced by Linux.

> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt

> +static const struct pin_config foo_pin_config_idle[] = {
...
> +static const struct pin_config foo_pin_config_idle[] = {

s/_idle/_off/

> +static struct pin_config_state __initdata foo_pinconf_states[] = {
...
> +	{
> +		.name = "idle",
> +		.ctrl_dev_name = "foo",
> +		.pin_configs = foo_pin_config_idle,
> +		.nr_pin_configs = ARRAY_SIZE(foo_pin_config_idle),
> +	},
> +	{
> +		.name = "off",
> +		.ctrl_dev_name = "foo",
> +		.pin_configs = foo_pin_config_idle,
> +		.nr_pin_configs = ARRAY_SIZE(foo_pin_config_idle),

s/_idle/_off/ on the 2 lines above.

> +		.apply_on_exit = true,
> +	},
> +};

> diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c

> +int __init pinconf_register_pin_states(struct pin_config_state const *states,
> +				       unsigned num_states)
> +{
> +	void *tmp;
> +	int i;
> +
> +	pr_debug("add %d pin configuration states\n", num_states);
> +
> +	/* First sanity check the new states */
> +	for (i = 0; i < num_states; i++) {
> +		if (!states[i].name) {
> +			pr_err("failed to register config state %d: "
> +			       "no state name given\n", i);
> +			return -EINVAL;
> +		}
> +
> +		if (!states[i].ctrl_dev && !states[i].ctrl_dev_name) {

This should probably check that both aren't set at the same time to:

if (!!states[i].ctrl_dev == !!states[i].ctrl_dev_name)

> +			pr_err("failed to register config state %s (%d): "
> +			       "no pin control device given\n",
> +			       states[i].name, i);
> +			return -EINVAL;
> +		}
> +
> +		if (!states[i].pin_configs && !states[i].pin_group_configs) {

Don't you want to check the length fields to: Something more like:

if (!!states[i].pin_configs != !!states[i].nr_pin_configs)
    error
if (!!states[i].pin_group_configs != !!states[i].nr_pin_group_configs)
    error
if (!states[i].pin_configs && !states[i].pin_group_configs)
    error

> +			pr_err("failed to register config state %s (%d): "
> +			       "no pin or group states defined in it\n",
> +			       states[i].name, i);
> +			return -EINVAL;
> +		}
> +		else
> +			pr_debug("register pin config state %s\n",
> +				 states[i].name);
> +	}
> +
> +	/*
> +	 * Make a copy of the config state array - string pointers will end up
...
> +	pinconf_states = tmp;
> +	pinconf_states_num += num_states;

We need to allow multiple tables to be registered, for all the same
reasons we do for the pinmux mapping table. This implementation only
keeps the most recently registered table.

> +int pinconf_activate_state(const char *dev_name, const char *state)
> +{
> +	struct pinctrl_dev *pctldev;
> +	int i;
> +
> +	pctldev = get_pinctrl_dev_from_dev(NULL, dev_name);
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	for (i = 0; i < pinconf_states_num; i++) {
> +		struct pin_config_state const *pstate = &pinconf_states[i];
> +		int ret;

Shouldn't this check that the entry is for the pctldev, not some other
pin control device?

> +		if (!strcmp(pstate->name, state)) {
> +			ret = pinconf_apply_state(pctldev, pstate);
> +			if (ret)
> +				dev_err(pctldev->dev,
> +					"failed to apply state %s\n",
> +					pstate->name);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pinconf_apply_initexit() - check for states to be applied on init and exit
> + * @pctldev: pin controller to be checked
> + * @init: true for checking during registration of the pin controller, false
> + *	for checking during removal of the pin controller
> + */
> +void pinconf_apply_initexit(struct pinctrl_dev *pctldev, bool init)
> +{
> +	int i;
> +
> +	for (i = 0; i < pinconf_states_num; i++) {
> +		struct pin_config_state const *pstate = &pinconf_states[i];
> +		int ret;

Shouldn't this check that the entry is for the pctldev, not some other
pin control device?

> +		if ((pstate->apply_on_init && init) ||
> +		    (pstate->apply_on_exit && !init)) {
> +			ret = pinconf_apply_state(pctldev, pstate);
> +			if (ret)
> +				dev_err(pctldev->dev,
> +					"failed to apply state %s on %s\n",
> +					pstate->name,
> +					init ? "init" : "exit");
> +		}
> +	}
> +}

-- 
nvpublic
