From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 19:50:43 +0100
Subject: [PATCH 7/8] ARM: Use the Inner Shareable I-cache and BTB ops
	on ARMv7 SMP
In-Reply-To: <20100504164454.26355.7003.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164454.26355.7003.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100528185043.GA5189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 05:44:54PM +0100, Catalin Marinas wrote:
> The standard I-cache Invalidate All (ICIALLU) and Branch Predication
> Invalidate All (BPIALL) operations are not automatically broadcast to
> the other CPUs in an ARMv7 MP system. The patch adds the Inner Shareable
> variants, ICIALLUIS and BPIALLIS, if ARMv7 and SMP.

FYI, I'm considering reverting this patch; this patch is one of two
responsible for causing a stability regression of Versatile Express
platform.

The two commits responsible for making Versatile Express userspace
completely unstable are:

b8349b569aae661dea9d59d7d2ee587ccea3336c
ARM: 6112/1: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP

7e5a69e83ba7a0d5917ad830f417cba8b8d6aa72
ARM: 6007/1: fix highmem with VIPT cache and DMA

Most of the instability is from the second patch, but reverting just
the second patch doesn't fully restore userspace stability.
