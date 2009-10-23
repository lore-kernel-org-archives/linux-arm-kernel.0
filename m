From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Oct 2009 17:54:21 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023123600.GB22853@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
Message-ID: <1256316861.6564.154.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 13:36 +0100, Russell King - ARM Linux wrote:
> If you have a shared ownership ring buffer, you need the writes for
> updating the DMA pointers to hit it before the write to change the
> ownership of the descriptor to device.  Reverse those two writes and
> you end up transmitting junk.

But if we have arch_is_coherent() enabled (possibly with hardware
support like ARM's ACP), we need the drivers to have barriers anyway
since we would use normal cached memory (and ordering isn't guaranteed).
Of course, one has to go through the drivers used with a platform and
check them but we already have a precedent.

BTW, there are two other architectures (x86 and PowerPC) with a similar
restriction. Do they do anything about this in Linux?

PowerPC, 4.8.1 (page 36):

http://pcsostres.ac.upc.edu/cellsim/lib/exe/fetch.php/book_iii.powerpc_operating_environment_architecture.version_2.01.es-archpub3.pdf?id=additional_cell_documents&cache=cache

x86, 10.12.4 (page 10-44):

ftp://download.intel.com/support/processors/celeron/sb/25366820.pdf

-- 
Catalin
