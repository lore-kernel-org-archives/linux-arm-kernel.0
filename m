From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:30 +0300
Subject: [RFC 04/10] arm: kdump: skip indirection page when crashing
In-Reply-To: <0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
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
