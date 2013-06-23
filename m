From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 23 Jun 2013 12:20:57 +0200
Subject: [PATCH] pinctrl-sunxi: fix pin attribute handling.
In-Reply-To: <A06309D9-3340-4F5B-AFB5-4B3DC3997411@upgrade-android.com>
References: <1371748373-10519-1-git-send-email-ithamar@upgrade-android.com>
 <20130620204908.GG2987@lukather>
 <A06309D9-3340-4F5B-AFB5-4B3DC3997411@upgrade-android.com>
Message-ID: <20130623102057.GD26008@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ithamar,

On Fri, Jun 21, 2013 at 09:41:13AM +0200, Ithamar R. Adema wrote:
> Dear Maxime,
> 
> On Jun 20, 2013, at 10:49 , Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi Ithamar,
> > 
> > You should probably put in the recipients Linus Walleij that will
> > probably be the one that will merge this patch anyway.
> 
> Ah okay, thanks for the heads-up.
> >> +		strength = 0;
> >> 		if (!of_property_read_u32(node, "allwinner,drive", &val)) {
> >> -			u16 strength = (val + 1) * 10;
> >> -			pinconfig[j++] =
> >> -				pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
> >> -							 strength);
> >> +			strength = (val + 1) * 10;
> >> 		}
> >> +		pinconfig[0] =
> >> +			pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
> >> +						 strength);
> > 
> > Why are you making the configuration of the strength in any cases? It's
> > an optional property, it should be treated as such.
> 
> My reasoning, which I can see is very subjective, is that if those
> properties (same for pull up/down) are not specified, you still want
> them to be in a defined state. Setting the drive strength (and pull
> up/down) to the default 0 value is just so that any configuration that
> might have been done the kernel started is undone.
> 
> I can understand your reasoning here, but are you sure you would want
> them left in undefined state?

While your reasoning is correct here, the point is that the platform is
still a little obscure, with not a lot of documentation and so on. So
relying on the bootloader to do some muxing could still prove useful.

> > 
> >> 		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
> >> 		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
> >> -		writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin),
> >> +		writel((val & ~mask) | arg << sunxi_pull_offset(g->pin),
> > 
> > I'd rather see an obvious assignment of 1 here. It's the value that is
> > documented in the datasheet, it pops to the mind. You can always put
> > this inside an if(arg) statement if you want to.
> 
> Just to make sure I understand, are you suggesting to stretch that
> writel() onliner into an if (arg) writel() else writel() ?

Yes, something like

case PULL_UP:
    val = readl(pctl->membase + sunxi_pull_reg(g->pin));
    mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
    if (arg)
	writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin), reg);
    else
	writel(val & ~mask, reg);

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130623/02b42f03/attachment.sig>
