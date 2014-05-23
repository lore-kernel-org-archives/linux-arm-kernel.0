From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 23 May 2014 14:16:56 +0100
Subject: EFI_STUB fails to boot non-EFI on arm64
In-Reply-To: <20140523094513.GC9252@arm.com>
References: <20140523094513.GC9252@arm.com>
Message-ID: <20140523131656.GR4179@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:45:13AM +0100, Catalin Marinas wrote:
> As the EFI_STUB for arm64 got into tip and soon into -next, I thought
> about giving it a try (tip/arm64/efi). Using my boot-wrapper (non-EFI)
> is still supposed to work but I get the trace below. It looks like
> memmap.map is NULL but the code still assumes the kernel was started as
> an EFI app.
> 
> Have you guys tested these patches properly?

Apparently not sufficuently...
Sorry about that.

Fix appended:

>From 98433920394730d835f0061474832909c0740f29 Mon Sep 17 00:00:00 2001
From: Leif Lindholm <leif.lindholm@linaro.org>
Date: Fri, 23 May 2014 11:23:23 +0100
Subject: [PATCH] arm64: efi: only attempt efi map setup if booting via EFI

Booting a kernel with CONFIG_EFI enabled on a non-EFI system caused
an oops with the current UEFI support code.
Add the required test to prevent this.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 arch/arm64/kernel/efi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 7bfd650..14db1f6 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -333,6 +333,9 @@ void __init efi_init(void)
 
 void __init efi_idmap_init(void)
 {
+	if (!efi_enabled(EFI_BOOT))
+		return;
+
 	/* boot time idmap_pg_dir is incomplete, so fill in missing parts */
 	efi_setup_idmap();
 }
-- 
1.7.10.4
