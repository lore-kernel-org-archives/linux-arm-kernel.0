From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Oct 2013 15:26:26 +0800
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
Message-ID: <20131010072624.GA29191@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 02:40:49PM +0200, Linus Walleij wrote:
> On Wed, Oct 9, 2013 at 7:42 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > It's naturally expected that when there are multiple phandle entries
> > specified in pinctrl-* property, these entries will be applied
> > sequentially.  And this is how Linux kernel works.  So let's define
> > this behavior in the binding doc.
> 
> NAK this this a Linux kernel implementation detail. Sherman Yin
> fixed this up so the drivers does not have to imply any sequence
> semantic for this.
> 
> Study commit 03b054e9696c3cbd3d5905ec96da15acd0a2fe8d
> "pinctrl: Pass all configs to driver on pin_config_set()"
> 
> It is perfectly legal for a driver to accumulate the settings into
> e.g. a single register write if it can, e.g.:
> 
> u32 val = 0;
> 
> for (i = 0; i < num_configs; i++) {
>   switch() {
>   FOO:
>      val |= 1;
>      break;
>    BAR:
>      val |= 2:
>      break;
>    BAZ:
>      val |=4;
>      break;
> };
> 
> writel(val, base+pinreg);
> 
> I.e. the driver may choose to apply configs sequentially, but that is
> not at all necessary.

Yes, that's the case when pinconf_apply_setting() is called to apply a
struct pinctrl_setting.  This pinctrl_setting may contain multiple
configs (pull, drive, open drain etc.) for a pin, and driver may choose
to apply these configs sequentially or accumulatedly.  In case of device
tree, all these configs must be coming from a single pin configuration
node, as per my understanding of how pinctrl core code maps pin
configuration in device tree node to struct pinctrl_setting.

However, my patch is talking about a different thing.  For example, we
have a device whose pinctrl-0 consists of two phandle entries that point
to pin configuration nodes foo and bar.

	pinctrl-0 = <&foo &bar>;

	foo {
		...
	};

	bar {
		...
	};

My patch only wants to make it clear that the configuration specified by
node foo will be applied to pin controller first, and the configuration
defined in node bar will be applied after that.  When both nodes have
configuration for a pin, these two configs for the same pin go to two
different pinctrl_setting structures.  And these two pinctrl_settings
can not be applied accumulatedly but only sequentially.  That's what my
patch talks about.

Shawn
