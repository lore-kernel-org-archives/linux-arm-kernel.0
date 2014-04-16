From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Apr 2014 19:25:31 +0200
Subject: [PATCH Resend] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <5721231.s2ATyWsK21@wuerfel>
References: <1397649051-3288-1-git-send-email-sachin.kamat@linaro.org>
 <5721231.s2ATyWsK21@wuerfel>
Message-ID: <1493367.CDjMd4ghZP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 16. April 2014, 16:35:36 schrieb Arnd Bergmann:
> On Wednesday 16 April 2014 17:20:51 Sachin Kamat wrote:
> > Instead of hardcoding the SYSRAM details for each SoC,
> > pass this information through device tree (DT) and make
> > the code SoC agnostic.
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> > Rebased on latest linux-next.
> 
> Thanks for sending this again. I'd like Heiko to have a look
> and provide an Ack if he's happy with it.
> 
> It seems similar to what he did with the SRAM for mach-rockchip,
> and if it is we should use the same binding that he introduced,
> which would be a minor variation of this.

The sram binding is derived from the generic reserved-memory bindings to 
enable the sram in general to be used generically through the sram driver, 
while still retaining some areas for special purposes, like the smp-trampoline 
in my case.

>From my reading of platsmp.c, it looks like offset+0x4 starts the so called 
boot-registesr, which get the smp-start-address written to.

So I guess it all depends on what is contained in the rest of the sysram. If 
it is all covered with such special registers or other special uses, the code 
below is fine. But if the most of the area is just general purpose sram, a 
solution like on rockchip might be nicer - i.e. handling the sysram via the 
sram driver and declaring a reserved section for the boot registers.

So, depending on the above:
Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> 
> 	Arnd
> 
> >  .../devicetree/bindings/arm/samsung-boards.txt     |   11 +++
> >  arch/arm/boot/dts/exynos4210-universal_c210.dts    |    9 ++
> >  arch/arm/boot/dts/exynos4210.dtsi                  |   10 ++
> >  arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++
> >  arch/arm/boot/dts/exynos5.dtsi                     |    5 +
> >  arch/arm/boot/dts/exynos5250.dtsi                  |    5 +
> >  arch/arm/boot/dts/exynos5420.dtsi                  |    5 +
> >  arch/arm/mach-exynos/exynos.c                      |  104
> >  ++++++++------------ arch/arm/mach-exynos/include/mach/map.h           
> >  |    7 --
> >  9 files changed, 95 insertions(+), 71 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > b/Documentation/devicetree/bindings/arm/samsung-boards.txt index
> > 2168ed31e1b0..f79710eb7e79 100644
> > --- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > 
> > @@ -7,6 +7,17 @@ Required root node properties:
> >          (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
> >          (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
> > 
> > +    - sysram node, specifying the type (secure or non-secure) of SYSRAM
> > +	- compatible: following types are supported
> > +		"samsung,exynos4210-sysram" : Secure SYSRAM
> > +		"samsung,exynos4210-sysram-ns" : Non-secure SYSRAM
> > +	- reg: address of SYSRAM bank
> > +
> > +	sysram at 02020000 {
> > +		compatible = "samsung,exynos4210-sysram";
> > +		reg = <0x02020000 0x1000>;
> > +	};
> > +
> > 
> >  Optional:
> >      - firmware node, specifying presence and type of secure firmware:
> >          - compatible: only "samsung,secure-firmware" is currently
> >          supported
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > b/arch/arm/boot/dts/exynos4210-universal_c210.dts index
> > 63e34b24b04f..cf4158728108 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -28,6 +28,15 @@
> > 
> >  		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw 
rootwait
> >  		earlyprintk panic=5 maxcpus=1";>  	
> >  	};
> > 
> > +	sysram at 02020000 {
> > +		status = "disabled";
> > +	};
> > +
> > +	sysram at 02025000 {
> > +		compatible = "samsung,exynos4210-sysram";
> > +		reg = <0x02025000 0x1000>;
> > +	};
> > +
> > 
> >  	mct at 10050000 {
> >  	
> >  		compatible = "none";
> >  	
> >  	};
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> > b/arch/arm/boot/dts/exynos4210.dtsi index cacf6140dd2f..a3f4bba099e6
> > 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -31,6 +31,16 @@
> > 
> >  		pinctrl2 = &pinctrl_2;
> >  	
> >  	};
> > 
> > +	sysram at 02020000 {
> > +		compatible = "samsung,exynos4210-sysram";
> > +		reg = <0x02020000 0x1000>;
> > +	};
> > +
> > +	sysram-ns at 0203F000 {
> > +		compatible = "samsung,exynos4210-sysram-ns";
> > +		reg = <0x0203F000 0x1000>;
> > +	};
> > +
> > 
> >  	pd_lcd1: lcd1-power-domain at 10023CA0 {
> >  	
> >  		compatible = "samsung,exynos4210-pd";
> >  		reg = <0x10023CA0 0x20>;
> > 
> > diff --git a/arch/arm/boot/dts/exynos4x12.dtsi
> > b/arch/arm/boot/dts/exynos4x12.dtsi index c4a9306f8529..d57e3120223f
> > 100644
> > --- a/arch/arm/boot/dts/exynos4x12.dtsi
> > +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> > @@ -37,6 +37,16 @@
> > 
> >  		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
> >  	
> >  	};
> > 
> > +	sysram at 02020000 {
> > +		compatible = "samsung,exynos4210-sysram";
> > +		reg = <0x02020000 0x1000>;
> > +	};
> > +
> > +	sysram-ns at 0204F000 {
> > +		compatible = "samsung,exynos4210-sysram-ns";
> > +		reg = <0x0204F000 0x1000>;
> > +	};
> > +
> > 
> >  	pd_isp: isp-power-domain at 10023CA0 {
> >  	
> >  		compatible = "samsung,exynos4210-pd";
> >  		reg = <0x10023CA0 0x20>;
> > 
> > diff --git a/arch/arm/boot/dts/exynos5.dtsi
> > b/arch/arm/boot/dts/exynos5.dtsi index 79d0608d6dcc..c03bd09ec37d 100644
> > --- a/arch/arm/boot/dts/exynos5.dtsi
> > +++ b/arch/arm/boot/dts/exynos5.dtsi
> > @@ -18,6 +18,11 @@
> > 
> >  / {
> >  
> >  	interrupt-parent = <&gic>;
> > 
> > +	sysram at 02020000 {
> > +		compatible = "samsung,exynos4210-sysram";
> > +		reg = <0x02020000 0x1000>;
> > +	};
> > +
> > 
> >  	chipid at 10000000 {
> >  	
> >  		compatible = "samsung,exynos4210-chipid";
> >  		reg = <0x10000000 0x100>;
> > 
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> > b/arch/arm/boot/dts/exynos5250.dtsi index 37423314a028..bae6c3f253f0
> > 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -72,6 +72,11 @@
> > 
> >  		};
> >  	
> >  	};
> > 
> > +	sysram-ns at 0204F000 {
> > +		compatible = "samsung,exynos4210-sysram-ns";
> > +		reg = <0x0204F000 0x1000>;
> > +	};
> > +
> > 
> >  	pd_gsc: gsc-power-domain at 10044000 {
> >  	
> >  		compatible = "samsung,exynos4210-pd";
> >  		reg = <0x10044000 0x20>;
> > 
> > diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> > b/arch/arm/boot/dts/exynos5420.dtsi index c3a9a66c5767..217376fe1d82
> > 100644
> > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > @@ -110,6 +110,11 @@
> > 
> >  		};
> >  	
> >  	};
> > 
> > +	sysram-ns at 02073000 {
> > +		compatible = "samsung,exynos4210-sysram-ns";
> > +		reg = <0x02073000 0x1000>;
> > +	};
> > +
> > 
> >  	clock: clock-controller at 10010000 {
> >  	
> >  		compatible = "samsung,exynos5420-clock";
> >  		reg = <0x10010000 0x30000>;
> > 
> > diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> > index b32a907d021d..6a5fe18ec9b1 100644
> > --- a/arch/arm/mach-exynos/exynos.c
> > +++ b/arch/arm/mach-exynos/exynos.c
> > @@ -114,51 +114,6 @@ static struct map_desc exynos4_iodesc[] __initdata =
> > {
> > 
> >  	},
> >  
> >  };
> > 
> > -static struct map_desc exynos4_iodesc0[] __initdata = {
> > -	{
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM,
> > -		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	},
> > -};
> > -
> > -static struct map_desc exynos4_iodesc1[] __initdata = {
> > -	{
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM,
> > -		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	},
> > -};
> > -
> > -static struct map_desc exynos4210_iodesc[] __initdata = {
> > -	{
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
> > -		.pfn		= __phys_to_pfn(EXYNOS4210_PA_SYSRAM_NS),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	},
> > -};
> > -
> > -static struct map_desc exynos4x12_iodesc[] __initdata = {
> > -	{
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
> > -		.pfn		= __phys_to_pfn(EXYNOS4x12_PA_SYSRAM_NS),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	},
> > -};
> > -
> > -static struct map_desc exynos5250_iodesc[] __initdata = {
> > -	{
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
> > -		.pfn		= __phys_to_pfn(EXYNOS5250_PA_SYSRAM_NS),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	},
> > -};
> > -
> > 
> >  static struct map_desc exynos5_iodesc[] __initdata = {
> >  
> >  	{
> >  	
> >  		.virtual	= (unsigned long)S3C_VA_SYS,
> > 
> > @@ -181,11 +136,6 @@ static struct map_desc exynos5_iodesc[] __initdata =
> > {
> > 
> >  		.length		= SZ_4K,
> >  		.type		= MT_DEVICE,
> >  	
> >  	}, {
> > 
> > -		.virtual	= (unsigned long)S5P_VA_SYSRAM,
> > -		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSRAM),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	}, {
> > 
> >  		.virtual	= (unsigned long)S5P_VA_CMU,
> >  		.pfn		= __phys_to_pfn(EXYNOS5_PA_CMU),
> >  		.length		= 144 * SZ_1K,
> > 
> > @@ -268,6 +218,44 @@ static int __init exynos_fdt_map_chipid(unsigned long
> > node, const char *uname,> 
> >  	return 1;
> >  
> >  }
> > 
> > +struct __sysram_desc {
> > +	char name[32];
> > +	unsigned long addr;
> > +};
> > +
> > +static struct __sysram_desc sysram_desc[] __initdata = {
> > +	{
> > +		.name = "samsung,exynos4210-sysram",
> > +		.addr = (unsigned long)S5P_VA_SYSRAM,
> > +	}, {
> > +		.name = "samsung,exynos4210-sysram-ns",
> > +		.addr = (unsigned long)S5P_VA_SYSRAM_NS,
> > +	},
> > +};
> > +
> > +static int __init exynos_fdt_map_sysram(unsigned long node, const char
> > *uname, +					int depth, void *data)
> > +{
> > +	struct map_desc iodesc;
> > +	__be32 *reg;
> > +	unsigned long len;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sysram_desc); i++) {
> > +		if (of_flat_dt_is_compatible(node, sysram_desc[i].name)) {
> > +			reg = of_get_flat_dt_prop(node, "reg", &len);
> > +			if (!reg || len != (sizeof(unsigned long) * 2))
> > +				return -ENODEV;
> > +			iodesc.virtual = sysram_desc[i].addr;
> > +			iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
> > +			iodesc.length = be32_to_cpu(reg[1]);
> > +			iodesc.type = MT_DEVICE;
> > +			iotable_init(&iodesc, 1);
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > 
> >  /*
> >  
> >   * exynos_map_io
> >   *
> > 
> > @@ -280,20 +268,6 @@ static void __init exynos_map_io(void)
> > 
> >  	if (soc_is_exynos5())
> >  	
> >  		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
> > 
> > -
> > -	if (soc_is_exynos4210()) {
> > -		if (samsung_rev() == EXYNOS4210_REV_0)
> > -			iotable_init(exynos4_iodesc0,
> > -						ARRAY_SIZE(exynos4_iodesc0));
> > -		else
> > -			iotable_init(exynos4_iodesc1,
> > -						ARRAY_SIZE(exynos4_iodesc1));
> > -		iotable_init(exynos4210_iodesc, ARRAY_SIZE(exynos4210_iodesc));
> > -	}
> > -	if (soc_is_exynos4212() || soc_is_exynos4412())
> > -		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
> > -	if (soc_is_exynos5250())
> > -		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
> > 
> >  }
> >  
> >  void __init exynos_init_io(void)
> > 
> > @@ -306,6 +280,8 @@ void __init exynos_init_io(void)
> > 
> >  	s5p_init_cpu(S5P_VA_CHIPID);
> >  	
> >  	exynos_map_io();
> > 
> > +
> > +	of_scan_flat_dt(exynos_fdt_map_sysram, NULL);
> > 
> >  }
> >  
> >  struct bus_type exynos_subsys = {
> > 
> > diff --git a/arch/arm/mach-exynos/include/mach/map.h
> > b/arch/arm/mach-exynos/include/mach/map.h index
> > 7b046b59d9ec..548269a60634 100644
> > --- a/arch/arm/mach-exynos/include/mach/map.h
> > +++ b/arch/arm/mach-exynos/include/mach/map.h
> > @@ -23,13 +23,6 @@
> > 
> >  #include <plat/map-s5p.h>
> > 
> > -#define EXYNOS4_PA_SYSRAM0		0x02025000
> > -#define EXYNOS4_PA_SYSRAM1		0x02020000
> > -#define EXYNOS5_PA_SYSRAM		0x02020000
> > -#define EXYNOS4210_PA_SYSRAM_NS		0x0203F000
> > -#define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
> > -#define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
> > -
> > 
> >  #define EXYNOS_PA_CHIPID		0x10000000
> >  
> >  #define EXYNOS4_PA_SYSCON		0x10010000
