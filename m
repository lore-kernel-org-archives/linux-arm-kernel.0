From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 17:03:39 +0100
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <4DA84AAB.60601@gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com>
Message-ID: <20110415160339.GF4423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 08:39:55AM -0500, Rob Herring wrote:
> Russell,
>
> On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
>> This is work in progress.
>>
>> We have two SoCs using SRAM, both with their own allocation systems,
>> and both with their own ways of copying functions into the SRAM.
>
> It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.

Hmm, that's nice - except for one issue.  According to my grep of
arch/arm/ and drivers/, nothing uses iram_alloc().  So, does anything in
the MX stuff use iram_alloc.c, or is it dead code left over from a
previous experiment?

The commit says:

    ARM: imx: Add iram allocator functions

    Add IRAM(Internal RAM) allocation functions using GENERIC_ALLOCATOR.
    The allocation size is 4KB multiples to guarantee alignment. The
    idea for these functions is for i.MX platforms to use them
    to dynamically allocate IRAM usage.

    Applies on 2.6.36-rc7

> lpc32xx and pnx4008 also use iram, but do not have an allocator (only 1  
> user). Both are doing a copy the suspend code to IRAM and run it which  
> may also be a good thing to have generic code for. Several i.MX chips  
> also need to run from IRAM for suspend.

We have support for copying functions to other bits of memory and getting
the Thumb-ness right - see asm/fncpy.h.  So that's a separate patch to
convert them over.
