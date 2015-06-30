From: vitalya@ti.com (Vitaly Andrianov)
Date: Tue, 30 Jun 2015 12:38:13 -0400
Subject: [PATCH] keystone: adds cpu_die implementation
In-Reply-To: <20150630145412.GG7557@n2100.arm.linux.org.uk>
References: <1435600352-32733-1-git-send-email-vitalya@ti.com>
 <20150629175223.GC19863@leverpostej> <559191E0.4080808@ti.com>
 <20150629212814.GE7557@n2100.arm.linux.org.uk>
 <20150629213737.GF7557@n2100.arm.linux.org.uk> <55929E0B.9070704@ti.com>
 <20150630145412.GG7557@n2100.arm.linux.org.uk>
Message-ID: <5592C5F5.4020307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/30/2015 10:54 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 30, 2015 at 09:47:55AM -0400, Vitaly Andrianov wrote:
>>
>>
>> On 06/29/2015 05:37 PM, Russell King - ARM Linux wrote:
>>> Oh, it was Murali who tested it, not yourself.  Sorry.  Suggest you
>>> dig out the patches either from mainline (they're in Linus' tip) or
>>> ask Murali for them...
>>>
>> Thanks Russell,
>>
>> Excellent. I'll test how it will work using PSCI framework.
>
> The commits in mainline are:
>
> b2c3e38a5471 ARM: redo TTBR setup code for LPAE
> 1221ed10f2a5 ARM: cleanup early_paging_init() calling
> d8dc7fbd53ee ARM: re-implement physical address space switching
> c0b759d87eab ARM: keystone2: rename init_meminfo to pv_fixup
> 39b74fe82f73 ARM: keystone2: move address space switch printk into generic code
> c8ca2b4b2928 ARM: keystone2: move update of the phys-to-virt constants into generic code
> 30b5f4d6128e ARM: keystone2: move platform notifier initialisation into platform init
>
> There are an additional three which are worthwhile testing with them as
> they clean up this same code (and fix a subtle but very minor bug in the
> errata code paths):
>
> c76f238e261b ARM: proc-v7: sanitise and document registers around errata
> 4419496884ed ARM: proc-v7: clean up MIDR access
> 17e7bf86690e ARM: proc-v7: move CPU errata out of line
>
> So, picking the range b787f68c36d4..c76f238e261b will get all of them.
> (That's v4.1-rc1 to the tip of the branch holding those commits.)
>
I just finished testing. Here is what I did.

1) checkout commit c76f238e261b
2) applied Grygorii's "ARM: psci: boot_secondary: replace __pa with 
virt_to_idmap"
3) applied "keystone: dts: add psci command definition" commit.
This commit is not posted yet. So, here it's content:

diff --git a/arch/arm/boot/dts/keystone.dtsi 
b/arch/arm/boot/dts/keystone.dtsi
index c06542b..ab60fca 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -58,6 +58,14 @@
                              <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
         };

+       psci {
+               compatible      = "arm,psci";
+               method          = "smc";
+               cpu_suspend     = <0x84000001>;
+               cpu_off         = <0x84000002>;
+               cpu_on          = <0x84000003>;
+       };
+
         soc {
                 #address-cells = <1>;
                 #size-cells = <1>;

4) excluded platsmp.c from build

diff --git a/arch/arm/mach-keystone/Makefile 
b/arch/arm/mach-keystone/Makefile
index 25d9239..5cc5ca4 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -3,7 +3,9 @@ obj-y                                   := keystone.o smc.o
  plus_sec := $(call as-instr,.arch_extension sec,+sec)
  AFLAGS_smc.o                           :=-Wa,-march=armv7-a$(plus_sec)

+ifneq ($(CONFIG_ARM_PSCI),y)
  obj-$(CONFIG_SMP)                      += platsmp.o
+endif

  # PM domain driver for Keystone SOCs
  obj-$(CONFIG_ARCH_KEYSTONE)            += pm_domain.o
diff --git a/arch/arm/mach-keystone/keystone.c 
b/arch/arm/mach-keystone/keystone.c
index e2880105..9cc489c 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -105,7 +105,9 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
  #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
         .dma_zone_size  = SZ_2G,
  #endif
+#ifndef CONFIG_ARM_PSCI
         .smp            = smp_ops(keystone_smp_ops),
+#endif
         .init_machine   = keystone_init,
         .dt_compat      = keystone_match,
         .pv_fixup       = keystone_pv_fixup,

5) enabled CONFIG_ARM_PSCI and CONFIG_HOTPLUG_CPU

The K2HK EVM booted fine with all 4 CPUs on.
The HOTPLUG also works fine. I was able to get CPUs off and on multiple 
times.

Thanks,
Vitaly
