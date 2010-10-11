From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 11 Oct 2010 14:16:54 +0300
Subject: [PATCH 3/3] staging: tidspbridge: remove memory consistency from
	TODO list
In-Reply-To: <201010111240.25759.arnd@arndb.de>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
	<201010111240.25759.arnd@arndb.de>
Message-ID: <AANLkTikq80dM_93k2byPXDexzz3J+g3Wiva3ieBbXmmf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 10 October 2010, Felipe Contreras wrote:
>> The mempool area is not handled by the kernel any more.
>
> But tidspbridge still uses ioremap to set up the mapping for RAM,
> even though it now is outside of the kernel linar mapping.

Which is what ioremap() complained about, and how Russell King
suggested to solve the issue.

> You should really only use ioremap on MMIO registers, nothing
> else. These registers are marked as __iomem pointers and can only
> be passed into functions that talk to the hardware like iowrite32
> or writel, but not used like memory.


>From bogus@does.not.exist.com  Sat Oct  9 07:11:57 2010
From: bogus@does.not.exist.com ()
Date: Sat, 09 Oct 2010 11:11:57 -0000
Subject: No subject
Message-ID: <mailman.1.1286795819.18522.linux-arm-kernel@lists.infradead.org>

> Please have a look at "sparse", which will warn about address space
> violations among other things. The tidspbridge driver is full of them,
> and you should fix the code that sparse warns about, which will
> also show you all the places where ioremap is used incorrectly.

In one of my branches I moved ioremap() to arch/arm/mach-omap2/dsp.c
and if I use sparse there, it gives no warning.

I would prefer to map the memory some other way and make it
non-cacheable, but I don't know any other way. Then, if readl/writel
are still needed, only ioremap() that area. And finally, and
hopefully, do cache flushes instead of requiring consistent memory.

Cheers.

-- 
Felipe Contreras
