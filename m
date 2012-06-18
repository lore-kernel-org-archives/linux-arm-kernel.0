From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jun 2012 14:10:39 +0000
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
 <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
Message-ID: <201206181410.39267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 June 2012, Kyungmin Park wrote:
> > I would prefer to see this handled by using the smp_ops patchset that
> > Marc Zyngier has been posting instead, replacing the boot_secondary
> > function pointer during early boot depending on whether trustzone is
> > enabled or not.
> I understand your request, but it's not only boot_secondary but also
> exynos pm common code and so on.even more it's used at devfreq to
> adjust the RAM bus timings.
> 
> Now these files are covered.
> 

Would it help to have a trustzone_ops structure with pointers to
functions if needed, similar to but separate from smp_ops?

Instead of checking for trustzone_enabled() in each place where
we call into smc, we can have a generic implementation that
we call for the disabled case, and provide a vendor specific
version of that struct with functions that call into smp 
where necessary.

	Arnd
