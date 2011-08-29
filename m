From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 11:07:27 +0100
Subject: Thumb symbol lookup. Was [PATCH] ARM: kprobes: Fix jprobe
	registration on Thumb kernels
In-Reply-To: <1314443563-16389-1-git-send-email-tixy@yxit.co.uk>
References: <1314443563-16389-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314612447.2632.75.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-08-27 at 12:12 +0100, Tixy wrote:
> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> When jprobes are registered, the generic kprobes code verifies that the
> address given for the probe's handler corresponds to a symbol in the
> kernel. For thumb kernels, this address has bit zero set to indicate its
> thumb-ness and so is rejected as being offset by one byte from the
> symbol address.
> 
> Fortunately, on some architectures, the jprobes handler is specified
> using a struct rather than a plain function pointer; so a mechanism is
> provided for arch code to define a translation function called
> arch_deref_entry_point(). We can use this on Thumb kernels to remove bit
> zero of the handler address and fix our problem.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> ---
>  arch/arm/kernel/kprobes.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> index 129c116..9c88bcd 100644
> --- a/arch/arm/kernel/kprobes.c
> +++ b/arch/arm/kernel/kprobes.c
> @@ -497,6 +497,14 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;
>  }
>  
> +#ifdef CONFIG_THUMB2_KERNEL
> +unsigned long arch_deref_entry_point(void *entry)
> +{
> +	/* Remove any thumb flag from the function pointer. */
> +	return (unsigned long)entry & ~1lu;
> +}
> +#endif
> +
>  int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct jprobe *jp = container_of(p, struct jprobe, kp);

I just discovered that this fix only works when the handler is builtin,
if it is in a module then the symbol lookup for (fn_ptr&~1) gives the
result that the address is in the previous function.

This occurs because for built-in symbols, get_symbol_pos() is used and
this sees thumb functions as starting at an even address. For symbols in
modules, get_ksymbol() is used and this sees thumb functions starting at
odd addresses.

This begs the question, what is the correct behaviour when looking up an
address in a Thumb function? Using this example

void __naked foo()
{
	__asm__ __volatile__ (
		"nop.n"
		"bx lr"
	);
}

if the first nop is at address 0x100 then &foo would be 0x101.

If we treat the function as starting at 0x100, then looking up &foo will
return a answer saying the address starts one byte from the start of
foo.

If we treat the function as starting at 0x101, then looking up address
of the nop (0x100) will return a result indicating that the address
isn't in foo.

Neither of these seem to be right, though the former may be more
'right'. Perhaps the best solution is to just ignore bit zero in both
symbol addresses and in addresses passed into APIs. That way, in our
example looking up both &foo and 0x100 will say the address is zero
bytes from the start of symbol foo, and that the "bx lr" is 2 bytes.
 
If this solution is desirable, I'm not sure how we'd go about
implementing it, as all the symbol lookup seems to be in generic kernel
code.

-- 
Tixy
