From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 17 Sep 2018 19:39:40 -0400
Subject: [PATCH 5/6] arm64/io: Add header for instrumentation of io
 operations
In-Reply-To: <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <20180917193940.3d68ef88@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  9 Sep 2018 01:57:06 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> The new asm-generic/io-instrumented.h will keep arch code
> clean and separate from instrumented version which traces
> io register accesses. This instrumented header can later
> be included in arm as well for tracing io register accesses.
> 

Looks good to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/include/asm/io.h           | 25 ++++++---------
>  include/asm-generic/io-instrumented.h | 45 +++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 16 deletions(-)
>  create mode 100644 include/asm-generic/io-instrumented.h
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 35b2e50f17fb..768a6a8c5778 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -36,32 +36,27 @@
>  /*
>   * Generic IO read/write.  These perform native-endian accesses.
>   */
> -#define __raw_writeb __raw_writeb
> -static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
> +static inline void arch_raw_writeb(u8 val, volatile void __iomem *addr)
>  {
>  	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
>  }
>  
> -#define __raw_writew __raw_writew
> -static inline void __raw_writew(u16 val, volatile void __iomem *addr)
> +static inline void arch_raw_writew(u16 val, volatile void __iomem *addr)
>  {
>  	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
>  }
>  
> -#define __raw_writel __raw_writel
> -static inline void __raw_writel(u32 val, volatile void __iomem *addr)
> +static inline void arch_raw_writel(u32 val, volatile void __iomem *addr)
>  {
>  	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
>  }
>  
> -#define __raw_writeq __raw_writeq
> -static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> +static inline void arch_raw_writeq(u64 val, volatile void __iomem *addr)
>  {
>  	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
>  }
>  
> -#define __raw_readb __raw_readb
> -static inline u8 __raw_readb(const volatile void __iomem *addr)
> +static inline u8 arch_raw_readb(const volatile void __iomem *addr)
>  {
>  	u8 val;
>  	asm volatile(ALTERNATIVE("ldrb %w0, [%1]",
> @@ -71,8 +66,7 @@ static inline u8 __raw_readb(const volatile void __iomem *addr)
>  	return val;
>  }
>  
> -#define __raw_readw __raw_readw
> -static inline u16 __raw_readw(const volatile void __iomem *addr)
> +static inline u16 arch_raw_readw(const volatile void __iomem *addr)
>  {
>  	u16 val;
>  
> @@ -83,8 +77,7 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
>  	return val;
>  }
>  
> -#define __raw_readl __raw_readl
> -static inline u32 __raw_readl(const volatile void __iomem *addr)
> +static inline u32 arch_raw_readl(const volatile void __iomem *addr)
>  {
>  	u32 val;
>  	asm volatile(ALTERNATIVE("ldr %w0, [%1]",
> @@ -94,8 +87,7 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
>  	return val;
>  }
>  
> -#define __raw_readq __raw_readq
> -static inline u64 __raw_readq(const volatile void __iomem *addr)
> +static inline u64 arch_raw_readq(const volatile void __iomem *addr)
>  {
>  	u64 val;
>  	asm volatile(ALTERNATIVE("ldr %0, [%1]",
> @@ -193,6 +185,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
>  #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
>  
> +#include <asm-generic/io-instrumented.h>
>  #include <asm-generic/io.h>
>  
>  /*
> diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
> new file mode 100644
> index 000000000000..7b050e2487ed
> --- /dev/null
> +++ b/include/asm-generic/io-instrumented.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
> +#define _ASM_GENERIC_IO_INSTRUMENTED_H
> +
> +#if defined(CONFIG_TRACING_EVENTS_IO)
> +#include <linux/tracepoint-defs.h>
> +
> +extern struct tracepoint __tracepoint_io_write;
> +extern struct tracepoint __tracepoint_io_read;
> +#define io_tracepoint_active(t) static_key_false(&(t).key)
> +extern void do_trace_io_write(const char *type, void *addr);
> +extern void do_trace_io_read(const char *type, void *addr);
> +#else
> +#define io_tracepoint_active(t) false
> +static inline void do_trace_io_write(const char *type, void *addr) {}
> +static inline void do_trace_io_read(const char *type, void *addr) {}
> +#endif /* CONFIG_TRACING_EVENTS_IO */
> +
> +#define __raw_write(v, a, _l)	({						\
> +	volatile void __iomem *_a = (a);					\
> +	if (io_tracepoint_active(__tracepoint_io_write))			\
> +		do_trace_io_write(__stringify(write##_l), (void __force *)(_a));\
> +	arch_raw_write##_l((v), _a);						\
> +	})
> +
> +#define __raw_writeb(v, a)	__raw_write((v), a, b)
> +#define __raw_writew(v, a)	__raw_write((v), a, w)
> +#define __raw_writel(v, a)	__raw_write((v), a, l)
> +#define __raw_writeq(v, a)	__raw_write((v), a, q)
> +
> +#define __raw_read(a, _l, _t)    ({						\
> +	_t __a;									\
> +	const volatile void __iomem *_a = (a);					\
> +	if (io_tracepoint_active(__tracepoint_io_read))				\
> +		do_trace_io_read(__stringify(read##_l), (void __force *)(_a));	\
> +	__a = arch_raw_read##_l(_a);						\
> +	__a;									\
> +	})
> +
> +#define __raw_readb(a)	__raw_read((a), b, u8)
> +#define __raw_readw(a)	__raw_read((a), w, u16)
> +#define __raw_readl(a)	__raw_read((a), l, u32)
> +#define __raw_readq(a)	__raw_read((a), q, u64)
> +
> +#endif /* _ASM_GENERIC_IO_INSTRUMENTED_H */
