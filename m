From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 5 Oct 2016 14:48:51 +0900
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <70ca1b97-8de4-921f-0cef-e02a88691ccd@caviumnetworks.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
 <57F37A73.3030105@arm.com>
 <691230c7-051d-afee-9014-d22963a8f045@caviumnetworks.com>
 <57F38A30.2050200@arm.com>
 <70ca1b97-8de4-921f-0cef-e02a88691ccd@caviumnetworks.com>
Message-ID: <20161005054849.GB19531@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manish,

On Tue, Oct 04, 2016 at 06:53:28PM +0530, Manish Jaggi wrote:
> 
> On 10/04/2016 04:23 PM, James Morse wrote:
> > Hi Manish,
> > 
> > On 04/10/16 11:05, Manish Jaggi wrote:
> >> On 10/04/2016 03:16 PM, James Morse wrote:
> >>> On 03/10/16 13:41, Manish Jaggi wrote:
> >>>> On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
> >>>>> On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
> >>>>>> First kernel is booted with mem=2G crashkernel=1G command line option.
> >>>>>> While the system has 64G memory.
> >>>
> >>>>> Are you saying that "mem=..." doesn't have any effect?
> >>>> What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
> >>>> the memory for second kernel has to be withing the crashkernel size.
> >>>> As per /proc/iomem System RAM the information is correct, but the /proc/meminfo is showing total memory
> >>>> much more than the first kernel had in first place.
> >>>
> >>> So your second crashkernel has 63G of memory? Unless you provide the same 'mem='
> >>> to the kdump kernel, this is the expected behaviour. The
> >>> DT:/reserved-memory/crash_dump describes the memory not to use.
> >>>
> >>> On your first boot with 'mem=2G' memblock_mem_limit_remove_map() called from
> >>> arm64_memblock_init() removed the top 62G of memory. Neither the first kernel
> >>> nor kexec-tools know about the top 62G.
> >>> When you run kexec-tools, it describes what it sees in /proc/iomem in the
> >>> DT:/reserved-memory/crash_dump, which is just the remaining 1G of memory.
> >>>
> >>> When we crash and reboot, the crash kernel discovers all 64G of memory from the
> >>> EFI memory map.
> > 
> >> So the iomem and meminfo should be same or different for the second kernel?
> >> Also i assumed that crashkernel=1G should restrict the second kernels to 1G.
> > 
> > Not with v26 of this series. What should it do with the 62G of memory that was
> > removed by booting with 'mem=2G'? It isn't part of the crashkernel reserved
> > area, and it isn't part of the vmcore described in elfcorehdr either...
> > 
> > 
> >> This is my understanding from the description. It should not require a second mem= option
> > 
> >>> kexec-tools described the 1G of memory that the first kernel was using in the
> >>> DT:/reserved-memory/crash_dump node, so early_init_fdt_scan_reserved_mem()
> >>> reserves the 1G of memory the first kernel used. This leaves us with 63G of memory.
> >>>
> >>> This may change with the next version of kdump if it switches back to using
> >>> DT:/chosen/linux,usable-memory-range.
> >>> If you need v26 to avoid the top 62G of memory, you need to provide the same
> >>> 'mem=' to the first and second kernel.
> > 
> >> If I provide for second kernel, I dont see any prints after Bye.
> >> Have you tired this anytime?
> > 
> > Yes, on juno-r1 passing 'mem=2G' to both the first and second kernel causes only
> > the first 2G of memory to be used with this pattern:
> > first kernel:		[1G used for linux]	[1G reserved for Crash kernel] 	[6G memory
> > hidden]
> > kdump kernel:	[1G vmcore]			[1G used for linux] 			[6G memory hidden]
> > 
> > 
> Oh, ok!
> I was giving mem=1G to crashkernel to test. with mem=2G it works.

I didn't know that you specified "mem=1G" in our local discussions ...

> >>>>>> 1.2 Live crash dump fails with error
> >>>
> >>> ... do we expect this to work? I don't think it has anything to do with this
> >>> series...
> >>>
> >> Why it should not?
> >> I saved the vmcore file while in second kernel. Since crash without vmcore file didnt run,
> >> Tried with vmcore file and it worked. Its just that if you want to boot a second kernel
> >>  with read only file system without network live crash dump analysis is handy.
> > 
> > Ah, you want to run /usr/bin/crash with the kdump boot of linux. You still need
> > to tell it where to find the memory image: "crash /path/to/vmlinux /proc/vmcore"
> > should do the trick.
> > 
> We should fix the documentation of kdump them.
> Since it is not supported, it should be removed.

Remove what?

And can you please double-check if you still have any problem
on a live system or with a saved core file?
(except for "mem=" stuff)

-Takahiro AKASHI

> > Thanks,
> > 
> > James
> > 
