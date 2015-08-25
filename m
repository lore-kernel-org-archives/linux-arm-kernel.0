From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 17:37:49 +0100
Subject: [PATCH v2 11/10] ARM: fix swp-emulate
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUHEL-000337-7Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Local testing found this direct userspace access from the kernel.  I'll
be rolling this into patch 10 tomorrow, but for the time being I'm adding
it on top of the set.

 arch/arm/kernel/swp_emulate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 1361756782c7..5b26e7efa9ea 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -141,11 +141,14 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 
 	while (1) {
 		unsigned long temp;
+		unsigned int __ua_flags;
 
+		__ua_flags = uaccess_save_and_enable();
 		if (type == TYPE_SWPB)
 			__user_swpb_asm(*data, address, res, temp);
 		else
 			__user_swp_asm(*data, address, res, temp);
+		uaccess_restore(__ua_flags);
 
 		if (likely(res != -EAGAIN) || signal_pending(current))
 			break;
-- 
2.1.0
