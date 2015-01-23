From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 14:52:36 +0000
Subject: [PATCH] ARM: use default ioremap alignment for SMP or LPAE
In-Reply-To: <3060178.HEZJjJCl1e@wuerfel>
References: <1421911075-8814-1-git-send-email-s.dyasly@samsung.com>
 <20150122100441.GA19811@e104818-lin.cambridge.arm.com>
 <3060178.HEZJjJCl1e@wuerfel>
Message-ID: <20150123145235.GB21789@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:03:00AM +0000, Arnd Bergmann wrote:
> Unrelated to this question however is whether we want to keep
> supersection mappings as a performance optimization to save TLBs.
> It seems useful to me, but not critical.

Currently in Linux we allow 16MB mappings only if the phys address is
over 32-bit and !LPAE which makes it unlikely for normal RAM with
pre-LPAE hardware.

IIRC a bigger problem was that supersections are optional in the
architecture but there was no CPUID bit field in ARMv6 (and early ARMv7)
to check for their presence. The ID_MMFR3 contains this information but
for example on early Cortex-A8 that bitfield was reserved and the TRM
states "unpredictable" on read (so probably zero in practice).

On newer ARMv7 (not necessarily with LPAE), we could indeed revisit the
16MB section mapping but it won't go well with single zImage if you want
to support earlier ARMv7 or ARMv6.

-- 
Catalin
