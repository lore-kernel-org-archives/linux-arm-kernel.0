From: u@pkh.me (=?utf-8?B?Q2zDqW1lbnQgQsWTc2No?=)
Date: Sun, 16 Jul 2017 12:05:37 +0200
Subject: Questions about PMU counters
Message-ID: <20170716100537.GA15094@golem.pkh.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a few questions about the PMU counters I couldn't get anywhere
else. Hopefully this is the right place.


1. Device-Tree: pmu vs arm-pmu
==============================

Documentation/devicetree/bindings/arm/pmu.txt is documenting "pmu" as
identifier, but both "arm-pmu" and "pmu" seems to be used interchangeably
in the codebase in both arch/{arm,arm64}.

While most of the codebase seems to use "pmu", drivers/perf/arm_pmu.c is
also checking for the exact "arm-pmu" string.

Q: what is the difference between the two?


2. Userspace access
===================

An RFC patch was sent a few years ago to allows userspace access to the
PMU counters: https://patchwork.kernel.org/patch/5217341/

AFAICT, this was not mainlined as a module or the suggested sysfs control.
I tried to contact the author of this patch but got no answer.

The perf API may be considered good enough for end users, but some
projects have their own benchmarking framework which they want
cross-platform, with as little overhead as possible (FFmpeg is one of
them).

Currently, the only workaround seems to use this lost module, which
"recently" got arm64 support: https://github.com/zhiyisun/enable_arm_pmu/
I confirm it's working on various boards I tested, but it's still not
ideal (typically, it's breaking badly if perf is used at the same time).

Q: did anything come out of this, is there any plan, or is there a
decision to not doing this?


3. ACPU controller for the Hikey
================================

This question is specific to the Hikey (hisilicon/hi6220-hikey.dts).

While I was able to get PMU counters access through enable_arm_pmu with
most of my boards, it made no difference for the Hikey. So I was under the
impression that the board needs a special treatment to enable these PMU
counters.

Anyway, according the specifications, there is an ACPU interrupt
ACPU_PMUIRQ_intr=131 (so SPI 99) "combined interrupt of the eight core
CoreSight interrupts of the two clusters of the ACPU)."

Just in case, I naively attempted:

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 470461ddd427..98fb2c775540 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -171,6 +171,11 @@
                CLUSTER1_L2: l2-cache1 {
                        compatible = "cache";
                };
+
+               pmu {
+                       compatible = "arm,armv8-pmuv3";
+                       interrupts = <GCI_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+               };
        };
 
        cpu_opp_table: cpu_opp_table {

But it didn't make any difference.

Q: any idea where I can find more information on this? I couldn't get any help
   from 96boards.


4. Quick questions
==================

Q: Where can I find the "interrupt" parser of the device-tree? (I'm trying
   to verify I understand correctly how exactly is handled 1, 2 and 3
   parameters forms).

Q: rpi3 seems to have perf counters in 32-bit but not in 64-bit. I don't
   understand why: they seem to both share the same device-tree. Oh, and
   that bcm2837 doesn't seem to even have pmu declared, so I'm confused.

Q: Why "v3" in "armv8-pmuv3"?

Q: I watched an old talk about device trees, and one of the main issue seemed
   to be the impossibility to keep API/ABI compatibility forever. What came out
   of this wrt the process of defining how to write device trees?


Note: as you probably guessed, I'm completely new to all this stuff, so if you
can answer at least one of these questions, this will probably help me a lot
finding my way in the forest.


Thanks,

-- 
Cl?ment B.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170716/c021857b/attachment-0001.sig>
