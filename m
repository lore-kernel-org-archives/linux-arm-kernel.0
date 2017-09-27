From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Sep 2017 15:28:42 +0100
Subject: [PATCH] arm64: fix documentation on kernel pages mappings to HYP
 VA
In-Reply-To: <20170927091332.GA19317@arm.com> (Will Deacon's message of "Wed,
 27 Sep 2017 10:13:33 +0100")
References: <20170913180830.8608-1-ynorov@caviumnetworks.com>
 <20170926184542.t56zpdx2s5et77gy@yury-thinkpad>
 <86bmlwo842.fsf@arm.com> <20170927091332.GA19317@arm.com>
Message-ID: <867ewknrl1.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27 2017 at 10:13:33 am BST, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 27, 2017 at 09:31:41AM +0100, Marc Zyngier wrote:
>> On Tue, Sep 26 2017 at  9:45:42 pm BST, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> > On Wed, Sep 13, 2017 at 09:08:30PM +0300, Yury Norov wrote:
>> >> The Documentation/arm64/memory.txt says:
>> >> When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
>> >> offset from the kernel VA (top 24bits of the kernel VA set to zero):
>> >> 
>> >> In fact, kernel addresses are transleted to HYP with kern_hyp_va macro,
>> >> which has more options, and none of them assumes clearing of top 24bits
>> >> of the kernel VA.
>> >> 
>> >> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>> >> ---
>> >>  Documentation/arm64/memory.txt | 15 +++++++++------
>> >>  1 file changed, 9 insertions(+), 6 deletions(-)
>> >> 
>> >> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
>> >> index d7273a5f6456..c39895d7e3a2 100644
>> >> --- a/Documentation/arm64/memory.txt
>> >> +++ b/Documentation/arm64/memory.txt
>> >> @@ -86,9 +86,12 @@ Translation table lookup with 64KB pages:
>> >>   +-------------------------------------------------> [63] TTBR0/1
>> >>  
>> >>  
>> >> -When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
>> >> -offset from the kernel VA (top 24bits of the kernel VA set to zero):
>> >> -
>> >> -Start			End			Size		Use
>> >> ------------------------------------------------------------------------
>> >> -0000004000000000	0000007fffffffff	 256GB		kernel objects mapped in HYP
>> >> +When using KVM without Virtualization Host Extensions, the hypervisor maps
>> >> +kernel pages in EL2, at a fixed offset from the kernel VA. Namely, top 16
>> >> +or 25 bits of the kernel VA set to zero depending on ARM64_VA_BITS_48 or
>> >> +ARM64_VA_BITS_39 config option selected; or top 17 or 26 bits of the kernel
>> >> +VA set to zero if CPU has Reduced HYP mapping offset capability. See
>> >> +kern_hyp_va macro.
>> 
>> What is this "Reduced HYP mapping offset capability"?
>> 
>> You're missing the point that the location of the EL2 mapping is
>> conditioned by the location of the identity mapping that is used to
>> bring up / tear down KVM. You have to express the VA transformation in
>> terms of both VA_BITS (and there is more cases than just 39 or 48 bits)
>> *and* the idmap address, not to mention the case where KVM's VA_BITS is
>> larger than the rest of the kernel. See the extensive blurb in
>> kvm_mmu.h.
>> 
>> >> +
>> >> +When using KVM with Virtualization Host Extensions, no additional mappings
>> >> +created as host kernel already operates in EL2.
>> 
>> This bit is fine.
>
> FWIW, I was going to queue a simplified version along the lines of the patch
> below.
>
> Will
>
> --->8
>
> commit dbf7393b7738a0ba0284551e7b6e014cfb100661
> Author: Yury Norov <ynorov@caviumnetworks.com>
> Date:   Wed Sep 13 21:08:30 2017 +0300
>
>     arm64: fix documentation on kernel pages mappings to HYP VA
>     
>     The Documentation/arm64/memory.txt says:
>     When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
>     offset from the kernel VA (top 24bits of the kernel VA set to zero):
>     
>     In fact, kernel addresses are transleted to HYP with kern_hyp_va macro,
>     which has more options, and none of them assumes clearing of top 24bits
>     of the kernel VA.
>     
>     Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>     [will: removed gory details]
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
> index d7273a5f6456..ea9ee39784a2 100644
> --- a/Documentation/arm64/memory.txt
> +++ b/Documentation/arm64/memory.txt
> @@ -86,9 +86,9 @@ Translation table lookup with 64KB pages:
>   +-------------------------------------------------> [63] TTBR0/1
>  
>  
> -When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
> -offset from the kernel VA (top 24bits of the kernel VA set to zero):
> +When using KVM without the Virtualization Host Extensions, the hypervisor
> +maps kernel pages in EL2 at a fixed offset from the kernel VA. See the
> +kern_hyp_va macro for more details.
>  
> -Start			End			Size		Use
> ------------------------------------------------------------------------
> -0000004000000000	0000007fffffffff	 256GB		kernel objects mapped in HYP
> +When using KVM with the Virtualization Host Extensions, no additional
> +mappings are created, since the host kernel runs directly in EL2.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
