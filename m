From: stefan@agner.ch (Stefan Agner)
Date: Tue,  8 May 2018 13:32:11 +0200
Subject: [RESEND PATCH v2] bus: arm-cci: use asm unreachable
Message-ID: <20180508113211.7026-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixing asm and C code is not recommended in a naked function by
gcc and leads to an error when using clang:
  drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
  function is not supported
        unreachable();
        ^

While the function is marked __naked it actually properly return
in asm. There is no need for the unreachable() call.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/bus/arm-cci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 443e4c3fd357..b8184a903583 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -371,8 +371,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
 	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
 	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
-
-	unreachable();
 }
 
 /**
-- 
2.17.0
