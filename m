From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 May 2013 10:31:08 +0100
Subject: arm64: Platform devices populated from a device_initcall
In-Reply-To: <519112E7.3040309@synopsys.com>
References: <519112E7.3040309@synopsys.com>
Message-ID: <20130514093108.GA15129@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Mon, May 13, 2013 at 05:20:55PM +0100, Benoit Lecardonnel wrote:
> In the arm64 kernel, function arm64_device_probe 
> (arch/arm64/kernel/setup.c) is in charge of populating the platform 
> devices defined by the device tree.
> 
> Does anyone know why arm64_device_probe is a device_initcall?

It had to be somewhere after arch_initcall used by vexpress clocks
(but now I do it in arm64_of_clk_init()). The of_clk_init needs to be
after a core_inicall used by the vexpress sysreg initialisation.

> This seems to be in conflict with some I2C drivers: see 
> drivers/i2c/busses/i2c-designware-platdrv.c for example.
> The driver calls platform_driver_probe from a subsys_initcall.
> The probe fails because subsys_initcalls are executed before 
> device_initcalls.

Ah, this driver doesn't use platform_driver_register() but probe
directly, so it needs the platform devices to be populated.

> Maybe arm64_device_probe could be an arch_initcall?

I think we could put of_clk_init() and of_platform_populate() calls
under the same arch_initcall() just to keep their relative order.
Something like this (could even use arch_initcall_sync in case we get
some other arch_initcall in the future):


diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 6a9a532..add6ea6 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -282,12 +282,13 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
-static int __init arm64_of_clk_init(void)
+static int __init arm64_device_init(void)
 {
 	of_clk_init(NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	return 0;
 }
-arch_initcall(arm64_of_clk_init);
+arch_initcall(arm64_device_init);
 
 static DEFINE_PER_CPU(struct cpu, cpu_data);
 
@@ -305,13 +306,6 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
-static int __init arm64_device_probe(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-device_initcall(arm64_device_probe);
-
 static const char *hwcap_str[] = {
 	"fp",
 	"asimd",
