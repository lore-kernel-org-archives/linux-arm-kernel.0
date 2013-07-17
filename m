From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 17 Jul 2013 15:48:29 +0900
Subject: [PATCH] ARM: bugfix: Features of /proc/cpuinfo is wrong
Message-ID: <1374043709-24770-1-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Array hwcap_str[19] should be "vfpd32" and hwcap_str[20] should be "lpae".
But actually "vfpd32" was missing and "lpae" was at wrong place.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
Hello, 

The output of features string of /proc/cpuinfo is changed at v3.11-rc1.
In case of KZM-A9-GT board, which cpu is ARM Corex-A9
$ grep Features /proc/cpuinfo

Features	: swp half thumb fastmult vfp edsp neon vfpv3 tls lpae 

This is wrong. Cortex-A9 does not have lpae (Large Physical Address Extension).

I tried git bisect and found this commit is related.

a469abd0f868c902b75532579bf87553dcf1b360
 ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions

Variable elf_hwcap = 0x0008b0d7. This seems good.
HWCAP_LPAE (1 << 20) is not set in elf_hwcap.
Finally I found "lpae" string was wrong place in the array hwcap_str[].
hwcap_str[19] should be "vfpd32" and hwcap_str[20] should be "lpae".
But actually "vfpd32" was missing and "lpae" was@wrong place.

After this patch, features of /proc/cpuinfo of the same board is

Features	: swp half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 

I tested only in Cortex-A9.
Someone, please test on Cortex-A15 or A7. "lpae" should be appeared.


 arch/arm/kernel/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 63af9a7..96286cb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -971,6 +971,7 @@ static const char *hwcap_str[] = {
 	"vfpv4",
 	"idiva",
 	"idivt",
+	"vfpd32",
 	"lpae",
 	NULL
 };
-- 
1.7.9.5
