From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Jul 2011 17:28:57 -0400 (EDT)
Subject: [PATCH v2] ARM: alignment: Prevent ignoring of faults with ARMv6
	unaligned access model
In-Reply-To: <1311689651-7372-1-git-send-email-dave.martin@linaro.org>
References: <1311689651-7372-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1107261723040.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2011, Dave Martin wrote:

> Currently, it's possible to set the kernel to ignore alignment
> faults when changing the alignment fault handling mode at runtime
> via /proc/sys/alignment, even though this is undesirable on ARMv6
> and above, where it can result in infinite spins where an un-fixed-
> up instruction repeatedly faults.

This may be the case only if the U bit in CP15 reg 1 is set, right?

> In addition, the kernel clobbers any alignment mode specified on
> the command-line if running on ARMv6 or above.
> 
> This patch factors out the necessary safety check into a couple of
> new helper functions, and checks and modifies the fault handling
> mode as appropriate on boot and on writes to /proc/cpu/alignment.
> 
> Prior to ARMv6, the behaviour is unchanged.
> 
> For ARMv6 and above, the behaviour changes as follows:
> 
>   * Attempting to ignore faults on ARMv6 results in the mode being
>     forced to UM_FIXUP instead.  A warning is printed if this
>     happened as a result of a write to /proc/cpu/alignment.  The
>     user's UM_WARN bit (if present) is still honoured.

Why not clearing the U bit as well as the A bit to preserve consistency 
with the pre ARMv6 behavior?


Nicolas
