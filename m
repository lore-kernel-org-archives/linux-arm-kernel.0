From: will.deacon@arm.com (Will Deacon)
Date: Sun, 27 Nov 2011 13:00:16 +0000
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <20111126220834.GB9581@n2100.arm.linux.org.uk>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
 <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
 <20111125154157.GP12047@mudshark.cambridge.arm.com>
 <20111126220834.GB9581@n2100.arm.linux.org.uk>
Message-ID: <20111127130016.GB26042@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Nov 26, 2011 at 10:08:34PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 25, 2011 at 03:41:57PM +0000, Will Deacon wrote:
> > Ok, if you're happy with my logic then I can put the patch into Russell's
> > patch system.
> 
> I've merged this into my fixes branch, but when I re-merge this with
> Marc's irqchip consolidation, I get conflicts.  I think I've fixed it
> correctly, but please check the result, which you'll find in my for-next
> branch.

Thanks for merging this. I've just had a quick look and the resolution looks
functionally correct to me (I'll try booting your for-next branch tomorrow).
I think that Marc's patches allow that bit of code to be rewritten in a
cleaner way, but I guess that can always be handled later on:


diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b2dc2dd..a3bc86f 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -697,13 +697,12 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
         * For primary GICs, skip over SGIs.
         * For secondary GICs, skip over PPIs, too.
         */
-       domain->hwirq_base = 32;
-       if (gic_nr == 0) {
-               if ((irq_start & 31) > 0) {
-                       domain->hwirq_base = 16;
-                       if (irq_start != -1)
-                               irq_start = (irq_start & ~31) + 16;
-               }
+       if (gic_nr == 0 && (irq_start & 31) > 0) {
+               domain->hwirq_base = 16;
+               if (irq_start != -1)
+                       irq_start = (irq_start & ~31) + 16;
+       } else {
+               domain->hwirq_base = 32;
        }
 
        /*


Cheers,

Will
