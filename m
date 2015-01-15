From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jan 2015 15:28:26 +0000
Subject: [PATCH v2] arm64: kill off the libgcc dependency
In-Reply-To: <1421323653-27214-1-git-send-email-haokexin@gmail.com>
References: <1421323653-27214-1-git-send-email-haokexin@gmail.com>
Message-ID: <20150115152826.GD2329@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 12:07:33PM +0000, Kevin Hao wrote:
> The arm64 kernel builds fine without the libgcc. Actually it should not
> be used at all in the kernel. The following are the reasons indicated
> by Russell King:
>   Although libgcc is part of the compiler, libgcc is built with the
>   expectation that it will be running in userland - it expects to link
>   to a libc.  That's why you can't build libgcc without having the glibc
>   headers around.
> 
>   For example, on ARM, libgcc.a may contain calls to __div0, and it may
>   provide its own __div0 implementation, which invokes various Linux
>   system calls.
> 
>   Various functions reference _GLOBAL_OFFSET_TABLE_ which we don't want
>   to have in the kernel.
> 
>   Depending on how the compiler was built, libgcc.a may be built for
>   ARMv4, ARMv5, ARMv6 or ARMv7, and may not be appropriate for linking
>   with the kernel.  (Eg, you wouldn't want to try to link an ARMv7
>   libgcc.a in an ARMv5 kernel - and we /really/ don't want the mess
>   of having different toolchains for different ARM arch versions.)
> 
>   It may also drag in the userspace exception unwind support.
> 
>   Meanwhile, having the kernel build the compiler support functions that
>   it needs ensures that (a) we know what compiler support functions are
>   being used, (b) we know the implementation of those support functions
>   are sane for use in the kernel, (c) we can build them with appropriate
>   compiler flags for best performance, and (d) we remove an unnecessary
>   dependency on the build toolchain.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks. I'll queue this for 3.20 but I'll edit the commit log a bit as
not all of it makes sense on arm64.

-- 
Catalin
