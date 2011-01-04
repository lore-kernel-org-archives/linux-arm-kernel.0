From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 10:41:12 +0000
Subject: [PATCH 0/4] variable PHYS_OFFSET support
In-Reply-To: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
Message-ID: <20110104104112.GB16671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 03:20:04AM -0500, Nicolas Pitre wrote:
> So here it is, in a form which I think should be ready for merging.
> 
> ARM mode is well tested.
> Thumb2 mode is only compile tested at the moment.

I don't believe this is ready for merging - there's still work to be
done with the early assembly code using PHYS_OFFSET.  That currently
doesn't _appear_ to be a problem because it still uses the old platform
specific setting of PHYS_OFFSET - and that needs careful thought as:

#if (PHYS_OFFSET & 0x001fffff)
#error "PHYS_OFFSET must be at an even 2MiB boundary!"
#endif

has been eroded from 16MB downwards to 2MB over time because of
platform setups - eg, MSM for example.

As we're having to store the p:v offset (it's cheaper to store it than
your way of making PHYS_OFFSET depend on the translation and PAGE_OFFSET)
then we might as well also store what we think is the physical offset
and use that for PHYS_OFFSET too once the assembly code issue has been
sorted.

So, what I suggest is a different patch ordering:

1. Fix the assembly code not to rely upon a fixed PHYS_OFFSET (is this
   even possible with the 2MB requirement?)

2. Fix the initializers in platform code (ignoring MSM).

3. Rename PHYS_OFFSET to be PLAT_PHYS_OFFSET in platform memory.h files,
   defining PHYS_OFFSET in asm/memory.h to be PLAT_PHYS_OFFSET.  (We
   could make PHYS_OFFSET at this point be a variable, which'd stop any
   new initializers using PHYS_OFFSET - which I think would be beneficial
   anyway.)

4. Introduce P2V patching _with_ the module support.  With this patch
   create __pv_phys_offset, and if P2V patching is enabled, redefine
   PHYS_OFFSET to be this variable.  Note that __pv_phys_offset would
   need to be exported to modules.

So, I don't think it's ready for this coming merge window.
