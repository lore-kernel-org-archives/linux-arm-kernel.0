From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Apr 2012 10:23:54 +0100
Subject: [PATCH] ARM: vic: re-read status register before dispatching
 each IRQ handler
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F002069840A167@AUSP01VMBX24.collaborationhost.net>
References: <1333533912-30813-1-git-send-email-will.deacon@arm.com>
 <ADE657CA350FB648AAC2C43247A983F002069840A167@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120405092354.GA22446@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 08:07:34PM +0100, H Hartley Sweeten wrote:
> On Wednesday, April 04, 2012 3:05 AM, Will Deacon wrote:
> > diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> > index 7a66311..6b1de5d 100644
> > --- a/arch/arm/common/vic.c
> > +++ b/arch/arm/common/vic.c
> > @@ -435,11 +435,9 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
> >  	u32 stat, irq;
> >  	int handled = 0;
> >  
> > -	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> > -	while (stat) {
> > +	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
> >  		irq = ffs(stat) - 1;
> >  		handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
> > -		stat &= ~(1 << irq);
> >  		handled = 1;
> >  	}
> 
> You probably should fix the comment above the function:

Sorry, missed that. v2 below.

Thanks,

Will


Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Apr 4 10:13:49 2012 +0100

    ARM: vic: re-read status register before dispatching each IRQ handler
    
    handle_IRQ may briefly cause interrupts to be re-enabled during soft IRQ
    processing on the exit path, leading to nested handling of VIC interrupts.
    
    Since the current code does not re-read the VIC_IRQ_STATUS register, this
    can lead to multiple invocations of the same interrupt handler and
    spurious interrupts to be reported.
    
    This patch changes the VIC interrupt dispatching code to re-read the
    status register each time, avoiding duplicate invocations of the same
    handler.
    
    Acked-and-tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
    Reviewed-by: Jamie Iles <jamie@jamieiles.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7a66311..7e288f9 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -427,19 +427,18 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 
 /*
  * Handle each interrupt in a single VIC.  Returns non-zero if we've
- * handled at least one interrupt.  This does a single read of the
- * status register and handles all interrupts in order from LSB first.
+ * handled at least one interrupt.  This reads the status register
+ * before handling each interrupt, which is necessary given that
+ * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
  */
 static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 {
        u32 stat, irq;
        int handled = 0;
 
-       stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
-       while (stat) {
+       while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
                irq = ffs(stat) - 1;
                handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
-               stat &= ~(1 << irq);
                handled = 1;
        }
