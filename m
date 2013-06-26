From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 20:52:09 +0200
Subject: [PATCH 0/2] arm: add early_ioremap() support
In-Reply-To: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
References: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <201306262052.09640.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013, Leif Lindholm wrote:
> x86 and ia64 have the early_ioremap()/early_iounmap() functions, which are
> useful for supporting things like UEFI, ACPI and SMBIOS, where configuration
> tables need to be parsed before proper memory management is available,
> regardless of highmem status.
> 
> This patchset implements a restricted form of early_ioremap(), available
> before paging_init() only. Like the x86 code on which it is based, it
> (p)re-uses the fixmap regions for its virtual mapping range. Up to 7
> simultaneous mappings of up to 128KB can be accommodated in the available
> fixmap space.

+rmk

I made a similar suggestion to extending the use of fixmap recently, see
"Re: SCU registers mapping for CA9/CA5 cores". Russell pointed out that
fixmap is intentionally limited to just kmap_atomic uses at the moment
and changing that would potentially have a significant impact when we
run out of pages in the fixmap area.

The method we use on ARM normally is the iotable_init() function, which
requires hardcoding a virtual address at the moment.

It might be nicer to change that code than to put early_ioremap into
fixmap. Note that early_ioremap in fixmap is a bit of a kludge on x86
as well because it is very much /not/ a fixed mapping like the rest
of fixmap, they just use it because it's convenient.

Extending the iotable mechanism on ARM would be the convenient
solution for us I think.

	Arnd
