From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:34 +0200
Subject: [RFC PATCH 04/15] ARM: uncompress: Only call arch_decomp_setup when
	needed
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-4-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As only the minority of the machines uses arch_decomp_setup,
ifdef it out when not needed, to avoid needless defines in
all uncompress.h files.

Machines using this feature should add
in their uncompress.h headers.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/misc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 8e2a8fc..a4b8df2 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -142,7 +142,9 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	free_mem_end_ptr	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
+#ifdef ARCH_HAVE_DECOMP_SETUP
 	arch_decomp_setup();
+#endif /* ARCH_HAVE_DECOMP_SETUP */
 
 	putstr("Uncompressing Linux...");
 	ret = do_decompress(input_data, input_data_end - input_data,
-- 
1.7.4.1
