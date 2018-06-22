From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 16:41:17 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2D1595.6020000@hisilicon.com>
References: <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622142851.g3r4em3kidx5p3wv@lakrids.cambridge.arm.com>
 <5B2D1595.6020000@hisilicon.com>
Message-ID: <20180622154117.GC1802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 11:28:21PM +0800, Wei Xu wrote:
> On 2018/6/22 22:28, Mark Rutland wrote:
> >On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
> >>     [    0.227507] Mem abort info:
> >>     [    0.230390]   ESR = 0x96000006
> >>     [    0.233517]   Exception class = DABT (current EL), IL = 32 bits
> >>     [    0.239428]   SET = 0, FnV = 0
> >>     [    0.242555]   EA = 0, S1PTW = 0
> >>     [    0.245797] Data abort info:
> >>     [    0.248795]   ISV = 0, ISS = 0x00000006
> >>     [    0.252652]   CM = 0, WnR = 0
> >>     [    0.255769] swapper pgtable: 4k pages, 48-bit VAs, pgdp =
> >>(ptrval)
> >>     [    0.262645] [ffff0000093abce0] pgd=00000000411f8803,
> >>pud=00000000411f9803, pmd=0000000000000000
> >... and here the PMD for the task stack is all zeroes, so evidently
> >that's getting corrupted somehow.
> >
> >It appears that the overflow stack (which IIRC is embedded within the
> >kernel's data segment, as part of the image mapping), is fine.
> >
> >I wonder if there's some existing weirdness in the page tables for the
> >vmalloc area that causes things to go wrong. Can you please:
> >
> >* enable ARM64_PTDUMP_DEBUGFS
> >
> >* boot with kpti=off (with Will's patch to make this work)
> >
> >* as root, cat /sys/kernel/debug/kernel_page_tables
> >
> >... and dump the result here?
> Thanks!
> Can I do this later since Will's new patch works?

Yes, you should probably go to bed now! Please note that my patch still
isn't the right thing for mainline, since it avoids setting PTE_NG for
tables and therefore won't solve the boot-time issue with KASAN enabled.

We also don't understand why clean+invalidate is causing the issue on your
CPU, whereas clean does not. It looks like clean+invalidate somehow results
in page table entries being zeroed.

Have a good weekend,

Will
