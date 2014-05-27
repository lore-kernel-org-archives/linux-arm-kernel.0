From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 May 2014 13:22:54 +0100
Subject: [PATCH RFCv2 3/5] ARM: allow CONFIG_SMP_ON_UP on non-SMP
 configurations
In-Reply-To: <20140527135918.66a3803f@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526163556.GC3693@n2100.arm.linux.org.uk>
 <20140527135918.66a3803f@free-electrons.com>
Message-ID: <20140527122254.GG3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 01:59:18PM +0200, Thomas Petazzoni wrote:
> No, because the Armada 370 (single core processor) needs the
> write-allocate cache policy to provide hardware I/O coherency, but its
> MPIDR does not indicate it's a SMP-capable processor. So even with
> CONFIG_SMP_ON_UP=y, is_smp() returns false on Armada 370, and the kernel
> continues to use the WB cache mode.

So what's the point of enabling SMP_ON_UP?  If is_smp() returns false
with SMP=y and SMP_ON_UP=y on Armada 370, then you get none of the
SMP instructions either.  So I now start to question what the point of
_this_ patch is, which enables SMP_ON_UP on !SMP capable kernels.

A SMP kernel will select the non-SMP instructions for a UP CPU, and
is_smp() will return false.  A UP kernel will compile in the non-SMP
instructions and is_smp() will be false.  A UP kernel with SMP_ON_UP=y
will select the non-SMP instructions for your CPU and is_smp() will
return false.  So what's the point?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
