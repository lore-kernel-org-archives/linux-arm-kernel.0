From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jan 2010 22:53:51 +0000
Subject: [PATCH 0/5] Adding x86-like memory map printks to ARM.
In-Reply-To: <1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20100115225351.GB28222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 11:36:05AM +0100, Andreas Fenkart wrote:
> This version has the following changes:
> 
> * Reworked UL() macro usage, as suggested
> 
> * Appended 'UL' to VMALLOC_END define of new machines:
> mach-dove
> mach-u300
> mach-ux500
> 
> * Patch 'Make totalhigh_pages unsigned long' has been submitted separately
> 
> * Removed superfluous (VMALLOC_START < VMALLOC_END) boundary check
> 

What I get from the Integrator/CP platform is this:

virtual kernel memory layout:                                                   
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                               
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)                               
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)                               
    vmalloc : 0xc8800000 - 0xd0000000   ( 120 MB)                               
    lowmem  : 0x00001000 - 0xc8000000   (3199 MB)                               
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)                               
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)                               
      .init : 0xc0008000 - 0xc0024000   ( 112 kB)                               
      .text : 0xc0024000 - 0xc0325000   (3076 kB)                               
      .data : 0xc0326000 - 0xc033f360   ( 101 kB)                               

which looks fine, except for the 'lowmem' entry - the start of it should
be PAGE_OFFSET, not PAGE_SIZE.  Apart from that, seems fine.

If you can correct that bug, and no one else has any objections, it can
go into the patch system.  Thanks.
