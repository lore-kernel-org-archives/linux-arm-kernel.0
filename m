From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 11 Jul 2014 03:38:19 -0700
Subject: [PATCH] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53BF0ACA.70403@amd.com>
References: <20140709161704.9623.92358.stgit@joelaarch64.amd.com>
 <20140710202502.GA20394@cbox> <53BEFF7E.5010907@amd.com>
 <53BF0ACA.70403@amd.com>
Message-ID: <20140711103819.GB23588@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 04:51:06PM -0500, Joel Schopp wrote:
> 
> On 07/10/2014 04:02 PM, Joel Schopp wrote:
> > On 07/10/2014 03:25 PM, Christoffer Dall wrote:
> >> On Wed, Jul 09, 2014 at 11:17:04AM -0500, Joel Schopp wrote:
> >>> The current calculation for VTTBR_BADDR_MASK masks only 39 bits and not
> >>> all 40 bits.  That last bit is important as some systems allocate
> >>> from near the top of the available address space.
> >>>
> >>> This patch is necessary to run KVM on an aarch64 SOC I have been testing.
> >>>
> >>> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> >>> ---
> >>>  arch/arm64/include/asm/kvm_arm.h |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> >>> index 3d69030..b39e93f 100644
> >>> --- a/arch/arm64/include/asm/kvm_arm.h
> >>> +++ b/arch/arm64/include/asm/kvm_arm.h
> >>> @@ -148,7 +148,7 @@
> >>>  #endif
> >>>  
> >>>  #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> >>> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
> >>> +#define VTTBR_BADDR_MASK  (0xffffffffffLLU)              /* bits 0-39 */
> >>>  #define VTTBR_VMID_SHIFT  (48LLU)
> >>>  #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
> >>>  
> >>>
> >> While this is obviously fixing a bug, it doesn't feel like the right
> >> short-term fix.  I'll have to go back and read the definitions of x in
> >> BADDR[47:x] for VTTBR_EL2 exactly again, but the intended use of
> >> VTTBR_BADDR_MASK (and the only occurence of it in C-code) is to deal
> >> with alignment of the allocated pgd.
> > I think there is some confusion.  Before VTTBR_BADDR_MASK always
> > evaluated to 0x7fffffffffLLU, after the change it always evaluates to
> > 0xffffffffffLLU
> >
> > Neither before nor after the patch is it dealing with alignment.  Any
> > bits it throws away (bits 40-47) are most significant not least significant.
> >
> > I could have rewritten the macro like:
> >
> > #define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X + 1)) - 1) << VTTBR_BADDR_SHIFT)
> >
> > to correct the bug but it's my opinion that the existing code is quite
> > obfuscated which is how the bug happened in the first place.  It seemed
> > easier to just actually mask the bits in a straightforward and easy to
> > understand manner.  I even added a comment so nobody has to count the fs ;)
> >
> I hate to reply to my own email correcting myself.  But you were
> correct.  I will fix and resend a v2.

Thanks,
-Christoffer
