From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 19 Aug 2013 13:54:42 -0700
Subject: Build error: kvm/reset.c
In-Reply-To: <20130815114150.GC23006@n2100.arm.linux.org.uk>
References: <20130815114150.GC23006@n2100.arm.linux.org.uk>
Message-ID: <20130819205442.GC21832@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:41:50PM +0100, Russell King - ARM Linux wrote:
> Last night's omap4430-sdp randconfig failed with this error in the KVM code:
> 
> arch/arm/kvm/reset.c:43:2: error: unknown field 'irq' specified in initializer
> 
> Configs etc at http://www.arm.linux.org.uk/developer/build/
> 
> Tree is my tip plus arm-soc tip plus Linus' tip.


hmmm, I'm wondering if this is actually related to:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676

Can you tell me which GCC version you are using?

I have been unable to reproduce this in any way (unfortunately it seems
the randconfig generating this error is also not available anymore), but
this patch may solve the issue:

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index b7840e7..71e08ba 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -40,7 +40,7 @@ static struct kvm_regs a15_regs_reset = {
 };
 
 static const struct kvm_irq_level a15_vtimer_irq = {
-	.irq = 27,
+	{ .irq = 27 },
 	.level = 1,
 };
 

-Christoffer
