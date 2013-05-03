From: rric@kernel.org (Robert Richter)
Date: Fri, 3 May 2013 13:53:32 +0200
Subject: [PATCH, RFC 14/22] oprofile: always enable IRQ_WORK
In-Reply-To: <1367507786-505303-15-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-15-git-send-email-arnd@arndb.de>
Message-ID: <20130503115332.GT8356@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.05.13 17:16:18, Arnd Bergmann wrote:
> oprofile fails to build if CONFIG_IRQ_WORK is not already enabled,
> because of the dependency on the RING_BUFFER code that now uses
> the irq work library.
> 
> kernel/built-in.o: In function `ring_buffer_unlock_commit':
> :(.text+0x5b8f0): undefined reference to `irq_work_queue'
> kernel/built-in.o: In function `ring_buffer_write':
> :(.text+0x5bd10): undefined reference to `irq_work_queue'

Shouldn't this be fixed in the ring_buffer implementation?

I also do not see, where this comes from. I was successfully compiling
a kernel with OPROFILE and RING_BUFFER enabled but IRQ_WORK disabled.
Do you have that config still available?

Thanks,

-Robert

> 
> Cc: Robert Richter <rric@kernel.org>
> Cc: oprofile-list at lists.sf.net
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a6b1056..434a8dc 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -8,6 +8,7 @@ config OPROFILE
>  	depends on HAVE_OPROFILE
>  	select RING_BUFFER
>  	select RING_BUFFER_ALLOW_SWAP
> +	select IRQ_WORK
>  	help
>  	  OProfile is a profiling system capable of profiling the
>  	  whole system, include the kernel, kernel modules, libraries,
> -- 
> 1.8.1.2
> 
