From: edward.nevill@linaro.org (Edward Nevill)
Date: Thu, 08 Oct 2015 15:54:00 +0100
Subject: [PATCH v2 14/22] arm64: Cleanup HWCAP handling
In-Reply-To: <20151008130026.GI17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-15-git-send-email-suzuki.poulose@arm.com>
 <20151008111000.GG17192@e104818-lin.cambridge.arm.com>
 <20151008111709.GE32532@n2100.arm.linux.org.uk>
 <20151008130026.GI17192@e104818-lin.cambridge.arm.com>
Message-ID: <1444316040.15616.21.camel@mylittlepony.linaroharston>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-08 at 14:00 +0100, Catalin Marinas wrote:
> On Thu, Oct 08, 2015 at 12:17:09PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 08, 2015 at 12:10:00PM +0100, Catalin Marinas wrote:
> > > On Mon, Oct 05, 2015 at 06:02:03PM +0100, Suzuki K. Poulose wrote:
> > > > +static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
> > > > +{
> > > > +	switch(cap->hwcap_type) {
> > > > +	case CAP_HWCAP:
> > > > +		return !!(elf_hwcap & cap->hwcap);
> > > > +#ifdef CONFIG_COMPAT
> > > > +	case CAP_COMPAT_HWCAP:
> > > > +		return !!(compat_elf_hwcap & (u32)cap->hwcap);
> > > > +	case CAP_COMPAT_HWCAP2:
> > > > +		return !!(compat_elf_hwcap2 & (u32)cap->hwcap);
> > > > +#endif
> > > > +	default:
> > > > +		BUG();
> > > > +		return false;
> > > > +	}
> > > > +}
> > > 
> > > Apart from the multiple returns, you don't really need !! since the
> > > return type is bool already.
> > 
> > That's wrong.  a & b doesn't return 0 or 1, but the bitwise-and result.
> 
> a & b is indeed a bitwise operation and, in this particular case, its
> type is an unsigned long. However, because the return type of the
> function is a bool, the result of the bitwise operation (unsigned long)
> is converted to a bool.

Why not just write what you mean

  return (elf_hwcap & cap->hwcap) != 0;

So much clearer. And every compiler will compile it correctly and
optimally. The !!() syntax is just so ugly it is untrue. Its like people
who write

  if (strcmp(..., ...)) ...

Break their fingers!
Ed.
