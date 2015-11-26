From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 26 Nov 2015 14:33:06 +0100
Subject: Strange message from Kirkwood pinctrl driver
In-Reply-To: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
References: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
Message-ID: <56570A12.3070300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.11.2015 11:27, Linus Walleij wrote:
> trying to use the Kirkwood pinctrl driver with compatible =
> "marvell,88f6192-pinctrl";
> on a Pogoplug series 4 yields the following message when instantiating
> the driver:
>
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 36
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 37
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 38
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 39
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 40
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 41
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 42
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 43
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 44
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 45
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 46
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 47
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 48
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 49
> kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
>
> It looks harmless but seems like a bug and make me uncertain.
>
> The following naive patch fixes it:
>
> diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> index 0f07dc554a1d..6c7c2c8819b8 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> @@ -411,7 +411,7 @@ static struct mvebu_pinctrl_soc_info mv88f6190_info = {
>          .controls = mv88f619x_mpp_controls,
>          .ncontrols = ARRAY_SIZE(mv88f619x_mpp_controls),
>          .modes = mv88f6xxx_mpp_modes,
> -       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes),
> +       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes) - 14,
>          .gpioranges = mv88f619x_gpio_ranges,
>          .ngpioranges = ARRAY_SIZE(mv88f619x_gpio_ranges),
>   };
> @@ -421,7 +421,7 @@ static struct mvebu_pinctrl_soc_info mv88f6192_info = {
>          .controls = mv88f619x_mpp_controls,
>          .ncontrols = ARRAY_SIZE(mv88f619x_mpp_controls),
>          .modes = mv88f6xxx_mpp_modes,
> -       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes),
> +       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes) - 14,
>          .gpioranges = mv88f619x_gpio_ranges,
>          .ngpioranges = ARRAY_SIZE(mv88f619x_gpio_ranges),
>   };
>
> What is the proper way to fix this?

Linus,

I had a quick look at the pinctrl driver.

mv88f6xxx_mpp_modes contains mpp modes 0-49 plus corresponding
functions for all Kirkwood SoCs, some SoCs only have a subset
of that.

Looking at

static struct mvebu_mpp_ctrl mv88f619x_mpp_controls[] = {
	MPP_FUNC_CTRL(0, 35, NULL, kirkwood_mpp_ctrl),
};

Kirkwood 619x only provides mpp0-35.

Now in pinctrl-mvebu.c, we loop over the controls and
collect the number of available groups. For kirkwood
there are no groups with more than one single mpp pin
like Dove has.

/* count controls and create names for mvebu generic
    register controls; also does sanity checks */
pctl->num_groups = 0;
pctl->desc.npins = 0;
for (n = 0; n < soc->ncontrols; n++) {
	struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];

	...

	/*
	 * We allow to pass controls with NULL name that we treat
	 * as a range of one-pin groups with generic mvebu register
	 * controls.
	 */
	if (!ctrl->name) {
		pctl->num_groups += ctrl->npins;
		...
	} else {
		pctl->num_groups += 1;
	}
}

After the loop pctl->num_groups is 36, i.e. mpp0 to mpp35.

A little later, we do:

/* assign mpp modes to groups */
for (n = 0; n < soc->nmodes; n++) {
	struct mvebu_mpp_mode *mode = &soc->modes[n];
	struct mvebu_pinctrl_group *grp =
		mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
	unsigned num_settings;

	if (!grp) {
		dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
			mode->pid);
		continue;
	}

	...
}

Which is looping over all modes (0-49) passed to the pinctrl-mvebu
core driver. As said earlier, we pass one control with range from
0-35 that gets translated to 36 groups (pctl->num_groups).
mvebu_find_group_by_pid() will try to find the corresponding group
for a given pin number by checking pctl->num_groups.

That obviously fails for modes 36-49 and will issue that annoying
warning.

IMHO, the correct fix will be to make the last loop above run from
0 to min(pctl->num_groups, soc->nmodes) instead of soc->nmodes.

We could also limit pctl->num_groups to soc->nmodes earlier and let
the loop run from 0 to pctl->num_groups.

I am very short on time, but if nobody else jumps in earlier, I can
stich a patch within a week or so.

Thanks for reporting the issue,

Sebastian
