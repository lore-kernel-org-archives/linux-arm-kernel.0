From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 12:10:25 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
In-Reply-To: <20170316135359.23019-1-tixy@linaro.org>
References: <20170316135359.23019-1-tixy@linaro.org>
Message-ID: <20170317121025.GD21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 01:53:59PM +0000, Jon Medhurst wrote:
> Without this fix, some test cases will generate alignment faults on
> systems where alignment is enforced. Even if the kernel is configured to
> handle these faults in software, triggering them is ugly. It also
> exposes limitations in the fault handling code which doesn't cope with
> writes to the stack. E.g. when handling this instruction
> 
>    strd r6, [sp, #-64]!
> 
> the fault handling code will write to a stack location below the SP
> value at the point the fault occurred, which coincides with where the
> exception handler has pushed the saved register context. This results in
> corruption of those registers.

The general rule today is that the stack must always be 64-bit aligned,
so an even number of registers must always be pushed to the stack.

> diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
> index c893726aa52d..1c98a87786ca 100644
> --- a/arch/arm/probes/kprobes/test-core.c
> +++ b/arch/arm/probes/kprobes/test-core.c
> @@ -977,7 +977,10 @@ static void coverage_end(void)
>  void __naked __kprobes_test_case_start(void)
>  {
>  	__asm__ __volatile__ (
> -		"stmdb	sp!, {r4-r11}				\n\t"
> +		"mov	r2, sp					\n\t"
> +		"bic	r3, r2, #7				\n\t"
> +		"mov	sp, r3					\n\t"
> +		"stmdb	sp!, {r2-r11}				\n\t"

I'm not sure these is where the problem is - on entry, the stack
should be 64-bit aligned.  You're pushing an even number of registers
onto the stack, so it should remain 64-bit aligned.

>  		"sub	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"

This looks to be 256 bytes, so that should be fine.

I think the real question is... how is the stack becoming misaligned?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
