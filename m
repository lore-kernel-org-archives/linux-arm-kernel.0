From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 11 Sep 2012 12:49:00 +0530
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
In-Reply-To: <alpine.DEB.2.00.1209110643010.23042@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
 <20120910185535.GC1303@atomide.com>
 <CAMQu2gxUES=s8fMpwJ77tnY1wz4b_T=yustj+C+WNkEMmEOx4w@mail.gmail.com>
 <alpine.DEB.2.00.1209110636310.23042@utopia.booyaka.com>
 <CAMQu2gyXOEs3Zbo=JrPwN2LmUNyYVc35iPWwGZqXCE3BCsn7xg@mail.gmail.com>
 <alpine.DEB.2.00.1209110643010.23042@utopia.booyaka.com>
Message-ID: <CAMQu2gxkQ1JAjbuhFZqUxgrgzrFLhMZk_Q8TzXW5q9Lr3JOmqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 12:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Sep 11, 2012 at 12:07 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:
>> >
>> >> On Tue, Sep 11, 2012 at 12:25 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
>> >> >>
>> >> >> Will you able to pick up these couple of wakeupgen fixes from  here or
>> >> >> do you want me to send you a pull request for 3.6-rc5/6
>> >> >
>> >> > I can pick them into fixes-noncritical. But if the second one is
>> >> > a major bug for the -rc series, the patch should be describe what
>> >> > breaks (regression? oops?).
>> >> >
>> >> Fixes non critical is fine. No major issue without these patches.
>> >
>> > There's an ordering constraint though: Santosh's patch needs to go in
>> > first, then mine.
>> >
>> Its other way round ;-)
>> Mine I created after applying your change.
>
> The problem is that if my patch is applied first, then there will be a
> point after my patch where the AUXCOREBOOT1 register won't be saved, which
> might break PM.  So the patches may need to be updated.
>
Good point. It's trivial to re-order them.

Tony,
Updated patches in the end of the email. Also attached.

Regards
Santosh

>From 4e1da2a44d92b956c3a740f5af6a45ff1c2dc294 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 11 Sep 2012 12:43:18 +0530
Subject: [PATCH 2/2] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write

The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
AUXCOREBOOT1 register contents twice.  This seems like a waste of
time, so, remove the duplicates.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index c3795c2..567f672 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -233,12 +233,6 @@ static inline void omap4_irq_save_context(void)
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
-
-	/* Save SyncReq generation logic */
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
 	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
-- 
1.7.9.5


>From 6e3b8a3f6ec231f588b860d87b7a80f6ba38ce98 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 6 Sep 2012 11:51:34 +0530
Subject: [PATCH 1/2] ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT
 register save

The wakeupgen context-save code reads AUXCOREBOOT0 register
instead of AUXCOREBOOT1 register contents while saving AUXCOREBOOT1.

Fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index 05fdebf..c3795c2 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -229,7 +229,7 @@ static inline void omap4_irq_save_context(void)
 	/* Save AuxBoot* registers */
 	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-- 
1.7.9.5
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-OMAP4-wakeupgen-remove-duplicate-AUXCOREBOOT-rea.patch
Type: application/octet-stream
Size: 1413 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/8e624e0f/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch
Type: application/octet-stream
Size: 1196 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/8e624e0f/attachment-0003.obj>
