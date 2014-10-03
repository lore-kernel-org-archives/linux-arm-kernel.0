From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Oct 2014 17:31:42 +0100
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20140801063009.GA24602@codeaurora.org>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
Message-ID: <20141003163141.GC2384@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 11:28:26PM -0700, Joonwoo Park wrote:
> Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
> as much as possible with minimized barrier usage.  This simplest optimization
> brings faster throughput compare to current byte-by-byte read and write with
> barrier in the loop.  Code's skeleton is taken from the powerpc.
> 
> Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
> Acked-by: Trilok Soni <tsoni@codeaurora.org>

I thought about merging this but there are some issues. Comments below.

> diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
> index 7d37ead..c0e3ab1 100644
> --- a/arch/arm64/kernel/io.c
> +++ b/arch/arm64/kernel/io.c
> @@ -20,18 +20,34 @@
>  #include <linux/types.h>
>  #include <linux/io.h>
>  
> +#define IO_CHECK_ALIGN(v, a) ((((unsigned long)(v)) & ((a) - 1)) == 0)

Can you not use just IS_ALIGNED?

>  /*
>   * Copy data from IO memory space to "real" memory space.
>   */
>  void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
>  {
> -	unsigned char *t = to;
> -	while (count) {
> +	while (count && (!IO_CHECK_ALIGN(from, 8) || !IO_CHECK_ALIGN(to, 8))) {
> +		*(u8 *)to = readb_relaxed(from);

We should not use the relaxed accessors here as we don't really care
about endianness conversion. We just copy data from one place to another
without interpreting it, so __raw_read*() is sufficient.

> +		from++;
> +		to++;
>  		count--;
> -		*t = readb(from);
> -		t++;
> +	}
> +
> +	while (count >= 8) {
> +		*(u64 *)to = readq_relaxed(from);
> +		from += 8;
> +		to += 8;
> +		count -= 8;
> +	}
> +
> +	while (count) {
> +		*(u8 *)to = readb_relaxed(from);
>  		from++;
> +		to++;
> +		count--;
>  	}
> +	__iormb();

We don't need this barrier here. In the readl() implementation, it's use
is for ordering between I/O polling and DMA buffer access.

>  }
>  EXPORT_SYMBOL(__memcpy_fromio);
>  
> @@ -40,12 +56,28 @@ EXPORT_SYMBOL(__memcpy_fromio);
>   */
>  void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
>  {
> -	const unsigned char *f = from;
> +	void *p = (void __force *)from;

Why do you need this?

> +
> +	__iowmb();

Not needed here either.

> +	while (count && (!IO_CHECK_ALIGN(p, 8) || !IO_CHECK_ALIGN(from, 8))) {
> +		writeb_relaxed(*(volatile u8 *)from, p);

Oh, so you copy from "from" to "from". Have you really tested this?

> @@ -55,10 +87,30 @@ EXPORT_SYMBOL(__memcpy_toio);
>   */
>  void __memset_io(volatile void __iomem *dst, int c, size_t count)
>  {
> +	void *p = (void __force *)dst;

Do you need this?

> +	u64 qc = c;
> +
> +	qc |= qc << 8;
> +	qc |= qc << 16;
> +	qc |= qc << 32;
> +
> +	__iowmb();

What's this for?

> +	while (count && !IO_CHECK_ALIGN(p, 8)) {
> +		writeb_relaxed(c, p);

Using dst here directly here should work (__raw_writeb takes the same
type as the second argument).


-- 
Catalin
