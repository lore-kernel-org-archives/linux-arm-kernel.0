From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 28 Oct 2011 11:17:38 +0300
Subject: [PATCH 2/6] arm/tegra: prepare pinmux code for multiple tegra
	variants
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49AA@HQMAIL01.nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-3-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B49AA@HQMAIL01.nvidia.com>
Message-ID: <20111028081738.GA12383@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 09:59:49PM +0200, Stephen Warren wrote:
> Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> > This patch modifies the pinmux code to be useable for multiple tegra variants.
> > Some tegra20 specific constants will be replaced by variables which will be
> > initialized to the appropriate value at runtime.
> 
> You should probably also mention:
> * Removal of include of pinmux-t2.h from pinmux.h.
> * The file renames you performed and why.
> * The removal of the suspend/resume code and why.
> 
> > diff --git a/arch/arm/mach-tegra/include/mach/pinmux-t2.h b/arch/arm/mach-tegra/include/mach/pinmux-t2.h
> > deleted file mode 100644
> > index 4c26263..0000000
> > --- a/arch/arm/mach-tegra/include/mach/pinmux-t2.h
> > +++ /dev/null
> 
> So this file shows up as a delete and an add. Isn't there a way to get
> it to show up as a rename; I've certainly seen git diff tell me that, but
> I'm not sure if the same feature is available for format-patch. In
> particular, IIRC from internal review, there weren't any changes to this
> file besides direct fallout from the rename, but there were quite a few
> symbol name changes in pinmux-t2-tables.c, and also the removal of
> suspend/resume, which it'd be nice if the diff highlighted.
> 

Hmm. Maybe if I split it in 2 patches? 2 rename and 1 modification?

> > diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
> > index bb7dfdb..8f6e9f3 100644
> > --- a/arch/arm/mach-tegra/include/mach/pinmux.h
> > +++ b/arch/arm/mach-tegra/include/mach/pinmux.h
> ...
> > @@ -219,13 +213,20 @@ struct tegra_pingroup_desc {
> >  	s8 pupd_bit;	/* offset into the PULL_UPDOWN_REG_* register bit */
> >  };
> > 
> > -extern const struct tegra_pingroup_desc tegra_soc_pingroups[];
> > -extern const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[];
> > +struct tegra_pinmux_pm {
> > +	void (*suspend)(void);
> > +	void (*resume)(void);
> > +};
> 
> Since we elected to strip out suspend/resume (it's currently incomplete
> anyway) to simplify the addition of Tegra30, I don't think you need that
> struct type any more.
> 

True :)

> I wonder if removal of the suspend/resume functions should have been a
> separate patch before this?
> 

Good point.

> > diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
> > index 1d20165..0789122 100644
> > --- a/arch/arm/mach-tegra/pinmux.c
> > +++ b/arch/arm/mach-tegra/pinmux.c
> > @@ -21,6 +21,9 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#ifdef CONFIG_OF
> > +#include <linux/of_platform.h>
> > +#endif
> 
> I think just include that without any ifdef.
> 

Thinking of it, probably indeed.

> > @@ -668,11 +668,24 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
> >  	}
> >  }
> > 
> > +static struct of_device_id tegra_pinmux_of_match[] __devinitdata = {
> > +	{ .compatible = "nvidia,tegra20-pinmux", tegra20_pinmux_init },
> > +	{ },
> > +};
> > +
> >  static int __devinit tegra_pinmux_probe(struct platform_device *pdev)
> >  {
> >  	struct resource *res;
> >  	int i;
> >  	int config_bad = 0;
> > +	const struct of_device_id *match;
> > +
> > +#ifdef CONFIG_OF
> > +	match = of_match_device(tegra_pinmux_of_match, &pdev->dev);
> 
> What if match==NULL? I suppose that "can't" happen with DT, since the
> device wouldn't have been probed unless there was a matching entry...
> 

Exactly. That was my reasoning as well. We can't get here unless there is a
match.

> Does this work when booting without DT; IIRC the internal patches I saw
> fell back to hard-coding a call to tegra20_pinmux_init() when booting
> a static board file (i.e. not booting device-tree)? Perhaps that's in a

Unfortunately I don't have a tegra20 board which is supported without
devicetree.

Cheers,

Peter.
