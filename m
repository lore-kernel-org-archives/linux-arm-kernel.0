From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jun 2016 11:57:50 +0100
Subject: [PATCH] arm64: Add support ARCH_SUPPORTS_INT128
In-Reply-To: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160622105749.GA6521@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 02:55:23PM +0800, Kefeng Wang wrote:
> The gcc support __SIZEOF_INT128__ and __int128 in arm64, thus,
> enable ARCH_SUPPORTS_INT128 to make mul_u64_u32_shr() a bit
> more efficient in scheduler.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..ab319eb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ARM64
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_INT128
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION

With this patch and UBSAN+KASAN enabled, Linux fails to link with:

lib/built-in.o: In function `get_signed_val':
lib/ubsan.c:93: undefined reference to `__ashlti3'
lib/ubsan.c:93: undefined reference to `__ashrti3'

It succeeds if I revert commit d67703a8a69e ("arm64: kill off the libgcc
dependency"). We may have to revisit that decision or implement the
required library functions in the kernel. In general, I'd like to reduce
the amount of code duplication if the functionality can be found
elsewhere like in libgcc. There is a risk of not knowing precisely what
ligbcc relies on (like libc functions), though there are other
architectures linking against it.

-- 
Catalin
