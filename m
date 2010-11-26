From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Nov 2010 09:28:02 +0100
Subject: [PATCH] mc13892 regulator enable on mx51 babbage board
In-Reply-To: <AANLkTinV3EUwfiFHz6KmMAYfmMEH21mAX6R8pCFLTdee@mail.gmail.com>
References: <AANLkTinZM=hxidn1gcwxA4yFaO2QjdjDdoF-tZRJuP0n@mail.gmail.com>
	<AANLkTinV3EUwfiFHz6KmMAYfmMEH21mAX6R8pCFLTdee@mail.gmail.com>
Message-ID: <20101126082802.GX6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Thu, Nov 25, 2010 at 06:04:38PM +0800, Yong Shen wrote:
> Hi there,
> 
> This is the draft patch for mc13892 regulator.
> I send out this patch by copy and paste, since I can not use git
> send-email due to the firewall. sorry for inconvenient.
> 
> Cheers
> Yong

Only a few minor comments inline. My main concern is that the functions
like mc13892_regulator_enable/disable and so on should be shared with
the mc13783. This will require some cleanup patches first. The first
patch could move all functions from mc13783-regulator.c to
mc13xxx-regulator-core.c leaving only the tables describing the
regulators in mc13783-regulator.c. Then you can rename the functions to
mc13xxx-*. The last step would be to actually add mc13892 support in
mc13892-regulator.c
The trick doing such work is to cleanup *first* and then add the missing
functionality and not the other way round. The reviewers then will see
'Oh, someones cleaning up' and get a warm nice feeling which opens them
to the changes you really want to do. (I often also work the other way
round, but git makes it easy to rebase the patches to pretend I cleaned
up first)


> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 026cd85..1594c9f 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -6,7 +6,7 @@
> ?obj-y ? := cpu.o mm.o clock-mx51-mx53.o devices.o
> 
> ?obj-$(CONFIG_CPU_FREQ_IMX) ? ?+= cpu_op-mx51.o
> -obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
> +obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
> babbage_regulator_mc13892.o
> ?obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
> ?obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
> ?obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
> diff --git a/arch/arm/mach-mx5/babbage_regulator_mc13892.c

This file should be named after the babbage file so that it appears next
to the babbage board support in ls, so something like
board-mx51_babbage_regulator.c
Also, please seperate the patches a bit more. We need at least core
mc13892 support, regulator support and board support as seperate
patches.


> +
> +#define MC13892_POWERCTL0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?13
> +#define MC13892_POWERCTL0_USEROFFSPI ? ? ? ? ? 3
> +#define MC13892_POWERCTL0_VCOINCELLVSEL ? ? ? ? ? ? ? ?20
> +#define MC13892_POWERCTL0_VCOINCELLVSEL_M ? ? ? ? ? ? ?(7<<20)
> +#define MC13892_POWERCTL0_VCOINCELLEN ? ? ? ? ?(1<<23)
> +
> +#define MC13892_SWITCHERS0_SWxHI ? ? ? ? ? ? ? ? ? ? ? (1<<23)
> +
> +#define MC13892_SWITCHERS0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 24
> +#define MC13892_SWITCHERS0_SW1VSEL ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS0_SW1VSEL_M ? ? ? ? ? (0x1f<<0)
> +#define MC13892_SWITCHERS0_SW1HI ? ? ? ? ? ? ? ? ? ? ? (1<<23)
> +#define MC13892_SWITCHERS0_SW1EN ? ? ? ? ? ? ? 0 /*no use*/
> +
> +#define MC13892_SWITCHERS1 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 25
> +#define MC13892_SWITCHERS1_SW2VSEL ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS1_SW2VSEL_M ? ? ? ? ? (0x1f<<0)
> +#define MC13892_SWITCHERS1_SW2HI ? ? ? ? ? ? ? ? ? ? ? (1<<23)
> +#define MC13892_SWITCHERS1_SW2EN ? ? ? ? ? ? ? 0 /*no use*/
> +
> +#define MC13892_SWITCHERS2 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 26
> +#define MC13892_SWITCHERS2_SW3VSEL ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS2_SW3VSEL_M ? ? ? ? ? (0x1f<<0)
> +#define MC13892_SWITCHERS2_SW3HI ? ? ? ? ? ? ? ? ? ? ? (1<<23)
> +#define MC13892_SWITCHERS2_SW3EN ? ? ? ? ? ? ? 0/*no use*/
> +
> +#define MC13892_SWITCHERS3 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 27
> +#define MC13892_SWITCHERS3_SW4VSEL ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS3_SW4VSEL_M ? ? ? ? ? (0x1f<<0)
> +#define MC13892_SWITCHERS3_SW4HI ? ? ? ? ? ? ? ? ? ? ? (1<<23)
> +#define MC13892_SWITCHERS3_SW4EN ? ? ? ? ? ? ? 0/*no use*/
> +
> +#define MC13892_SWITCHERS4 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 28
> +#define MC13892_SWITCHERS4_SW1MODE ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS4_SW1MODE_AUTO ? ? ? ? ? ? ? ?(8<<0)
> +#define MC13892_SWITCHERS4_SW1MODE_M ? ? ? ? ? (0xf<<0)
> +#define MC13892_SWITCHERS4_SW2MODE ? ? ? ? ? ? ? ? ? ? 10
> +#define MC13892_SWITCHERS4_SW2MODE_AUTO ? ? ? ? ? ? ? ?(8<<10)
> +#define MC13892_SWITCHERS4_SW2MODE_M ? ? ? ? ? (0xf<<10)
> +
> +#define MC13892_SWITCHERS5 ? ? ? ? ? ? ? ? ? ? ? ? ? ? 29
> +#define MC13892_SWITCHERS5_SW3MODE ? ? ? ? ? ? ? ? ? ? 0
> +#define MC13892_SWITCHERS5_SW3MODE_AUTO ? ? ? ? ? ? ? ?(8<<0)
> +#define MC13892_SWITCHERS5_SW3MODE_M ? ? ? ? ? (0xf<<0)
> +#define MC13892_SWITCHERS5_SW4MODE ? ? ? ? ? ? ? ? ? ? 8
> +#define MC13892_SWITCHERS5_SW4MODE_AUTO ? ? ? ? ? ? ? ?(8<<8)
> +#define MC13892_SWITCHERS5_SW4MODE_M ? ? ? ? ? (0xf<<8)
> +#define MC13892_SWITCHERS5_SWBSTEN ? ? ? ? ? ? ? ? ? ? (1<<20)

Please add some spaces here. It should be (0xf << 8) and /* comment */.

> +static struct mc13xxx_regulator mc13892_regulators[] = {
> + ? ? ? MC13892_DEFINE_REGU(VCOINCELL, POWERCTL0, POWERCTL0, ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vcoincell),
> + ? ? ? MC13892_SW_DEFINE(SW1, SWITCHERS0, SWITCHERS0, mc13892_sw1),
> + ? ? ? MC13892_SW_DEFINE(SW2, SWITCHERS1, SWITCHERS1, mc13892_sw),
> + ? ? ? MC13892_SW_DEFINE(SW3, SWITCHERS2, SWITCHERS2, mc13892_sw),
> + ? ? ? MC13892_SW_DEFINE(SW4, SWITCHERS3, SWITCHERS3, mc13892_sw),
> + ? ? ? MC13892_FIXED_DEFINE(SWBST, SWITCHERS5, mc13892_swbst),
> + ? ? ? MC13892_FIXED_DEFINE(VIOHI, REGULATORMODE0, mc13892_viohi),
> + ? ? ? MC13892_DEFINE_REGU(VPLL, REGULATORMODE0, REGULATORSETTING0, ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vpll),
> + ? ? ? MC13892_DEFINE_REGU(VDIG, REGULATORMODE0, REGULATORSETTING0, ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vdig),
> + ? ? ? MC13892_DEFINE_REGU(VSD, REGULATORMODE1, REGULATORSETTING1, ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vsd),
> + ? ? ? MC13892_DEFINE_REGU(VUSB2, REGULATORMODE0, REGULATORSETTING0, ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vusb2),
> + ? ? ? MC13892_DEFINE_REGU(VVIDEO, REGULATORMODE1, REGULATORSETTING1, ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vvideo),
> + ? ? ? MC13892_DEFINE_REGU(VAUDIO, REGULATORMODE1, REGULATORSETTING1, ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vaudio),
> + ? ? ? MC13892_DEFINE_REGU(VCAM, REGULATORMODE1, REGULATORSETTING0, \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vcam),
> + ? ? ? MC13892_DEFINE_REGU(VGEN1, REGULATORMODE0, REGULATORSETTING0, ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vgen1),
> + ? ? ? MC13892_DEFINE_REGU(VGEN2, REGULATORMODE0, REGULATORSETTING0, ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vgen2),
> + ? ? ? MC13892_DEFINE_REGU(VGEN3, REGULATORMODE1, REGULATORSETTING0, ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? mc13892_vgen3),

For my taste that's a case where the 80 chars line length limit could be
a bit stretched. But others may have different opinions.

Most of the code below shouldn't be here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
