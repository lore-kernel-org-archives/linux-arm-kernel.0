From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Feb 2014 14:08:57 -0800
Subject: [PATCH] ARM: spinlock: ensure we have a compiler barrier before
 sev
In-Reply-To: <1391516926-14493-1-git-send-email-will.deacon@arm.com>
References: <1391516926-14493-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140204220857.GQ4167@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 12:28:46PM +0000, Will Deacon wrote:
> When unlocking a spinlock, we require the following, strictly ordered
> sequence of events:
> 
> 	<barrier>	/* dmb */
> 	<unlock>
> 	<barrier>	/* dsb */
> 	<sev>
> 
> Whilst the code does indeed reflect this in terms of the architecture,
> the final <barrier> + <sev> have been contracted into a single inline
> asm without a "memory" clobber, therefore the compiler is at liberty to
> reorder the unlock to the end of the above sequence. In such a case,
> a waiting CPU may be woken up before the lock has been unlocked, leading
> to extremely poor performance.
> 
> This patch reworks the dsb_sev() function to make use of the dsb()
> macro and ensure ordering against the unlock.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

FWIW: Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
