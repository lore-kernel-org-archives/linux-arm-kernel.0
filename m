From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 7 Sep 2015 15:40:36 -0400 (EDT)
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <1713935.2YV1sNJUyb@wuerfel>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
 <1713935.2YV1sNJUyb@wuerfel>
Message-ID: <alpine.LFD.2.20.1509071152510.22877@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Sep 2015, Arnd Bergmann wrote:

> On Thursday 03 September 2015 21:24:00 Nicolas Pitre wrote:
> > If 768MB targets were common place then it could be worth changing the 
> > default vmalloc size to accommodate this memory size and testing all the 
> > other targets to make sure no regressions are introduced.  But given it 
> > is easy to change the default via the kernel cmdline, and that you lose 
> > only 8 MB otherwise, I don't think it is worth the trouble and/or the 
> > risk.
> 
> Agreed.

Well... I think there is a better solution.

Instead of shrinking the vmalloc size, we should instead move 
VMALLOC_END and keep the vmalloc size unchanged.  That also makes for 
nicer address alignment in a subsequent CONFIG_VMSPLIT_3G_OPT patch.

----- >8
ARM: move VMALLOC_END up from 0xff000000 to 0xff800000

There is a 12MB unused region in our memory map between the vmalloc and
fixmap areas. This became unused with commit e9da6e9905e6, confirmed with
commit 64d3b6a3f480.

We also have a 8MB guard area before the vmalloc area.  With the default
240MB vmalloc area size, that puts the end of low memory at 0xef800000
which is unfortunate for 768MB machines where 8MB of RAM is lost to
himem.

Let's move VMALLOC_END to 0xff800000 so the guard area won't chop the
top of the 768MB lomem area while keeping the default vmalloc area size
unchanged and also preserving a gap between the vmalloc and fixmap
areas.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 4178ebda6e..546a39048e 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -54,7 +54,7 @@ VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
 				located here through iotable_init().
 				VMALLOC_START is based upon the value
 				of the high_memory variable, and VMALLOC_END
-				is equal to 0xff000000.
+				is equal to 0xff800000.
 
 PAGE_OFFSET	high_memory-1	Kernel direct-mapped RAM region.
 				This maps the platforms RAM, and typically
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f40354198b..348caabb76 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -43,7 +43,7 @@
  */
 #define VMALLOC_OFFSET		(8*1024*1024)
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#define VMALLOC_END		0xff000000UL
+#define VMALLOC_END		0xff800000UL
 
 #define LIBRARY_TEXT_START	0x0c000000
 
