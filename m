From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Feb 2013 16:44:20 +0000
Subject: [PATCH] arm: add check for global exclusive monitor
In-Reply-To: <1361204810-5335-1-git-send-email-murzin.v@gmail.com>
References: <1361204810-5335-1-git-send-email-murzin.v@gmail.com>
Message-ID: <20130218164420.GT17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 08:26:50PM +0400, Vladimir Murzin wrote:
> Since ARMv6 new atomic instructions have been introduced:
> ldrex/strex. Several implementation are possible based on (1) global
> and local exclusive monitors and (2) local exclusive monitor and snoop
> unit.
> 
> In case of the 2nd option exclusive store operation on uncached
> region may be faulty.
> 
> Check for availability of the global monitor to provide some hint about
> possible issues.

How does this code actually do that?

> +void __init check_gmonitor_bugs(void)
> +{
> +	struct page *page;
> +	const char *reason;
> +	unsigned long res = 1;
> +
> +	printk(KERN_INFO "CPU: Testing for global monitor: ");
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (page) {
> +		unsigned long *p;
> +		pgprot_t prot = __pgprot_modify(PAGE_KERNEL,
> +					L_PTE_MT_MASK, L_PTE_MT_UNCACHED);
> +
> +		p = vmap(&page, 1, VM_IOREMAP, prot);

This is bad practise.  Remapping a page of already mapped kernel memory
using different attributes (in this case, strongly ordered) is _definitely_
a violation of the architecture requirements.  The behaviour you will see
from this are in no way guaranteed.

If you want to do this, it must either come from highmem, or not already
be mapped.

Moreover, this is absolutely silly - the ARM ARM says:

"LDREX and STREX operations *must* be performed only on memory with the
 Normal memory attribute."

L_PTE_MT_UNCACHED doesn't get you that.  As I say above, that gets you
strongly ordered memory, not "normal memory" as required by the
architecture for use with exclusive types.

> +
> +		if (p) {
> +			int temp;
> +
> +			__asm__ __volatile__(			\
> +				"ldrex   %1, [%2]\n"		\
> +				"strex   %0, %1, [%2]"		\
> +				: "=&r" (res), "=&r" (temp)     \
> +				: "r" (p)			\

\ character not required for any of the above.  Neither is the __ version
of "asm" and "volatile".

> +				: "cc", "memory");
> +
> +				reason = "n\\a (atomic ops may be faulty)";

"n\\a" ?

So... at the moment this has me wondering - you're testing atomic
operations with a strongly ordered memory region, which ARM already
define this to be outside of the architecture spec.  The behaviour you
see is not defined architecturally.

And if you're trying to use LDREX/STREX to a strongly ordered or device
memory region, then you're quite right that it'll be unreliable.  It's
not defined to even work.  That's not because they're faulty, it's because
you're abusing them.
