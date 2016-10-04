From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Oct 2016 11:18:33 +0100
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
Message-ID: <20161004101833.GB18083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 06:11:40PM +0530, Manish Jaggi wrote:
> On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
> > On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
> >> Observations:
> >> 1.1. Dump capture kernel shows different memory map.
> >> ---------------------------------------------------
> >> In dump capture kernel /proc/meminfo and /proc/iomem differ
> >>
> >> root at arm64:/home/ubuntu/CODE/crash#
> >> MemTotal:       65882432 kB
> >> MemFree:        65507136 kB
> >> MemAvailable:   60373632 kB
> >> Buffers:           29248 kB
> >> Cached:            46720 kB
> >> SwapCached:            0 kB
> >> Active:            63872 kB
> >> Inactive:          19776 kB
> >> Active(anon):       8256 kB
> >> Inactive(anon):     7616 kB
> >>
> >> First kernel is booted with mem=2G crashkernel=1G command line option.
> >> While the system has 64G memory.
> >>
> >> root at arm64:/home/ubuntu/CODE/crash# cat /proc/iomem
> >> 41400000-fffeffff : System RAM
> >>   41480000-420cffff : Kernel code
> >>   42490000-4278ffff : Kernel data
> >> ffff0000-ffffffff : reserved
> >> 100000000-ffaa7ffff : System RAM
> >> ffaa80000-ffaabffff : reserved
> >> ffaac0000-fffa6ffff : System RAM
> >> fffa70000-fffacffff : reserved
> >> fffad0000-fffffffff : System RAM
> > 
> > Are you saying that "mem=..." doesn't have any effect?
> What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
> the memory for second kernel has to be withing the crashkernel size.

Please don't try to use mem= to limit the kernel to a specific range of
memory. It's really only there as a tool to test handling of low-memory
situations. 

While it guarantees that at most, the amount requested will be used
(modulo a number of edge cases with reserved memory ranges), it does not
guarantee *which* memory will be used. It is *very* fragile.

Thanks,
Mark.
