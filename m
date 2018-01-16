From: takahiro.akashi@linaro.org (takahiro.akashi at linaro.org)
Date: Tue, 16 Jan 2018 16:07:05 +0900
Subject: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
 any reservation
In-Reply-To: <CAFTCetQvrNG7fr2-y4wOmjgFyC6D1U18K3iq5--RcNwt+hEz2g@mail.gmail.com>
References: <1515080048-9154-1-git-send-email-poonam.aggrwal@nxp.com>
 <5A4F5C45.3090006@arm.com>
 <DB5PR0401MB1733C9CB0DCDF94FCF3E4E1286130@DB5PR0401MB1733.eurprd04.prod.outlook.com>
 <5A58F75E.8030106@arm.com>
 <DB5PR0401MB173376E6E9B45B871BD1A66086140@DB5PR0401MB1733.eurprd04.prod.outlook.com>
 <CAFTCetQvrNG7fr2-y4wOmjgFyC6D1U18K3iq5--RcNwt+hEz2g@mail.gmail.com>
Message-ID: <20180116070703.GA15458@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 10:14:05AM +0530, Bhupesh SHARMA wrote:
> Hi Poonam, James
> 
> On Sat, Jan 13, 2018 at 8:37 AM, Poonam Aggrwal <poonam.aggrwal@nxp.com> wrote:
> > Hi James
> >
> > Regards
> > Poonam
> >
> >> -----Original Message-----
> >> From: James Morse [mailto:james.morse at arm.com]
> >> Sent: Friday, January 12, 2018 11:29 PM
> >> To: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> >> Cc: linux-arm-kernel at lists.infradead.org; takahiro.akashi at linaro.org;
> >> will.deacon at arm.com; G.h. Gao <guanhua.gao@nxp.com>; Abhimanyu Saini
> >> <abhimanyu.saini@nxp.com>; kexec at lists.infradead.org
> >> Subject: Re: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
> >> any reservation
> >>
> >> Hi Poonam,
> >>
> >> On 08/01/18 04:31, Poonam Aggrwal wrote:
> >> > James Morse wrote:
> >> >> On 04/01/18 15:34, Poonam Aggrwal wrote:
> >> >>> Address for both crashkernel memory and elfcorehdr can be assigned
> >> >>> statically. For crashkernel memory it is via
> >> >>> crashkernel=SIZE at ADDRESS and elfcorehdr_addr via by kexec-utils in dump
> >> kernel device tree.
> >> >>
> >> >> There are some crashkernel=SIZE at ADDRESS values that the user can
> >> >> supply that we must reject. The obvious one is if it overlaps with
> >> >> the kernel text. (this patch won't spot this). We need to read the
> >> >> hardware's reserved regions from the DT before we allocate the
> >> >> crashkernel region, for example if the bootloader reserved a chunk of
> >> >> memory for a frame-buffer, I shouldn't be able to use that as crashkernel
> >> memory.
> >> >>
> >> >> (you shouldn't need to specify an address, doing so prevents the
> >> >> kernel from picking memory it can use)
> >> >>
> >> >>
> >> >>> So memory should be reserved for both the above areas before any
> >> >>> other memory reservations are done. Otherwise overlaps may happen
> >> >>> and memory allocations will fail leading to failure in booting the
> >> >>> dump capture kernel.
> >>
> >> >>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> >> >>> 00e7b90..24ce15d 100644
> >> >>> --- a/arch/arm64/mm/init.c
> >> >>> +++ b/arch/arm64/mm/init.c
> >> >>> @@ -453,6 +453,14 @@ void __init arm64_memblock_init(void)
> >>
> >> >>> + reserve_elfcorehdr();
> >> >>
> >> >> (Moving reserve_elfcorehdr() makes sense, but..)
> >> >>
> >> >>
> >> >>> + reserve_crashkernel();
> >> >>
> >> >> reserve_crashkernel() does the allocation for the crashkernels reserved
> >> memory.
> >> >> I expect this to always fail in the kdump kernel because there isn't
> >> >> enough memory. (fdt_enforce_memory_region() at the top of this
> >> >> function calls memblock_cap_memory_range()).
> >> >>
> >> >> Moving this allocation above the early_init_fdt_scan_reserved_mem()
> >> >> below means we may allocate memory for the crashdump that is in use
> >> >> by firmware/hardware and described as reserved in the DT.
> >>
> >> > Yeah, this is a good point. So ideally the address of the crash kernel
> >> > should be diligently provided by the user based on the system.
> >>
> >> Even better: the region to store the crash kernel in should be chosen by the
> >> kernel.
> >> When using kdump I boot with 'crashkernel=1G', the kernel chooses where to
> >> place the reserved region.
> > Right. This is a commonly used.
> >  Even if I specified a reasonable physical address, the
> >> efistub may relocate the kernel over the top during boot as part of its KASLR
> >> work.
> > Agree
> >>
> >> (Why does anyone ever need to specify an offset here?)
> > offset is normally an optional argument. Request Takahiro to provide his inputs.  Does this imply any updates in kexec design/implementation/documentation?
> 
> offset is a optional argument. For relocatable kernels (and kernels
> which support KASLR), specifying offset is normally not needed.
> 
> Please refer to the 'Extended crashkernel syntax' documentation
> (<https://github.com/torvalds/linux/blob/master/Documentation/kdump/kdump.txt#L259>):
> 
> Extended crashkernel syntax
> ===========================
> 
> While the "crashkernel=size[@offset]" syntax is sufficient for most
> configurations, sometimes it's handy to have the reserved memory dependent
> on the value of System RAM -- that's mostly for distributors that pre-setup
> the kernel command line to avoid a unbootable system after some memory has
> been removed from the machine.
> 
> The syntax is:
> 
>     crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>     range=start-[end]
> 
> For example:
> 
>     crashkernel=512M-2G:64M,2G-:128M
> 
> This would mean:
> 
>     1) if the RAM is smaller than 512M, then don't reserve anything
>        (this is the "rescue" case)
>     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>     3) if the RAM size is larger than 2G, then reserve 128M
> 
> As James mentioned for arm64, in case of relocatable/kaslr kernels,
> the efistub may relocate the kernel over the top during boot as part
> of its KASLR.

It would be sad if we couldn't specify kaslr and kdump at the same time.
Since kaslr will skip any of memory regions whose attributes are not
CONVENTIONAL_MEMORY for allocating a relocated kernel image, we will be
able to have a dedicated range of memory reserved for kdump.
In this case, using an "offset" in "crashkernel=" will be crucial.

(I don't know how we can notify uefi of the region though.)

> So, the offset field may make more sense for
> non-relocatable/static kernels, but for newer kernels, its better to
> use the 'Extended crashkernel syntax' syntax which is also supported
> by newer distribution versions.

How better is it for the case?

I don't know exactly what you mean by "newer kernel/distribution", but
kdump on arm64 supports this feature from the day one.
(It is basically independent from architectures.)

Thanks,
-Takahiro AKASHI


> For e.g. see ubuntu trusty kdump-config man page -
> <http://manpages.ubuntu.com/manpages/trusty/man8/kdump-config.8.html>:
> 
>   kdump kernel relocation address does not match crashkernel= parameter:
>               For non-relocatable architectures,  the  kdump  kernel  must  be
>               built   with   a  predetermined  start  address.   This  message
>               indicates that the start address of the  kdump  kernel  and  the
>               start address in the crashkernel= parameter do not match.
> 
> Regards,
> Bhupesh
