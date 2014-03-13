From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 13 Mar 2014 22:46:54 +0000
Subject: [PATCH v2 01/15] efi: delete stray ARM ifdef
In-Reply-To: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
References: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1394750828-16351-2-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An #ifdef CONFIG_ARM clause in efi-stub-helper.c got included with some
of the generic stub rework by Roy Franz. Drop it here to make subsequent
patches less confusing.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 drivers/firmware/efi/efi-stub-helper.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
index b6bffbf..6811af7 100644
--- a/drivers/firmware/efi/efi-stub-helper.c
+++ b/drivers/firmware/efi/efi-stub-helper.c
@@ -608,18 +608,8 @@ static char *efi_convert_cmdline_to_ascii(efi_system_table_t *sys_table_arg,
 	}
 
 	options_size++;  /* NUL termination */
-#ifdef CONFIG_ARM
-	/*
-	 * For ARM, allocate at a high address to avoid reserved
-	 * regions at low addresses that we don't know the specfics of
-	 * at the time we are processing the command line.
-	 */
-	status = efi_high_alloc(sys_table_arg, options_size, 0,
-			    &cmdline_addr, 0xfffff000);
-#else
-	status = efi_low_alloc(sys_table_arg, options_size, 0,
-			    &cmdline_addr);
-#endif
+
+	status = efi_low_alloc(sys_table_arg, options_size, 0, &cmdline_addr);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
-- 
1.7.10.4
