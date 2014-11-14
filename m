From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Nov 2014 13:46:45 +0000
Subject: [PATCH V3] arm64: percpu: Implement this_cpu operations
In-Reply-To: <1415965077-10495-1-git-send-email-steve.capper@linaro.org>
References: <20141107135205.GA7591@linaro.org>
 <1415965077-10495-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20141114134644.GD27963@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Fri, Nov 14, 2014 at 11:37:57AM +0000, Steve Capper wrote:
> The generic this_cpu operations disable interrupts to ensure that the
> requested operation is protected from pre-emption. For arm64, this is
> overkill and can hurt throughput and latency.
> 
> This patch provides arm64 specific implementations for the this_cpu
> operations. Rather than disable interrupts, we use the exclusive
> monitor or atomic operations as appropriate.
> 
> The following operations are implemented: add, add_return, and, or,
> read, write, xchg. We also wire up a cmpxchg implementation from
> cmpxchg.h.
> 
> Testing was performed using the percpu_test module and hackbench on a
> Juno board running 3.18-rc4.

What does this patch apply against? I'm struggling to apply it to our
for-next branch (perhaps it conflicts with your other cmpxchg patch?)

Anyway, one comment below.

> +static inline unsigned long __percpu_read(void *ptr, int size)
> +{
> +	unsigned long ret;
> +
> +	switch (size) {
> +	case 1:
> +		asm ("//__per_cpu_read_1\n"
> +			"ldrb %w[ret], %[ptr]\n" :
> +			[ret] "=&r"(ret) : [ptr] "Q"(*(u8 *)ptr));
> +		break;
> +	case 2:
> +		asm ("//__per_cpu_read_2\n"
> +			"ldrh %w[ret], %[ptr]\n" :
> +			[ret] "=&r"(ret) : [ptr] "Q"(*(u16 *)ptr));
> +		break;
> +	case 4:
> +		asm ("//__per_cpu_read_4\n"
> +			"ldr %w[ret], %[ptr]\n" :
> +			[ret] "=&r"(ret) : [ptr] "Q"(*(u32 *)ptr));
> +		break;
> +	case 8:
> +		asm ("//__per_cpu_read_8\n"
> +			"ldr %[ret], %[ptr]\n" :
> +			[ret] "=&r"(ret) : [ptr] "Q"(*(u64 *)ptr));
> +		break;
> +	default:
> +		BUILD_BUG();
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void __percpu_write(void *ptr, unsigned long val, int size)
> +{
> +	switch (size) {
> +	case 1:
> +		asm ("//__per_cpu_write_1\n"
> +			"strb %w[val], %[ptr]\n" :
> +			[ptr] "=Q"(*(u8 *)ptr) : [val] "r"(val));
> +		break;
> +	case 2:
> +		asm ("//__per_cpu_write_2\n"
> +			"strh %w[val], %[ptr]\n" :
> +			[ptr] "=Q"(*(u16 *)ptr) : [val] "r"(val));
> +		break;
> +	case 4:
> +		asm ("//__per_cpu_write_4\n"
> +			"str %w[val], %[ptr]\n" :
> +			[ptr] "=Q"(*(u32 *)ptr) : [val] "r"(val));
> +		break;
> +	case 8:
> +		asm ("//__per_cpu_write_8\n"
> +			"str %[val], %[ptr]\n" :
> +			[ptr] "=Q"(*(u64 *)ptr) : [val] "r"(val));
> +		break;
> +	default:
> +		BUILD_BUG();
> +	}
> +}

Can you implement the read/write accessors with ACCESS_ONCE instead?
I think we're just after a single-copy atomic access without barrier
semantics, so that should work if you get your types right.

Will
