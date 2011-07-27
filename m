From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 27 Jul 2011 10:44:09 +0100
Subject: [PATCH v2] ARM: alignment: Prevent ignoring of faults with ARMv6
	unaligned access model
In-Reply-To: <alpine.LFD.2.00.1107261723040.12766@xanadu.home>
References: <1311689651-7372-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1107261723040.12766@xanadu.home>
Message-ID: <20110727094359.GA2171@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 05:28:57PM -0400, Nicolas Pitre wrote:
> On Tue, 26 Jul 2011, Dave Martin wrote:
> 
> > Currently, it's possible to set the kernel to ignore alignment
> > faults when changing the alignment fault handling mode at runtime
> > via /proc/sys/alignment, even though this is undesirable on ARMv6
> > and above, where it can result in infinite spins where an un-fixed-
> > up instruction repeatedly faults.
> 
> This may be the case only if the U bit in CP15 reg 1 is set, right?
> 
> > In addition, the kernel clobbers any alignment mode specified on
> > the command-line if running on ARMv6 or above.
> > 
> > This patch factors out the necessary safety check into a couple of
> > new helper functions, and checks and modifies the fault handling
> > mode as appropriate on boot and on writes to /proc/cpu/alignment.
> > 
> > Prior to ARMv6, the behaviour is unchanged.
> > 
> > For ARMv6 and above, the behaviour changes as follows:
> > 
> >   * Attempting to ignore faults on ARMv6 results in the mode being
> >     forced to UM_FIXUP instead.  A warning is printed if this
> >     happened as a result of a write to /proc/cpu/alignment.  The
> >     user's UM_WARN bit (if present) is still honoured.
> 
> Why not clearing the U bit as well as the A bit to preserve consistency 
> with the pre ARMv6 behavior?

The old unaligned access behaviour is deprecated in ARMv6 (I believe)
and is not supported at all in ARMv7 -- i.e., you can't turn the U bit
off.  So this would be an additional special behaviour for ARMv6 only.

I'm not sure that introducing yet another behaviour is useful here;
anyone with legacy userspace software relying on the old unaligned
access model presumably fixed it years ago.

Really, the patch was just intended resolve the inconsistency where
the policy the kernel enforces for the alignment fixup mode on bootup
is not enforced at run-time.

Cheers
---Dave
