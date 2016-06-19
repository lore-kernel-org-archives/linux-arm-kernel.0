From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 18 Jun 2016 18:09:30 -0700
Subject: [PATCH v4 4/5] i.MX: system.c: Tweak prefetch settings for performance
In-Reply-To: <1466298571-7888-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466298571-7888-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1466298571-7888-5-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Prefetch Control Register settings to match that of Freescale's
Linux tree. As the commit e3addf1b773964eac7f797e8538c69481be4279c
states (author Nitin Garg):

"... set Prefetch offset to 15, since it improves memcpy performance by
35%. Don't enable Incr double Linefill enable since it adversely affects
memcpy performance by about 32MB/s and reads by 90MB/s. Tested with 4K
to 16MB sized src and dst aligned buffer..."

Those results are also corroborated by our own testing.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/system.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 76d7ebe..bf7ab77 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -111,8 +111,12 @@ void __init imx_init_l2cache(void)
 		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
 		val |= L310_PREFETCH_CTRL_DBL_LINEFILL |
 			L310_PREFETCH_CTRL_INSTR_PREFETCH |
-			L310_PREFETCH_CTRL_DATA_PREFETCH |
-			L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
+			L310_PREFETCH_CTRL_DATA_PREFETCH;
+
+		/* Set perfetch offset to improve performance */
+		val &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
+		val |= 15;
+
 		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
-- 
2.5.5
