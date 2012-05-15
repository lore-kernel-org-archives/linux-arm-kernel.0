From: khilman@ti.com (Kevin Hilman)
Date: Tue, 15 May 2012 13:13:16 -0700
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
In-Reply-To: <20120515195835.GC17852@atomide.com> (Tony Lindgren's message of
 "Tue, 15 May 2012 12:58:36 -0700")
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
 <20120508231653.GP5088@atomide.com> <87zk99jort.fsf@ti.com>
 <20120515195835.GC17852@atomide.com>
Message-ID: <873971jj8j.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

[...]

> That's already merged as 8259573b (ARM: OMAP2+: nand: Make board_onenand_init()
> visible to board code) so we need to apply it as a fix.
>
> Can you do a fix with your Signed-off-by or at least reply with that
> so I can apply it?

Here you go.  Applies to your 'board' branch.

Kevin



>From f4f2c35de0e67e3b8185059ffd78be67f7096d8a Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 15 May 2012 13:07:20 -0700
Subject: [PATCH] ARM: OMAP2+: nand: fix build error when
 CONFIG_MTD_ONENAND_OMAP2=n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 8259573b (ARM: OMAP2+: nand: Make board_onenand_init() visible
to board code) broke the build for configs with OneNAND disabled.  By
removing the static in the header file, it created a duplicate definition
in the .c and the .h files, resuling in a build error:

/work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.c:102:111: error: redefinition of 'board_onenand_init'
/work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.h:56:51: note: previous definition of 'board_onenand_init' was here
make[2]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/mach-omap2] Error 2
make: *** [sub-make] Error 2

Fix this by removing the duplicate dummy entry from the C file.

Cc: Enric Balletb? i Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 70a81f9..53c39d2 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
 
 	gpmc_onenand_init(&board_onenand_data);
 }
-#else
-void
-__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
-{
-}
 #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || \
-- 
1.7.9.2
