From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 28 Apr 2016 10:28:30 +0100
Subject: [PATCH 09/12] kexec: ensure user memory sizes do not wrap
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
Message-ID: <E1aviFK-0000jY-1S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that user memory sizes do not wrap around when validating the
user input, which can lead to the following input validation working
incorrectly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8d34308ea449..d719a4d0ef55 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
 
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
+		if (mstart > mend)
+			return result;
 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
 			return result;
 		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
-- 
2.1.0
