From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 22:20:55 +0100
Subject: [PATCH 46/52] ARM: mach-u300: convert boot_params to atag_offset
In-Reply-To: <CAKnu2MrM-_sw70se==z8LO-ZO0eUbwqk9MhY3Co1ZErV=hOYUw@mail.gmail.com>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<1309920457-21913-46-git-send-email-nicolas.pitre@linaro.org>
	<CAKnu2MrM-_sw70se==z8LO-ZO0eUbwqk9MhY3Co1ZErV=hOYUw@mail.gmail.com>
Message-ID: <20110708212055.GZ4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:12:06PM +0200, Linus Walleij wrote:
> 2011/7/6 Nicolas Pitre <nicolas.pitre@linaro.org>:
> 
> > Someone was smoking good stuff with CONFIG_MACH_U300_2MB_ALIGNMENT_FIX here...
> 
> Haha, it is a consequence of the PHYS_OFFSET having to align on a 2MB
> boundary, whereas the actual physical memory was at an odd MB address.
> We didn't really like the idea of loosing one megabyte of memory just to
> please PHYSOFFSET, so hence this fix.
> 
> What we do is round memory upwards to closest 2MB boundary, then we
> reserve the first MB. That's why we're having so much fun...
> 
> The reason why memory can be at an odd address is that we can
> dynamically alter (at boot time) how many MB are reserved for the
> accompanying modem CPU.

Can it be killed now that we have memblock with a proper reserve callback?
You could locate the kernel higher in memory (eg, 4MB+32K or even 1MB+32K)
keeping the real PHYS_OFFSET/PAGE_OFFSET, and arrange for the ->reserve
callback to mark the first 1MB as reserved, optionally freeing it from
memblock's idea of available memory if you don't want it mapped.
