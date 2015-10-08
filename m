From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 12:17:09 +0100
Subject: [PATCH v2 14/22] arm64: Cleanup HWCAP handling
In-Reply-To: <20151008111000.GG17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-15-git-send-email-suzuki.poulose@arm.com>
 <20151008111000.GG17192@e104818-lin.cambridge.arm.com>
Message-ID: <20151008111709.GE32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 12:10:00PM +0100, Catalin Marinas wrote:
> On Mon, Oct 05, 2015 at 06:02:03PM +0100, Suzuki K. Poulose wrote:
> > +static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
> > +{
> > +	switch(cap->hwcap_type) {
> > +	case CAP_HWCAP:
> > +		return !!(elf_hwcap & cap->hwcap);
> > +#ifdef CONFIG_COMPAT
> > +	case CAP_COMPAT_HWCAP:
> > +		return !!(compat_elf_hwcap & (u32)cap->hwcap);
> > +	case CAP_COMPAT_HWCAP2:
> > +		return !!(compat_elf_hwcap2 & (u32)cap->hwcap);
> > +#endif
> > +	default:
> > +		BUG();
> > +		return false;
> > +	}
> > +}
> 
> Apart from the multiple returns, you don't really need !! since the
> return type is bool already.

That's wrong.  a & b doesn't return 0 or 1, but the bitwise-and result.

http://yarchive.net/comp/linux/bool.html

especially hpa's response.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
