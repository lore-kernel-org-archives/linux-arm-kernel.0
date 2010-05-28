From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 19:56:04 +0100
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1004111033010.7232@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
Message-ID: <20100528185604.GB5189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 11, 2010 at 10:42:06AM -0400, Nicolas Pitre wrote:
> Do you have concerns about patch #6007/1 that I might have missed? 
> Otherwise it would be nice to move it towards mainline for ARMv6 
> targets to work properly with highmem at last.

FYI, I'm considering reverting this patch; this patch is one of two
responsible for causing a stability regression of Versatile Express
platform - a highmem+Cortex A9 MPCore system with VIPT non-aliasing
caches.

The two commits responsible for making Versatile Express userspace
completely unstable are:

b8349b569aae661dea9d59d7d2ee587ccea3336c
ARM: 6112/1: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP

7e5a69e83ba7a0d5917ad830f417cba8b8d6aa72
ARM: 6007/1: fix highmem with VIPT cache and DMA

Most of the instability is from the second (this) patch, but reverting
just one patch doesn't fully restore userspace stability.

The instability seen consists of completely random SIGSEGVs and SIGILLs,
sometimes early enough to kill init, sometimes init is the only thing
able to run - so it's very severe.

Rootfs is on ext2fs on a read only MMC filesystem, using the MMCI driver.
No swap.
