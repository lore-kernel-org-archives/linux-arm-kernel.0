From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 14:44:53 +0200
Subject: [PATCH 04/10] ARM: sun6i: Add restart code for the A31
In-Reply-To: <20130729140430.GA25264@e106331-lin.cambridge.arm.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130729140430.GA25264@e106331-lin.cambridge.arm.com>
Message-ID: <20130730124453.GA12562@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jul 29, 2013 at 03:04:31PM +0100, Mark Rutland wrote:
> On Tue, Jul 23, 2013 at 11:25:06PM +0100, Maxime Ripard wrote:
> > The Allwinner A31 has a sligthly different watchdog that requires a
> > different restart code.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-sunxi/sunxi.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > index 11326d9..c18ef3a 100644
> > --- a/arch/arm/mach-sunxi/sunxi.c
> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > @@ -32,6 +32,15 @@
> >  #define SUN4I_WATCHDOG_MODE_ENABLE		(1 << 0)
> >  #define SUN4I_WATCHDOG_MODE_RESET_ENABLE	(1 << 1)
> >  
> > +#define SUN6I_WATCHDOG1_IRQ_REG		0x00
> > +#define SUN6I_WATCHDOG1_CTRL_REG	0x10
> > +#define SUN6I_WATCHDOG1_CTRL_RESTART		(1 << 0)
> > +#define SUN6I_WATCHDOG1_CONFIG_REG	0x14
> > +#define SUN6I_WATCHDOG1_CONFIG_RESTART		(1 << 0)
> > +#define SUN6I_WATCHDOG1_CONFIG_IRQ		(1 << 1)
> > +#define SUN6I_WATCHDOG1_MODE_REG	0x18
> > +#define SUN6I_WATCHDOG1_MODE_ENABLE		(1 << 0)
> > +
> >  static void __iomem *wdt_base;
> >  
> >  static void sun4i_restart(enum reboot_mode mode, const char *cmd)
> > @@ -56,8 +65,36 @@ static void sun4i_restart(enum reboot_mode mode, const char *cmd)
> >  	}
> >  }
> >  
> > +static void sun6i_restart(char mode, const char *cmd)
> > +{
> > +	if (!wdt_base)
> > +		return;
> > +
> > +	/* Disable interrupts */
> > +	writel(0, wdt_base + SUN6I_WATCHDOG1_IRQ_REG);
> > +
> > +	/* We want to disable the IRQ and just reset the whole system */
> > +	writel(SUN6I_WATCHDOG1_CONFIG_RESTART,
> > +		wdt_base + SUN6I_WATCHDOG1_CONFIG_REG);
> > +
> > +	/* Enable timer. The default and lowest interval value is 0.5s */
> > +	writel(SUN6I_WATCHDOG1_MODE_ENABLE,
> > +		wdt_base + SUN6I_WATCHDOG1_MODE_REG);
> > +
> > +	/* Restart the watchdog. */
> > +	writel(SUN6I_WATCHDOG1_CTRL_RESTART,
> > +		wdt_base + SUN6I_WATCHDOG1_CTRL_REG);
> > +
> > +	while (1) {
> > +		mdelay(5);
> > +		writel(SUN6I_WATCHDOG1_MODE_ENABLE,
> > +			wdt_base + SUN6I_WATCHDOG1_MODE_REG);
> > +	}
> > +}
> > +
> >  static struct of_device_id sunxi_restart_ids[] = {
> >  	{ .compatible = "allwinner,sun4i-wdt", .data = sun4i_restart },
> > +	{ .compatible = "allwinner,sun6i-wdt", .data = sun6i_restart },
> 
> Is there a corresponding binding document addition? 
> 
> sun4i-wdt.txt could be turned into a more general sunxi-wdt.txt.

Ah, right, thanks!

I'll fix it in the v2.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/11fa10a6/attachment.sig>
