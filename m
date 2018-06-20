From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2018 17:28:45 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2A7FE1.5040607@hisilicon.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
Message-ID: <20180620162845.GD27776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 12:25:05AM +0800, Wei Xu wrote:
> Hi James,
> 
> On 2018/6/20 23:54, James Morse wrote:
> >Hi Wei,
> >
> >On 20/06/18 16:52, Wei Xu wrote:
> >>On 2018/6/20 22:42, Will Deacon wrote:
> >>>Hmm, I wonder if this is at all related to RAS, since we've just enabled
> >>>that and if we take a fault whilst rewriting swapper then we're going to
> >>>get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?
> >>I will try it now.
> >It's not just the Kconfig symbol, could you also revert:
> >
> >f751daa4f9d3 ("arm64: Unconditionally enable IESB on exception entry/return for
> >firmware-first")
> >
> >
> >(reverts and build cleanly on 4.17)
> 
> Thanks to point out this!
> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
> But I still got the stack overflow issue sometimes.
> Do you have more hint?

[...]

>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>     [    0.081727] pc : el1_sync+0x0/0xb0
>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214

Please run:

$ ./scripts/faddr2line vmlinux kpti_install_ng_mappings+0x120/0x214

as the GDB output wasn't helpful (it only showed local variable
declarations?!).

Will
