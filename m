From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 May 2013 14:41:17 +0100
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and
 use ALT_SMP instead
In-Reply-To: <51938B3D.2070508@free-electrons.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-4-git-send-email-will.deacon@arm.com>
 <51938B3D.2070508@free-electrons.com>
Message-ID: <20130515134117.GH23869@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 02:18:53PM +0100, Gregory CLEMENT wrote:
> Hi Will,

Hi Gregory,

> On 03/25/2013 07:19 PM, Will Deacon wrote:
> > Many ARMv7 cores have hardware page table walkers that can read the L1
> > cache. This is discoverable from the ID_MMFR3 register, although this
> > can be expensive to access from the low-level set_pte functions and is a
> > pain to cache, particularly with multi-cluster systems.
> > 
> > A useful observation is that the multi-processing extensions for ARMv7
> > require coherent table walks, meaning that we can make use of ALT_SMP
> > patching in proc-v7-* to patch away the cache flush safely for these
> > cores.
> 
> I encountered a regression with 3.10-rc1 on the Armada 370 based boards.
> With the 3.10-rc1 they hang during auto testy of the xor engine which are
> mainly DMA transfers. If I revert this patch, it no more hang. I found this
> by using bisect, it was not obvious at all for me that this patch may have
> cause this regression.

Is this using dmatest.ko, or a different test program?

> The issue appear in SMP and in UP. However I think that  the PJ4B-v7 used in
>  the Armada 370 are not MP capable.

Ok, so the ALT_UP case should be emitted after patching, correct?

> I made some investigation. And in UP if I remove the line:
> 	ALT_UP(W(nop))

Did you remove the ALT_SMP case as well? You could also try making the
ALT_SMP case use W(nop) too and see if it changes anything.

> at the begining of the cpu_v7_dcache_clean_are macro located in
> arch/arm/mm/proc-v7.S
> 
> Then the kernel boot again. It is not surprising because in this case
> we found the same generated code that before this patch was applied.
> 
> now I don't really understand why a W(nop) will cause this issue.

No, that sounds weird. Can you inspect the functions using JTAG after the smp
patching code has executed?

> In SMP mode even with this line removed the kernel hang, but in this case
> I am not sure of what happen exactly and how the .alt.smp.init section is
> used.

If you don't have both of the alternatives, things will go wrong.

> I hope you will find some explanation and solution to this bug, because currently
> the only solution I have is to revert this patch.

Let's not jump to that just yet!

Cheers,

Will
