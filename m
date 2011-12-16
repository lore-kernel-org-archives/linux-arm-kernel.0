From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 16 Dec 2011 17:38:52 +0000
Subject: [Xen-devel] [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt
 extensions
In-Reply-To: <20111216165420.GE6342@arm.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201111292129.20444.arnd@arndb.de>
 <alpine.DEB.2.00.1111301053300.31179@kaball-desktop>
 <CAHkRjk48jHO19H04rf8252+v04hk9qSdKBrfYCqJsZyamVhMEw@mail.gmail.com>
 <4EEB673D.3040608@citrix.com> <20111216165420.GE6342@arm.com>
Message-ID: <4EEB822C.7010809@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/11 16:54, Catalin Marinas wrote:
> On Fri, Dec 16, 2011 at 03:43:57PM +0000, David Vrabel wrote:
>> On 30/11/11 14:11, Catalin Marinas wrote:
>>> On 30 November 2011 11:39, Stefano Stabellini
>>> <stefano.stabellini@eu.citrix.com> wrote:
>>>> A git branch is available here (not ready for submission):
>>>>
>>>> git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git arm
>>>>
>>>> the branch above is based on git://linux-arm.org/linux-2.6.git arm-lpae,
>>>> even though guests don't really need lpae support to run on Xen.
>>>
>>> Indeed, you don't really need LPAE. What you may need though is
>>> generic timers support for A15, it would allow less Hypervisor traps.
>>> For up-to-date architecture patches (well, development tree, not
>>> guaranteed to be stable), I would recommend this (they get into
>>> mainline at some point):
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=summary
>>>
>>> Either use master or just cherry-pick the branches that you are interested in.
>>
>> Which branches are required for the Versatile Express with the
>> Cortex-A15? I merged linux-arm-arch/arm-arch/vexpress in
> 
> That's the branch if you only need VE and A15 support
> 
>> but I get a
>> instruction fault immediately after branching to __mmap_switched.
>>
>> Is it not setting up the MMU correctly?
> 
> Do you run this on a software model? What config options do you use? You
> would need to enable VEXPRESS_EXTENDED_MEMORY_MAP and
> ARCH_VEXPRESS_CA15X4.

The envelope model, yes.  Both those options are enabled.  I've also
attached the complete config and the model configuration.

I took a closer look at the diffs between what Stefano had in his tree
(which included a bunch of LPAE support which I don't have enabled) and
the kernel boots the addition of some isb's when the MMU is switched on.

These were added by: "ARM: LPAE: add ISBs around MMU enabling code"
(commit 1c553c2 in your tree) which is think is only present in the LPAE
branch.  Is this patch not actually specific to LPAE?  Are there other
similar patches?

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 566c54c..b4e84e2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -400,8 +400,10 @@ ENDPROC(__enable_mmu)
        .align  5
 __turn_mmu_on:
        mov     r0, r0
+        isb
        mcr     p15, 0, r0, c1, c0, 0           @ write control reg
        mrc     p15, 0, r3, c0, c0, 0           @ read id reg
+        isb
        mov     r3, r3
        mov     r3, r13
        mov     pc, r3

David
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: .config
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111216/b7b92ed0/attachment-0002.ksh>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: fm.cfg
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111216/b7b92ed0/attachment-0003.ksh>
