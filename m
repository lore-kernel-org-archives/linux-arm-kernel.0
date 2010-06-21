From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 10:13:31 +0100
Subject: [PATCH v3 1/7] ARM: Align machine_desc.phys_io to a 1MB section
In-Reply-To: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621091331.22752.73990.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms like RealView don't pass a section-aligned pointer via the
machine_desc structure. This patch aligns the pointer in the
__create_page_tables function. Reported by Tony Thompson.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/head.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..82ea924 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -302,6 +302,8 @@ __create_page_tables:
 	movhi	r3, #0x0800
 	add	r6, r0, r3
 	ldr	r3, [r8, #MACHINFO_PHYSIO]
+	mov	r3, r3, lsr #20			@ 1MB-aligned address
+	mov	r3, r3, lsl #20
 	orr	r3, r3, r7
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
