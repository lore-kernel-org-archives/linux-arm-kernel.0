From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Dec 2012 18:11:08 +0000
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <50C7386E.70305@pengutronix.de>
References: <50BE0CDB.5000704@pengutronix.de>
 <1355230894.19818.1.camel@hornet> <50C7386E.70305@pengutronix.de>
Message-ID: <1355249468.19818.23.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
> What about putting the notes section into the read only segment, i.e.
> the ROM?

Could you, please, try the change below? It seems to do the job for me.

Pawe?

8<-------------------------
>From 01fe7810cfded11aff03d216d2adbcf673e78f65 Mon Sep 17 00:00:00 2001
From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 11 Dec 2012 18:09:14 +0000
Subject: [PATCH] ARM: vmlinux.lds: Move .notes section next to the rodata

The .notes, being read-only data by nature, was placed between
read-write .data and .bss. This was harmful in case of XIP
images, as it was placed in the RAM range, most likely far
from the ROM address, inflating the XIP images.

Moving the .notes at the end of the read-only section
(consisting of .text, .rodata and unwind info) fixes the problem.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 36ff15b..31fa80e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -131,6 +131,8 @@ SECTIONS
 	}
 #endif
 
+	NOTES
+
 	_etext = .;			/* End of text and rodata section */
 
 #ifndef CONFIG_XIP_KERNEL
@@ -296,8 +298,6 @@ SECTIONS
 	}
 #endif
 
-	NOTES
-
 	BSS_SECTION(0, 0, 0)
 	_end = .;
 
-- 
1.7.10.4
