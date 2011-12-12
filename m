From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Dec 2011 09:22:32 +0100
Subject: [PATCH 1/2] ARM: only look for TCM on ARM926 and later
In-Reply-To: <20111211102346.GS14542@n2100.arm.linux.org.uk>
References: <1323297616-22865-1-git-send-email-linus.walleij@linaro.org>
 <20111211102346.GS14542@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda2WM1h2cyaPL8eH2b_BuMTd-MkXOh1BymoXLr9hPM7uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 11:23 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Maybe we want to change to a different approach - rule out all
> architectures prior to ARMv5 (which will include ARM920T etc). ?I think
> it is a safe assumption to make that anything older than ARMv5 will not
> have TCM.
>
> ? ? ? ?if (cpu_architecture() < CPU_ARCH_ARMv5)
> ? ? ? ? ? ? ? ?return;

Yes this is way better, thanks Russell!

I've rewritten it like this and I'll replace the patch in the patch tracker
ASAP:

>From 5da56ebc51d4116fe6dbdbff770c31b52e01b9d4 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Dec 2011 23:40:16 +0100
Subject: [PATCH] ARM: only look for TCM on ARM926 and later

The Integrator AP/CP can have a varying set of core modules, some
(like ARM920T) are so old that trying to read the TCM status register
with CP15 will make them hang. So we need to make sure that we are
running on 926 or later in order to be able to activate this for
the Integrator. (The Integrator with CM926EJ-S has 32+32 kb of TCM
memory.)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/tcm.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 30e302d..01ec453 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -180,9 +180,9 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
  */
 void __init tcm_init(void)
 {
-       u32 tcm_status = read_cpuid_tcmstatus();
-       u8 dtcm_banks = (tcm_status >> 16) & 0x03;
-       u8 itcm_banks = (tcm_status & 0x03);
+       u32 tcm_status;
+       u8 dtcm_banks;
+       u8 itcm_banks;
        size_t dtcm_code_sz = &__edtcm_data - &__sdtcm_data;
        size_t itcm_code_sz = &__eitcm_text - &__sitcm_text;
        char *start;
@@ -191,6 +191,22 @@ void __init tcm_init(void)
        int ret;
        int i;

+       /*
+        * Prior to ARMv5 there is no TCM, and trying to read the status
+        * register will hang the processor.
+        */
+       if (cpu_architecture() < CPU_ARCH_ARMv5) {
+               if (dtcm_code_sz || itcm_code_sz)
+                       pr_info("CPU TCM: %u bytes of DTCM and %u bytes of "
+                               "ITCM code compiled in, but no TCM present "
+                               "in pre-v5 CPU\n", dtcm_code_sz, itcm_code_sz);
+               return;
+       }
+
+       tcm_status = read_cpuid_tcmstatus();
+       dtcm_banks = (tcm_status >> 16) & 0x03;
+       itcm_banks = (tcm_status & 0x03);
+
        /* Values greater than 2 for D/ITCM banks are "reserved" */
        if (dtcm_banks > 2)
                dtcm_banks = 0;
-- 
1.7.3.2

Yours,
Linus Walleij
