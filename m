From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jul 2015 12:17:01 +0100
Subject: [PATCH v2 0/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <55ACD52E.1090701@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <55ACD52E.1090701@arm.com>
Message-ID: <20150720111701.GG20385@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 12:02:06PM +0100, Vladimir Murzin wrote:
> On 17/07/15 18:30, James Morse wrote:
> > This series adds support for Privileged Access Never (PAN; part of the ARMv8.1
> > Extensions). When enabled, this feature causes a permission fault if the kernel
> > attempts to access memory that is also accessible by userspace - instead the
> > PAN bit must be cleared when accessing userspace memory. (or use the
> > ldt*/stt* instructions).
> > 
> > This series detects and enables this feature, and uses alternatives to change
> > {get,put}_user() et al to clear the PAN bit while they do their work.
> > 
> > Changes since v1:
> > * Copied cpuid_feature_extract_field() from arch/arm as a new patch, suggested
> >   by Russell King [1].
> > * Changed feature-detection patch to use cpuid_feature_extract_field() for sign
> >   extension, and '>='.
> > * Moved SCTLR_EL1_* from asm/cputype.h to asm/sysreg.h
> > * Added PSR_PAN_BIT in uapi/asm/ptrace.h
> > * Removed the setting of PSTATE_PAN in kernel/process.c
> > 
> > [1] http://www.spinics.net/lists/arm-kernel/msg432518.html
> 
> Looks like it doesn't play nicely with CONFIG_SWP_EMULATION=y. I get
> segfault while executing swp and PAN is enabled, though I've been
> playing with one of the older version.

Good catch. It looks like __user_swpX_asm in
arch/arm64/kernel/armv8_deprecated.c needs PAN clearing.

-- 
Catalin
