From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 May 2018 16:58:55 +0100
Subject: [PATCH v2 00/17] arm64 SSBD (aka Spectre-v4) mitigation
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Message-ID: <20180530155854.GA4122@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, May 29, 2018 at 01:11:04PM +0100, Marc Zyngier wrote:
> This patch series implements the Linux kernel side of the "Spectre-v4"
> (CVE-2018-3639) mitigation known as "Speculative Store Bypass Disable"
> (SSBD).
> 
> More information can be found at:
> 
>   https://bugs.chromium.org/p/project-zero/issues/detail?id=1528
>   https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability
> 
> For all released Arm Cortex-A CPUs that are affected by this issue, then
> the preferred mitigation is simply to set a chicken bit in the firmware
> during CPU initialisation and therefore no change to Linux is required.
> Other CPUs may require the chicken bit to be toggled dynamically (for
> example, when switching between user-mode and kernel-mode) and this is
> achieved by calling into EL3 via an SMC which has been published as part
> of the latest SMCCC specification:
> 
>   https://developer.arm.com/cache-speculation-vulnerability-firmware-specification
> 
> as well as an ATF update for the released ARM cores affected by SSBD:
> 
>   https://github.com/ARM-software/arm-trusted-firmware/pull/1392
> 
> These patches provide the following:
> 
>   1. Safe probing of firmware to establish which CPUs in the system
>      require calling into EL3 as part of the mitigation.
> 
>   2. For CPUs that require it, call into EL3 on exception entry/exit
>      from EL0 to apply the SSBD mitigation when running at EL1.
> 
>   3. A command-line option to force the SSBD mitigation to be always on,
>      always off, or dymamically toggled (default) for CPUs that require
>      the EL3 call.
> 
>   4. An initial implementation of a prctl() backend for arm64 that allows
>      userspace tasks to opt-in to the mitigation explicitly. This is
>      intended to match the interface provided by x86, and so we rely on
>      their core changes here. The seccomp interface is provided as an
>      extra set of patches, which I'd like *not* to see merged. The main
>      reason is that it is invasive, has ugly/unclear semantics, and could
>      probably be left to the existing prctl interface.

I agree with you here. For patches 1-10, then:

Acked-by: Will Deacon <will.deacon@arm.com>

but I'd prefer to leave the seccomp stuff alone for the moment because I
don't think the implicit enabling is necessarily the right thing to do
there and supporting it comes at a cost.

Will
