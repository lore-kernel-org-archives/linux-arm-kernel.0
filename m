From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Feb 2015 09:52:23 +0900
Subject: [PATCH 4/5] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
In-Reply-To: <8723510.YP2sm4Z5UY@wuerfel>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
 <3a8e2822e1351c0ef8f9dd1c3e81cd5bfeb319e5.1424931398.git.horms+renesas@verge.net.au>
 <8723510.YP2sm4Z5UY@wuerfel>
Message-ID: <20150227005223.GA24717@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Feb 26, 2015 at 04:53:39PM +0100, Arnd Bergmann wrote:
> On Thursday 26 February 2015 15:22:44 Simon Horman wrote:
> > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > 
> > This provides information through SOC_BUS to sysfs.
> > And this moves all on-SoC devices from /sys/devices/platform to
> > /sys/devices/socX/.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/Kconfig           |  1 +
> >  arch/arm/mach-shmobile/setup-rcar-gen2.c | 38 ++++++++++++++++++++++++++++----
> >  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> I think this would be better done as a standalone driver in drivers/soc,
> to avoid having to add the init_machine callbacks in patch 3.

Could we handle this as follow-up work?

> >  void __init rcar_gen2_init_machine(void)
> >  {
> > -	system_rev = rcar_gen2_get_cut();
> > +	struct soc_device_attribute *soc_dev_attr;
> > +	struct soc_device *soc_dev;
> > +	struct device *parent = NULL;
> > +	u32 prr;
> > +
> > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > +	if (!soc_dev_attr)
> > +		goto out;
> > +
> > +	prr = rcar_gen2_get_prr();
> > +	system_rev = (prr & 0xFF) + 0x10;
> > +
> > +	soc_dev_attr->machine = of_flat_dt_get_machine_name();
> 
> I would not duplicate that information here. Can you find out the SoC
> name from registers and put it here?
> 
> 	ARnd
> 
