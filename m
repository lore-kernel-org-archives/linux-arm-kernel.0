From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 2 Nov 2017 10:05:35 +0000
Subject: [PATCH] arm64: write_sysreg asm illegal for aarch32
In-Reply-To: <20171101170014.20931-1-salyzyn@android.com>
References: <20171101170014.20931-1-salyzyn@android.com>
Message-ID: <f69cfc20-60e1-6c5c-5baf-7c7ae5b58ab1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 16:58, Mark Salyzyn wrote:
> Cross compiling to aarch32 (for vdso32) using clang correctly
> identifies that (the unused) write_sysreg inline asm directive is
> illegal in that architectural context:
> 
> arch/arm64/include/asm/arch_timer.h: error: invalid input constraint 'rZ' in asm
>         write_sysreg(cntkctl, cntkctl_el1);
>         ^
> arch/arm64/include/asm/sysreg.h: note: expanded from macro 'write_sysreg'
>                      : : "rZ" (__val));
>                          ^
> 
> GCC normally checks for correctness everywhere. But uniquely for
> unused asm, will optimize out and suppress the error report.

-ENOTABUG.

Please fix the build system instead (why on Earth are you using arm64
headers for an Aarch32 binary?), and don't introduce stuff that is
making understanding the kernel more difficult to understand and maintain.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
