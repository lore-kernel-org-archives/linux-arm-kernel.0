From: dyoung@redhat.com (Dave Young)
Date: Thu, 29 Oct 2015 14:40:11 +0800
Subject: [PATCH 13/16] arm64: kdump: add kdump support
In-Reply-To: <5631B4BA.6030903@linaro.org>
References: <cover.1445297709.git.geoff@infradead.org>
 <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
 <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
 <5628662B.1020605@linaro.org>
 <20151022051548.GD11227@dhcp-129-115.nay.redhat.com>
 <5628B2FA.80209@linaro.org>
 <20151023095059.GH11227@dhcp-129-115.nay.redhat.com>
 <5631B4BA.6030903@linaro.org>
Message-ID: <20151029064011.GF21927@dhcp-129-115.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, AKASHI

On 10/29/15 at 02:55pm, AKASHI Takahiro wrote:
> Dave,
> 
> On 10/23/2015 06:50 PM, Dave Young wrote:
> >On 10/22/15 at 06:57pm, AKASHI Takahiro wrote:
> >>(added Ard to Cc.)
> >>
> >>On 10/22/2015 02:15 PM, Dave Young wrote:
> >>>On 10/22/15 at 01:29pm, AKASHI Takahiro wrote:
> >>>>Hi Dave,
> >>>>
> >>>>Thank you for your comment.
> >>>>
> >>>>On 10/22/2015 12:25 PM, Dave Young wrote:
> >>>>>Hi, AKASHI,
> >>>>>
> >>>>>On 10/19/15 at 11:38pm, Geoff Levand wrote:
> >>>>>>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>>
> >>>>>>On crash dump kernel, all the information about primary kernel's core
> >>>>>>image is available in elf core header specified by "elfcorehdr=" boot
> >>>>>>parameter. reserve_elfcorehdr() will set aside the region to avoid any
> >>>>>>corruption by crash dump kernel.
> >>>>>>
> >>>>>>Crash dump kernel will access the system memory of primary kernel via
> >>>>>>copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> >>>>>>not reside in linear mapping on crash dump kernel.
> >>>>>>Please note that we should add "mem=X[MG]" boot parameter to limit the
> >>>>>>memory size and avoid the following assertion at ioremap():
> >>>>>>	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> >>>>>>		return NULL;
> >>>>>>when accessing any pages beyond the usable memories of crash dump kernel.
> >>>>>
> >>>>>How does kexec-tools pass usable memory ranges to kernel? using dtb?
> >>>>>Passing an extra mem=X sounds odd in the design. Kdump kernel should get
> >>>>>usable ranges and hanle the limit better than depending on an extern kernel
> >>>>>param.
> >>>>
> >>>>Well, regarding "depending on an external kernel param,"
> >>>>- this limitation ("mem=") is compatible with arm(32) implementation although
> >>>>   it is not clearly described in kernel's Documentation/kdump/kdump.txt.
> >>>>- "elfcorehdr" kernel parameter is mandatory on x86 as well as on arm/arm64.
> >>>>   The parameter is explicitly generated and added by kexec-tools.
> >>>>
> >>>>Do I miss your point?
> >>>
> >>>Arm previously use atag_mem tag for memory kernel uses, with dtb, Booting.txt
> >>>says: The boot loader must pass at a minimum the size and location of the
> >>>system memory
> >>>
> >>>In arm64 booting.txt, it does mentions about dtb but without above sentence.
> >>>
> >>>So if you are using dtb to pass memory I think the extra mem= should be not
> >>>necessary unless there's other limitations dtb can not been used.
> >>
> >>I would expect comments from arm64 maintainers here.
> >>
> >>In my old implementation, I added "usablemem" attributes, along with "reg," to
> >>"memory" nodes in dtb to specify the usable memory region on crash dump kernel.
> >>
> >>But I removed this feature partly because, on uefi system, uefi might pass
> >>no memory information in dtb.
> >
> >If this is the case there must be somewhere else one can pass memory infomation
> >to kernel, the booting.txt should be updated?
> >
> >kexec as a boot loader need use same method as the 1st kernel boot loader.
> >
> >>
> >>>One thing I'm confused is mem= only pass the memory size, where does you pass
> >>>the start addresses?
> >>
> >>In the current arm64 implementation, any regions below the start address will
> >>be ignored as system ram.
> >>
> >>>What if there's multiple sections such as some reserved
> >>>ranges 2nd kernel also need?
> >>
> >>My patch utilizes only a single contiguous region of memory as system ram.
> >>One exception that I notice is uefi's runtime data. They will be ioremap'ed separately.
> >>
> >>Please let me know if there is any other case that should be supported.
> >
> >For example the elf headers range, you reserved them in kdump kernel code,
> >but kexec-tools can do that early if it can provides all memory info to 2nd
> >kernel. Ditto for mark all the memory ranges 1st kernel used as reserved.
> 
> It seems to me that the issue you mentioned here is totally independent
> from "mem=" issue, isn't it?
> (and "elfcorehdr=" is a common way for crash dump kernel to know the region.)

Hmm, I did not talked about the eflcorehdr=, I means the code to reserve the
memory ranges elfcorehdr is using.

Thanks
Dave

> 
> -Takahiro AKASHI
> 
> >Thanks
> >Dave
> >
