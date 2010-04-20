From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:50 +0300
Subject: [PATCH 4/8] arm: kdump: skip indirection page when crashing
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <9b6846594bb7f0563c8955feb91c92c59380a5cc.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we are crashing there is no indirection page in place. Only control page is
present.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/relocate_kernel.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 61930eb..fd26f8d 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -10,6 +10,12 @@ relocate_new_kernel:
 	ldr	r0,kexec_indirection_page
 	ldr	r1,kexec_start_address
 
+	/*
+	 * If there is no indirection page (we are doing crashdumps)
+	 * skip any relocation.
+	 */
+	cmp	r0, #0
+	beq	2f
 
 0:	/* top, read another word for the indirection page */
 	ldr	r3, [r0],#4
-- 
1.5.6.5
