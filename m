From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2015 12:16:28 +0000
Subject: [PATCH] ARM64: fix building without CONFIG_UID16
In-Reply-To: <3891403.6hGat7eHq5@wuerfel>
References: <3891403.6hGat7eHq5@wuerfel>
Message-ID: <20151125121628.GE3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 12:12:21PM +0100, Arnd Bergmann wrote:
> As reported by Michal Simek, building an ARM64 kernel with CONFIG_UID16
> disabled currently fails because the system call table still needs to
> reference the individual function entry points that are provided by
> kernel/sys_ni.c in this case, and the declarations are hidden inside
> of #ifdef CONFIG_UID16:
> 
> arch/arm64/include/asm/unistd32.h:57:8: error: 'sys_lchown16' undeclared here (not in a function)
>  __SYSCALL(__NR_lchown, sys_lchown16)
> 
> I believe this problem only exists on ARM64, because older architectures
> tend to not need declarations when their system call table is built
> in assembly code, while newer architectures tend to not need UID16
> support. ARM64 only uses these system calls for compatibility with
> 32-bit ARM binaries.
> 
> This changes the CONFIG_UID16 check into CONFIG_HAVE_UID16, which is
> set unconditionally on ARM64 with CONFIG_COMPAT, so we see the
> declarations whenever we need them, but otherwise the behavior is
> unchanged.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org
> Fixes: af1839eb4bd4 ("Kconfig: clean up the long arch list for the UID16 config option")

Applied. Thank.

-- 
Catalin
