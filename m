From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jun 2011 15:53:26 +0100
Subject: [PATCH v3 1/9] ARM: l2x0: fix disabling function to avoid deadlock
In-Reply-To: <1308158600-7169-2-git-send-email-will.deacon@arm.com>
References: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
	<1308158600-7169-2-git-send-email-will.deacon@arm.com>
Message-ID: <20110616145326.GA21494@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 06:23:12PM +0100, Will Deacon wrote:
> The l2x0_disable function attempts to writel with the l2x0_lock held.
> This results in deadlock when the writel contains an outer_sync call
> for the platform since the l2x0_lock is already held by the disable
> function. A further problem is that disabling the L2 without flushing it
> first can lead to the spin_lock operation becoming visible after the
> spin_unlock, causing any subsequent L2 maintenance to deadlock.
> 
> This patch replaces the writel with a call to writel_relaxed in the
> disabling code and adds a flush before disabling in the control
> register, preventing livelock from occurring.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
