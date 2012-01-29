From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 29 Jan 2012 10:13:33 -0500 (EST)
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <20120129145503.GE15455@n2100.arm.linux.org.uk>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
 <20120129001136.GB15455@n2100.arm.linux.org.uk>
 <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
 <20120129131411.GC15455@n2100.arm.linux.org.uk>
 <CAGhQ9VwKoVz36EQJ1c2yTTY7NZjsJ9O-nQk-mTWW5nY4pZdMTA@mail.gmail.com>
 <20120129141418.GD15455@n2100.arm.linux.org.uk>
 <CAGhQ9Vwh6TTeQ1qy_Mvou+XKJ4kkZE4dUZk+3CzS2g7TM7kTrQ@mail.gmail.com>
 <20120129145503.GE15455@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201291008180.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Jan 2012, Russell King - ARM Linux wrote:

> On Sun, Jan 29, 2012 at 03:33:35PM +0100, Joachim Eastwood wrote:
> > <1>ioremap: pfn=fffff phys=fffff000 offset=400 size=1000
> > <1>ioremap: area c3ffdfc0: phys_addr=200000 pfn=200 size=4000
> > <1>ioremap: found: addr fef74000 => fed73000 => fed73400
> 
> Ok, first thing is that patch 7304/1 is utter crap.  The reason is simple -
> 'size' here:
> 
>                 if (__phys_to_pfn(area->phys_addr) > pfn ||
>                     __pfn_to_phys(pfn) + offset + size-1 >
>                     area->phys_addr + area->size-1)
>                         continue;
> 
> _already_ contains 'offset', as we've only _just_ done this a few lines
> above the loop:
> 
>         size = PAGE_ALIGN(offset + size);
> 
> So, 'size' includes the requested offset *already*.

Bah, indeed.  OK, I feel better now for not having made this basic 
mistake in the first place, but not any better overall since I didn't 
review Pawel's patch thoroughly enough on the basis that his "fix" made 
things work for him.

> In any case, I don't think it matters, and I'm going to schedule a revert
> of that crap commit.  So, Joachim, well spotted.

For the revert:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
