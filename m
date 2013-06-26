From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 26 Jun 2013 21:23:53 +0200
Subject: [PATCH 0/2] arm: add early_ioremap() support
In-Reply-To: <201306262052.09640.arnd@arndb.de>
References: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
 <201306262052.09640.arnd@arndb.de>
Message-ID: <20130626192352.GE9078@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 08:52:09PM +0200, Arnd Bergmann wrote:
> I made a similar suggestion to extending the use of fixmap recently, see
> "Re: SCU registers mapping for CA9/CA5 cores". Russell pointed out that
> fixmap is intentionally limited to just kmap_atomic uses at the moment
> and changing that would potentially have a significant impact when we
> run out of pages in the fixmap area.
 
Is this an issue here, since (unlike x86) this early_ioremap only works
before paging_init()?

> The method we use on ARM normally is the iotable_init() function, which
> requires hardcoding a virtual address at the moment.
> 
> It might be nicer to change that code than to put early_ioremap into
> fixmap. Note that early_ioremap in fixmap is a bit of a kludge on x86
> as well because it is very much /not/ a fixed mapping like the rest
> of fixmap, they just use it because it's convenient.
 
Yes, but they also only use it (at least the bits where I looked) for
temporary mappings very early in the boot process. That is certainly
how I use it. So at least my intention was to use it before kmap is
even available.

> Extending the iotable mechanism on ARM would be the convenient
> solution for us I think.

Could that easily be extended to give similar semantics sufficiently
that we can progress with merging more of the UEFI and ACPI support 
together as common code with x86/ia64?

/
    Leif
