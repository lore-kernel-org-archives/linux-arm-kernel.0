From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 14:00:26 +0100
Subject: [PATCH v2 14/22] arm64: Cleanup HWCAP handling
In-Reply-To: <20151008111709.GE32532@n2100.arm.linux.org.uk>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-15-git-send-email-suzuki.poulose@arm.com>
 <20151008111000.GG17192@e104818-lin.cambridge.arm.com>
 <20151008111709.GE32532@n2100.arm.linux.org.uk>
Message-ID: <20151008130026.GI17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 12:17:09PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 08, 2015 at 12:10:00PM +0100, Catalin Marinas wrote:
> > On Mon, Oct 05, 2015 at 06:02:03PM +0100, Suzuki K. Poulose wrote:
> > > +static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
> > > +{
> > > +	switch(cap->hwcap_type) {
> > > +	case CAP_HWCAP:
> > > +		return !!(elf_hwcap & cap->hwcap);
> > > +#ifdef CONFIG_COMPAT
> > > +	case CAP_COMPAT_HWCAP:
> > > +		return !!(compat_elf_hwcap & (u32)cap->hwcap);
> > > +	case CAP_COMPAT_HWCAP2:
> > > +		return !!(compat_elf_hwcap2 & (u32)cap->hwcap);
> > > +#endif
> > > +	default:
> > > +		BUG();
> > > +		return false;
> > > +	}
> > > +}
> > 
> > Apart from the multiple returns, you don't really need !! since the
> > return type is bool already.
> 
> That's wrong.  a & b doesn't return 0 or 1, but the bitwise-and result.

a & b is indeed a bitwise operation and, in this particular case, its
type is an unsigned long. However, because the return type of the
function is a bool, the result of the bitwise operation (unsigned long)
is converted to a bool.

The above may be true only for gcc, I haven't checked other compilers,
nor the standard (AFAIK, it appeared in C99).

On AArch64, the compiler generates something like:

	tst	x0, x1
	cset	w0, ne
	ret

On AArch32, Thumb-2, I get:

	tst	r2, r3
	ite	ne
	movne	r0, #1
	moveq	r0, #0
	bx	lr

So a bool type function always returns 0 or 1 and does the appropriate
conversion.

> http://yarchive.net/comp/linux/bool.html
> 
> especially hpa's response.

This seems to be more about a union of int and bool rather than
automatic type conversion. But I can see in the simple test that Linus
did towards the end of the thread that x86 does something similar with
converting a char to a bool:

	testb	%al, %al
	setne	%al
	ret

I stand by my original comment.

-- 
Catalin
