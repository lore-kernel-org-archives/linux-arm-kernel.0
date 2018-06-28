From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 11:06:55 +0100
Subject: [RFC/RFT PATCH 1/2] efi: Add helper to retrieve runtime version number
In-Reply-To: <20180628100656.10692-1-james.morse@arm.com>
References: <20180628100656.10692-1-james.morse@arm.com>
Message-ID: <20180628100656.10692-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some RAS errors are related to an invalid hardware access that was
made by software. Sometimes this happens before the kernel runs.

For example, HPE's ProLiant m400 Server (aka moonshot) trips the
platforms RAS mechanism during ExitBootServices. Once the kernel
probes the RAS error descriptor regions, it finds a stale 'fatal
error', and hits the deck.

Quirking this platform based on the DMI data doesn't capture that
the bug lies in the platforms UEFI firmware. Expose the runtime
version, originally retrieved from the EFI system table's header
revision field, so that any future or unaffected platform firmware
isn't swept up too.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/efi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56add823f190..42ddf8399814 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -966,6 +966,11 @@ extern struct efi {
 	unsigned long flags;
 } efi;
 
+static inline unsigned int efi_get_runtime_version(void)
+{
+	return efi.runtime_version;
+}
+
 extern struct mm_struct efi_mm;
 
 static inline int
-- 
2.17.1
