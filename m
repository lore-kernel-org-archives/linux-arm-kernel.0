From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 20 Jul 2015 12:02:06 +0100
Subject: [PATCH v2 0/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <1437154221-5736-1-git-send-email-james.morse@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
Message-ID: <55ACD52E.1090701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/15 18:30, James Morse wrote:
> This series adds support for Privileged Access Never (PAN; part of the ARMv8.1
> Extensions). When enabled, this feature causes a permission fault if the kernel
> attempts to access memory that is also accessible by userspace - instead the
> PAN bit must be cleared when accessing userspace memory. (or use the
> ldt*/stt* instructions).
> 
> This series detects and enables this feature, and uses alternatives to change
> {get,put}_user() et al to clear the PAN bit while they do their work.
> 
> Changes since v1:
> * Copied cpuid_feature_extract_field() from arch/arm as a new patch, suggested
>   by Russell King [1].
> * Changed feature-detection patch to use cpuid_feature_extract_field() for sign
>   extension, and '>='.
> * Moved SCTLR_EL1_* from asm/cputype.h to asm/sysreg.h
> * Added PSR_PAN_BIT in uapi/asm/ptrace.h
> * Removed the setting of PSTATE_PAN in kernel/process.c
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg432518.html
> 

Hi James,

Looks like it doesn't play nicely with CONFIG_SWP_EMULATION=y. I get
segfault while executing swp and PAN is enabled, though I've been
playing with one of the older version.

Vladimir

> 
> James Morse (6):
>   arm64: kernel: Add cpuid_feature_extract_field() for 4bit sign
>     extension
>   arm64: kernel: preparatory: Move config_sctlr_el1
>   arm64: kernel: Add cpufeature 'enable' callback
>   arm64: kernel: Add min_register_value and use '>=' for feature
>     detection
>   arm64: kernel: Add optional CONFIG_ parameter to ALTERNATIVE()
>   arm64: kernel: Add support for Privileged Access Never
> 
>  arch/arm64/Kconfig                   | 14 +++++++++++++
>  arch/arm64/include/asm/alternative.h | 28 ++++++++++++++++++++++---
>  arch/arm64/include/asm/cpufeature.h  | 21 ++++++++++++++++---
>  arch/arm64/include/asm/cputype.h     |  3 ---
>  arch/arm64/include/asm/futex.h       |  8 ++++++++
>  arch/arm64/include/asm/processor.h   |  2 ++
>  arch/arm64/include/asm/sysreg.h      | 21 +++++++++++++++++++
>  arch/arm64/include/asm/uaccess.h     | 11 ++++++++++
>  arch/arm64/include/uapi/asm/ptrace.h |  1 +
>  arch/arm64/kernel/armv8_deprecated.c | 11 +---------
>  arch/arm64/kernel/cpufeature.c       | 40 +++++++++++++++++++++++++++++++++---
>  arch/arm64/lib/clear_user.S          |  8 ++++++++
>  arch/arm64/lib/copy_from_user.S      |  8 ++++++++
>  arch/arm64/lib/copy_in_user.S        |  8 ++++++++
>  arch/arm64/lib/copy_to_user.S        |  8 ++++++++
>  arch/arm64/mm/fault.c                | 23 +++++++++++++++++++++
>  16 files changed, 193 insertions(+), 22 deletions(-)
> 
