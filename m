From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 14:47:43 +0200
Subject: [PATCH RFCv2 3/5] ARM: allow CONFIG_SMP_ON_UP on non-SMP
 configurations
In-Reply-To: <20140527122254.GG3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526163556.GC3693@n2100.arm.linux.org.uk>
 <20140527135918.66a3803f@free-electrons.com>
 <20140527122254.GG3693@n2100.arm.linux.org.uk>
Message-ID: <20140527144743.571131a0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 27 May 2014 13:22:54 +0100, Russell King - ARM Linux wrote:
> On Tue, May 27, 2014 at 01:59:18PM +0200, Thomas Petazzoni wrote:
> > No, because the Armada 370 (single core processor) needs the
> > write-allocate cache policy to provide hardware I/O coherency, but its
> > MPIDR does not indicate it's a SMP-capable processor. So even with
> > CONFIG_SMP_ON_UP=y, is_smp() returns false on Armada 370, and the kernel
> > continues to use the WB cache mode.
> 
> So what's the point of enabling SMP_ON_UP?  If is_smp() returns false
> with SMP=y and SMP_ON_UP=y on Armada 370, then you get none of the
> SMP instructions either.  So I now start to question what the point of
> _this_ patch is, which enables SMP_ON_UP on !SMP capable kernels.
> 
> A SMP kernel will select the non-SMP instructions for a UP CPU, and
> is_smp() will return false.  A UP kernel will compile in the non-SMP
> instructions and is_smp() will be false.  A UP kernel with SMP_ON_UP=y
> will select the non-SMP instructions for your CPU and is_smp() will
> return false.  So what's the point?

The point is this particular patch that allows CONFIG_SMP_ON_UP
on !CONFIG_SMP is to have hardware I/O coherency working in !CONFIG_SMP
configurations for Armada XP, Armada 375 and Armada 38x. The main
reason is that Armada 380 (not 385) is a single core processor, so
people want to run !CONFIG_SMP configurations on it.

However, even when CONFIG_SMP is *disabled*, we want to be able to
provide hardware I/O coherency on Armada 380 (and potentially also
Armada XP and 375, even though those processors have multiple cores, so
the usefulness of running !CONFIG_SMP kernels on these is quite
limited). Note that Armada 380, despite being single core, is
recognized as being SMP-capable, so is_smp() will return true when
!CONFIG_SMP + CONFIG_SMP_ON_UP=y.

In order to provide hardware I/O coherency on these Armada XP, 375
and 38x processors, we need:

 * Write-allocate policy, as is required on Armada 370.
 * SMP bit set in ACTLR
 * Shareable pages

See again the cover letter for this patch series, it really
exhaustively lists all the requirements we need for hardware I/O
coherency to work on the various processors.

Thanks again for your feedback, definitely very useful!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
