From: horms@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 09:30:32 +0900
Subject: [PATCH 4/5] ARM: shmobile: ape6evm: add MMCIF support
In-Reply-To: <51F7B8B0.3080201@cogentembedded.com>
References: <cover.1375174556.git.horms+renesas@verge.net.au>
 <8711613252ed931037f9e9f8646935519dd8f362.1375174556.git.horms+renesas@verge.net.au>
 <51F7B8B0.3080201@cogentembedded.com>
Message-ID: <20130731003032.GE17209@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:59:28PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 30-07-2013 13:00, Simon Horman wrote:
> 
> >From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> >Add MMCIF support to the APE6EVM board in PIO mode only. Power supply is
> >fixed for now, eventually support for the tps80032 regulator, also
> >supplying both VDD and VccQ to the MMCIF slot should be added to APE6EVM.
> 
> >Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >Acked-by: Magnus Damm <damm@opensource.se>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/board-ape6evm.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> >index af6dd39..8c7529c 100644
> >--- a/arch/arm/mach-shmobile/board-ape6evm.c
> >+++ b/arch/arm/mach-shmobile/board-ape6evm.c
> [...]
> >@@ -54,6 +56,25 @@ static const struct smsc911x_platform_config lan9220_data = {
> [...]
> >+/* MMCIF */
> >+static struct sh_mmcif_plat_data mmcif0_pdata = {
> >+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> >+};
> >+
> >+static struct resource mmcif0_resources[] = {
> >+	DEFINE_RES_MEM_NAMED(0xee200000, 0x100, "MMCIF0"),
> >+	DEFINE_RES_IRQ(gic_spi(169)),
> >+};
> >+
> 
>    The above needed '__initdata' too. And I have only noticed...

Thanks again Sergei.

Guennadi,

as I have already queued-up this patch could you please
make an incremental patch that adds __initdata to the above structures?

> >  static const struct pinctrl_map ape6evm_pinctrl_map[] = {
> >  	/* SCIFA0 console */
> >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
> [...]
> >@@ -93,6 +119,11 @@ static void __init ape6evm_add_standard_devices(void)
> >  	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
> >  					  lan9220_res, ARRAY_SIZE(lan9220_res),
> >  					  &lan9220_data, sizeof(lan9220_data));
> >+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
> >+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
> >+	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
> >+					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
> >+					  &mmcif0_pdata, sizeof(mmcif0_pdata));
> >  }
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
