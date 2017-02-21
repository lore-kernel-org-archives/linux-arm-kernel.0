From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2017 15:49:59 +0000
Subject: [RESEND PATCH] arm64: Add support for VMID aware PIPT
 instruction cache
In-Reply-To: <1487686195-16282-1-git-send-email-shankerd@codeaurora.org>
References: <1487686195-16282-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170221154959.GK300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

Sorry for the delay in responding to this -- the patch isn't as
straightforward as it looks.

On Tue, Feb 21, 2017 at 08:09:55AM -0600, Shanker Donthineni wrote:
> In ARMv8.2 extension, a new instruction cache type 'VMID aware
> PIPT' was introduced in addition to AIVIVT/VIPT/PIPT. Instruction
> cache maintenance operations when issued from Non-secure EL1/EL0
> have an effect only on cache line entries those were fetched in
> Non-secure EL1/EL0 using the current VMID. For software point of
> view, this cache type is same as PIPT and no aliasing problem.

This may well cause problems for KVM with non-VHE, because the host VMID
is different from the guest VMID, yet we assume that I-cache invalidation
by the host *will* affect the guest when, for example, invalidating the
I-cache for pages holding the guest kernel Image.

I have some patches to address this (and some other bits in this area), so
I'll polish them off and post them shortly. Given that we're in the merge
window and this is 4.12 material, it's not urgent.

Will
