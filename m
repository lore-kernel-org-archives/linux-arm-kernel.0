From: james.morse@arm.com (James Morse)
Date: Wed, 13 Dec 2017 14:19:48 +0000
Subject: [PATCH v2 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1507724395-13735-2-git-send-email-vladimir.murzin@arm.com>
References: <1507724395-13735-1-git-send-email-vladimir.murzin@arm.com>
 <1507724395-13735-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <5A313704.1090503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 11/10/17 13:19, Vladimir Murzin wrote:
> Common Not Private (CNP) is a feature of ARMv8.2 extension which
> allows translation table entries to be shared between different PEs in
> the same inner shareable domain, so the hardware can use this fact to
> optimise the caching of such entries in the TLB.
> 
> CNP occupies one bit in TTBRx_ELy and VTTBR_EL2, which advertises to
> the hardware that the translation table entries pointed to by this
> TTBR are the same as every PE in the same inner shareable domain for
> which the equivalent TTBR also has CNP bit set. In case CNP bit is set
> but TTBR does not point at the same translation table entries or a
> given ASID and VMID, then the system is mis-configured, so the results
> of translations are UNPREDICTABLE.
> 
> This patch adds support for Common Not Private translations on
> different exceptions levels:
> 
> (1) For EL0 there are a few cases we need to care of changes in
>     TTBR0_EL1:
>     - a switch to idmap
>     - software emulated PAN
>     we rule out latter via Kconfig options and for the former we make
>     sure that CNP is set for non-zero ASIDs only.
> 
> (2) For EL1 we postpone setting CNP till all cpus are up and rely on
>     cpufeature framework to 1) patch the code which is sensitive to
>     CNP and 2) update TTBR1_EL1 with CNP bit set. TTBR1_EL1 can be
>     reprogrammed as result of hibernation or cpuidle (via __enable_mmu).
>     cpuidle's path has been changed to restore CnP and for hibernation
>     the code has been changed to save raw TTBR1_EL1 and blindly restore
>     it on resume.


While I remember:

This feature is going to be fun for kdump, we may leave secondary CPUs running
if they don't take the IPI to crash-out of the kernel. Worse, if we don't have
PSCI they just spin in a loop while the surviving CPU brings up the crash kernel
and maybe-enables CNP...

I think the best fix for this is to refuse to enable CNP at all if we're a crash
kernel. There is stuff in the DT to indicate this... we should know about the
'elfcorehdr' before cpufeature runs. (I don't think we should rely on the
cmdline option).

kexec is unaffected because it always powers-off the secondary CPUs before
leaving the old kernel. This behaves much more like a normal boot.


Thanks,

James
