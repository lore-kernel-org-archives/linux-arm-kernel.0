From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 20:02:28 +0000
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-9A-GT for 3.7
In-Reply-To: <1346113116-20252-1-git-send-email-horms@verge.net.au>
References: <1346113116-20252-1-git-send-email-horms@verge.net.au>
Message-ID: <201209282002.28445.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 August 2012, Simon Horman wrote:
> ----------------------------------------------------------------
> Tetsuyuki Kobayashi (1):
>       ARM: shmobile: kzm9g: enable restarting
> 
>  arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

This patch ended up causing a new build warning in combination
with the io.h changes in Russell's tree.

I've just applied this patch on top, which is the same thing we
did to all the other open-coded mmio locations.

	Arnd

commit 28901c1fed11dfeab65f640878e85a9b61d311ed
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sun Sep 23 22:41:21 2012 +0000

    ARM: shmobile: add new __iomem annotation for new code
    
    While we fixed up all instances that were already present in v3.6,
    this one came in through new code.
    
    Without this patch, building kzm9g_defconfig results in:
    
    arch/arm/mach-shmobile/board-kzm9g.c: In function 'kzm9g_restart':
    arch/arm/mach-shmobile/board-kzm9g.c:781:2: warning: passing argument 2 of '__raw_writel' makes pointer from integer without a cast [enabled by default]
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
    Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Cc: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
    Cc: Simon Horman <horms@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index fd21fb6..5d792e4 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -765,7 +765,7 @@ static void __init kzm_init(void)
 
 static void kzm9g_restart(char mode, const char *cmd)
 {
-#define RESCNT2 0xe6188020
+#define RESCNT2 IOMEM(0xe6188020)
 	/* Do soft power on reset */
 	writel((1 << 31), RESCNT2);
 }
