From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jul 2018 15:41:40 +0100
Subject: [PATCH v6 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1533042538-26184-2-git-send-email-vladimir.murzin@arm.com>
References: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
 <1533042538-26184-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180731144140.m4gtxlny22hqjo55@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 02:08:56PM +0100, Vladimir Murzin wrote:
> Common Not Private (CNP) is a feature of ARMv8.2 extension which
> allows translation table entries to be shared between different PEs in
> the same inner shareable domain, so the hardware can use this fact to
> optimise the caching of such entries in the TLB.
> 
> CNP occupies one bit in TTBRx_ELy and VTTBR_EL2, which advertises to
> the hardware that the translation table entries pointed to by this
> TTBR are the same as every PE in the same inner shareable domain for
> which the equivalent TTBR also has CNP bit set. In case CNP bit is set
> but TTBR does not point at the same translation table entries for a
> given ASID and VMID, then the system is mis-configured, so the results
> of translations are UNPREDICTABLE.
> 
> For kernel we postpone setting CNP till all cpus are up and rely on
> cpufeature framework to 1) patch the code which is sensitive to CNP
> and 2) update TTBR1_EL1 with CNP bit set. TTBR1_EL1 can be
> reprogrammed as result of hibernation or cpuidle (via __enable_mmu).
> For these two cases we restore CnP bit via __cpu_suspend_exit().
> 
> There are a few cases we need to care of changes in TTBR0_EL1:
>   - a switch to idmap
>   - software emulated PAN
> 
> we rule out latter via Kconfig options and for the former we make
> sure that CNP is set for non-zero ASIDs only.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

However, I think it's pretty late for 4.19 and the changes are not
trivial. I'll pick it up after the merging window so that it sits in
linux-next for a while.

-- 
Catalin
