From: joonwoop@codeaurora.org (Joonwoo Park)
Date: Thu, 31 Jul 2014 23:30:09 -0700
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
Message-ID: <20140801063009.GA24602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Catalin, Will

Thanks,
Joonwoo
On Tue, Jul 29, 2014 at 11:28:26PM -0700, Joonwoo Park wrote:
> Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
> as much as possible with minimized barrier usage.  This simplest optimization
> brings faster throughput compare to current byte-by-byte read and write with
> barrier in the loop.  Code's skeleton is taken from the powerpc.
> 
> Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
> Acked-by: Trilok Soni <tsoni@codeaurora.org>
> ---
>  arch/arm64/kernel/io.c | 72 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 62 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
> index 7d37ead..c0e3ab1 100644
> --- a/arch/arm64/kernel/io.c
> +++ b/arch/arm64/kernel/io.c
> @@ -20,18 +20,34 @@
>  #include <linux/types.h>
>  #include <linux/io.h>
>  
> +#define IO_CHECK_ALIGN(v, a) ((((unsigned long)(v)) & ((a) - 1)) == 0)
> +
>  /*
>   * Copy data from IO memory space to "real" memory space.
>   */
>  void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
>  {
> -	unsigned char *t = to;
> -	while (count) {
> +	while (count && (!IO_CHECK_ALIGN(from, 8) || !IO_CHECK_ALIGN(to, 8))) {
> +		*(u8 *)to = readb_relaxed(from);
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
>  }
>  EXPORT_SYMBOL(__memcpy_fromio);
>  
> @@ -40,12 +56,28 @@ EXPORT_SYMBOL(__memcpy_fromio);
>   */
>  void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
>  {
> -	const unsigned char *f = from;
> +	void *p = (void __force *)from;
> +
> +	__iowmb();
> +	while (count && (!IO_CHECK_ALIGN(p, 8) || !IO_CHECK_ALIGN(from, 8))) {
> +		writeb_relaxed(*(volatile u8 *)from, p);
> +		from++;
> +		p++;
> +		count--;
> +	}
> +
> +	while (count >= 8) {
> +		writeq_relaxed(*(volatile u64 *)from, p);
> +		from += 8;
> +		p += 8;
> +		count -= 8;
> +	}
> +
>  	while (count) {
> +		writeb_relaxed(*(volatile u8 *)from, p);
> +		from++;
> +		p++;
>  		count--;
> -		writeb(*f, to);
> -		f++;
> -		to++;
>  	}
>  }
>  EXPORT_SYMBOL(__memcpy_toio);
> @@ -55,10 +87,30 @@ EXPORT_SYMBOL(__memcpy_toio);
>   */
>  void __memset_io(volatile void __iomem *dst, int c, size_t count)
>  {
> +	void *p = (void __force *)dst;
> +	u64 qc = c;
> +
> +	qc |= qc << 8;
> +	qc |= qc << 16;
> +	qc |= qc << 32;
> +
> +	__iowmb();
> +	while (count && !IO_CHECK_ALIGN(p, 8)) {
> +		writeb_relaxed(c, p);
> +		p++;
> +		count--;
> +	}
> +
> +	while (count >= 8) {
> +		writeq_relaxed(c, p);
> +		p += 8;
> +		count -= 8;
> +	}
> +
>  	while (count) {
> +		writeb_relaxed(c, p);
> +		p++;
>  		count--;
> -		writeb(c, dst);
> -		dst++;
>  	}
>  }
>  EXPORT_SYMBOL(__memset_io);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 

-- 
 Sent by an employee of the Qualcomm Innovation Center, Inc.
 The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
