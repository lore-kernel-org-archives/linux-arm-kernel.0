From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Thu, 27 Oct 2016 04:34:06 +0000
Subject: [v12, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <1477501566.6812.9.camel@buserror.net>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
 <1474441040-11946-6-git-send-email-yangbo.lu@nxp.com>
 <1477501566.6812.9.camel@buserror.net>
Message-ID: <DB6PR0401MB25362658D117DF4D7B92FD48F8AA0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,


> -----Original Message-----
> From: Scott Wood [mailto:oss at buserror.net]
> Sent: Thursday, October 27, 2016 1:06 AM
> To: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Arnd
> Bergmann
> Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; Mark Rutland; Rob Herring;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie; M.H.
> Lian
> Subject: Re: [v12, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> 
> On Wed, 2016-09-21 at 14:57 +0800, Yangbo Lu wrote:
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig new
> > file mode 100644 index 0000000..b99764c
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -0,0 +1,19 @@
> > +#
> > +# Freescale SOC drivers
> > +#
> > +
> > +source "drivers/soc/fsl/qe/Kconfig"
> > +
> > +config FSL_GUTS
> > +	bool "Freescale QorIQ GUTS driver"
> > +	select SOC_BUS
> > +	help
> > +	??The global utilities block controls power management, I/O device
> > +	??enabling, power-onreset(POR) configuration monitoring, alternate
> > +	??function selection for multiplexed signals,and clock control.
> > +	??This driver is to manage and access global utilities block.
> > +	??Initially only reading SVR and registering soc device are
> > supported.
> > +	??Other guts accesses, such as reading RCW, should eventually be
> > moved
> > +	??into this driver as well.
> > +
> > +	??If you want GUTS driver support, you should say Y here.
> 
> This is user-enablable without dependencies, which means it will break
> some randconfigs. ?If this is to be enabled via select then remove the
> text after "bool".

[Lu Yangbo-B47093] Will enable it via select and remove text after 'bool'.
 
> 
> > +/* SoC die attribute definition for QorIQ platform */ static const
> > +struct fsl_soc_die_attr fsl_soc_die[] = { #ifdef CONFIG_PPC
> > +	/*
> > +	?* Power Architecture-based SoCs T Series
> > +	?*/
> > +
> > +	/* Die: T4240, SoC: T4240/T4160/T4080 */
> > +	{ .die		= "T4240",
> > +	??.svr		= 0x82400000,
> > +	??.mask		= 0xfff00000,
> > +	},
> > +	/* Die: T1040, SoC: T1040/T1020/T1042/T1022 */
> > +	{ .die		= "T1040",
> > +	??.svr		= 0x85200000,
> > +	??.mask		= 0xfff00000,
> > +	},
> > +	/* Die: T2080, SoC: T2080/T2081 */
> > +	{ .die		= "T2080",
> > +	??.svr		= 0x85300000,
> > +	??.mask		= 0xfff00000,
> > +	},
> > +	/* Die: T1024, SoC: T1024/T1014/T1023/T1013 */
> > +	{ .die		= "T1024",
> > +	??.svr		= 0x85400000,
> > +	??.mask		= 0xfff00000,
> > +	},
> > +#endif /* CONFIG_PPC */
> > +#if defined(CONFIG_ARCH_MXC) || defined(CONFIG_ARCH_LAYERSCAPE)
> 
> Will this driver ever be probed on MXC? ?Why do we need these ifdefs at
> all?

[Lu Yangbo-B47093] Will remove them. In the previous version, we use too many members for soc definition, so I add #ifdef for ARCH. 
CONFIG_ARCH_MXC was for ls1021a.

> 
> 
> > +	/*
> > +	?* ARM-based SoCs LS Series
> > +	?*/
> > +
> > +	/* Die: LS1043A, SoC: LS1043A/LS1023A */
> > +	{ .die		= "LS1043A",
> > +	??.svr		= 0x87920000,
> > +	??.mask		= 0xffff0000,
> > +	},
> > +	/* Die: LS2080A, SoC: LS2080A/LS2040A/LS2085A */
> > +	{ .die		= "LS2080A",
> > +	??.svr		= 0x87010000,
> > +	??.mask		= 0xff3f0000,
> > +	},
> > +	/* Die: LS1088A, SoC: LS1088A/LS1048A/LS1084A/LS1044A */
> > +	{ .die		= "LS1088A",
> > +	??.svr		= 0x87030000,
> > +	??.mask		= 0xff3f0000,
> > +	},
> > +	/* Die: LS1012A, SoC: LS1012A */
> > +	{ .die		= "LS1012A",
> > +	??.svr		= 0x87040000,
> > +	??.mask		= 0xffff0000,
> > +	},
> > +	/* Die: LS1046A, SoC: LS1046A/LS1026A */
> > +	{ .die		= "LS1046A",
> > +	??.svr		= 0x87070000,
> > +	??.mask		= 0xffff0000,
> > +	},
> > +	/* Die: LS2088A, SoC: LS2088A/LS2048A/LS2084A/LS2044A */
> > +	{ .die		= "LS2088A",
> > +	??.svr		= 0x87090000,
> > +	??.mask		= 0xff3f0000,
> > +	},
> > +	/* Die: LS1021A, SoC: LS1021A/LS1020A/LS1022A
> > +	?* Note: Put this die at the end in cause of incorrect
> > identification
> > +	?*/
> > +	{ .die		= "LS1021A",
> > +	??.svr		= 0x87000000,
> > +	??.mask		= 0xfff00000,
> > +	},
> > +#endif /* CONFIG_ARCH_MXC || CONFIG_ARCH_LAYERSCAPE */
> 
> Instead of relying on ordering, add more bits to the mask so that there's
> no overlap. ?I think 0xfff70000 would work.

[Lu Yangbo-B47093] Ok, Will do that. Then we add 3 bits of 'Various Personalities' field for ls1021a die identification.

> 
> > +out:
> > +	kfree(soc_dev_attr.machine);
> > +	kfree(soc_dev_attr.family);
> > +	kfree(soc_dev_attr.soc_id);
> > +	kfree(soc_dev_attr.revision);
> > +	iounmap(guts->regs);
> > +out_free:
> > +	kfree(guts);
> > +	return ret;
> > +}
> 
> Please use devm.

[Lu Yangbo-B47093] Sorry for forgetting this. Will do that and send out the new version soon.
Thanks for your comments.

> 
> -Scott
