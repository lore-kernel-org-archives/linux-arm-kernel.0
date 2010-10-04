From: yinghai@kernel.org (Yinghai Lu)
Date: Mon, 04 Oct 2010 15:43:46 -0700
Subject: multiple linux-next OMAP3 build errors
In-Reply-To: <1286231422.2463.316.camel@pasglop>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>	
	<1286173747.2358.4.camel@tubuntu.research.nokia.com>
	<1286231422.2463.316.camel@pasglop>
Message-ID: <4CAA58A2.6060707@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2010 03:30 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2010-10-04 at 09:29 +0300, Tomi Valkeinen wrote:
>>>   CC      drivers/video/omap2/vram.o
>>> drivers/video/omap2/vram.c: In function
>> 'omap_vram_reserve_sdram_memblock':
>>> drivers/video/omap2/vram.c:568: error: implicit declaration of
>>> function 'memblock_region_is_memory'
>>
>> Benjamin, your patch "memblock/arm: Use memblock_region_is_memory()
>> for
>> omap fb" in linux-next seems to be broken. I believe the called
>> function
>> should be memblock_is_region_memory, not memblock_region_is_memory?
> 
> I suspect either I didn't push my latest version before it got merged or
> Yinghai didn't pull the right one, since I'm pretty sure I test built
> it, but in any case, you're probably right :-)
> 
> I'm not in control of this patch series at the moment however. Ingo and
> Yinghai are. Yinghai, care to fix that up ? I'm currently travelling on
> holidays and won't be able to do much until later next week.

Peter or Ingo,

Please replace

commit dbe3039e64b1dd4cf26f782d45b524f85b444ad4

in -tip core/memblock

with following patch, that fixes the typo.

Thanks

Yinghai Lu

[PATCH -v2] memblock/arm: Use memblock_is_region_memory() for omap fb
    
Instead of the deprecated memblock_find()
    
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 05bf228..441af2b 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -173,11 +173,7 @@ static int check_fbmem_region(int region_idx, struct omapfb_mem_region *rg,
 
 static int valid_sdram(unsigned long addr, unsigned long size)
 {
-	struct memblock_region res;
-
-	res.base = addr;
-	res.size = size;
-	return !memblock_find(&res) && res.base == addr && res.size == size;
+	return memblock_is_region_memory(addr, size);
 }
 
 static int reserve_sdram(unsigned long addr, unsigned long size)
diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 0f2532b..34514a8 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -554,12 +554,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	size = PAGE_ALIGN(size);
 
 	if (paddr) {
-		struct memblock_region res;
-
-		res.base = paddr;
-		res.size = size;
-		if ((paddr & ~PAGE_MASK) || memblock_find(&res) ||
-		    res.base != paddr || res.size != size) {
+		if ((paddr & ~PAGE_MASK) ||
+		    !memblock_is_region_memory(paddr, size)) {
 			pr_err("Illegal SDRAM region for VRAM\n");
 			return;
 		}
