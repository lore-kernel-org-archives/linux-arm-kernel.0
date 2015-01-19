From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 17:27:50 +0000
Subject: [PATCH] ARM: kprobes: Eliminate test code's use of BX
 instruction on ARMv4 CPUs
In-Reply-To: <1421687930.4201.21.camel@linaro.org>
References: <1421687930.4201.21.camel@linaro.org>
Message-ID: <20150119172750.GC26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 05:18:50PM +0000, Jon Medhurst (Tixy) wrote:
> diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
> index e72b07e..5c6e37e 100644
> --- a/arch/arm/probes/kprobes/test-arm.c
> +++ b/arch/arm/probes/kprobes/test-arm.c
> @@ -215,9 +215,11 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED("msr	cpsr_f, lr")
>  	TEST_UNSUPPORTED("msr	spsr, r0")
>  
> +#if (__LINUX_ARM_ARCH__ >= 5) || defined(CONFIG_CPU_32v4T)
>  	TEST_BF_R("bx	r",0,2f,"")
>  	TEST_BB_R("bx	r",7,2f,"")
>  	TEST_BF_R("bxeq	r",14,2f,"")
> +#endif

Unnecessary ()... and this isn't correct.  With a multi-platform kernel, we
can end up with CONFIG_CPU_32v4 and CONFIG_CPU_32v4T both set.

I think:

#if __LINUX_ARM_ARCH__ >= 5 || \
    (__LINUX_ARM_ARCH__ == 4 && !defined(CONFIG_CPU_32v4))

would cover it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
