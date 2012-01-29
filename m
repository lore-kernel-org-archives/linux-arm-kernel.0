From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jan 2012 14:55:03 +0000
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <CAGhQ9Vwh6TTeQ1qy_Mvou+XKJ4kkZE4dUZk+3CzS2g7TM7kTrQ@mail.gmail.com>
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
Message-ID: <20120129145503.GE15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 03:33:35PM +0100, Joachim Eastwood wrote:
> <1>ioremap: pfn=fffff phys=fffff000 offset=400 size=1000
> <1>ioremap: area c3ffdfc0: phys_addr=200000 pfn=200 size=4000
> <1>ioremap: found: addr fef74000 => fed73000 => fed73400

Ok, first thing is that patch 7304/1 is utter crap.  The reason is simple -
'size' here:

                if (__phys_to_pfn(area->phys_addr) > pfn ||
                    __pfn_to_phys(pfn) + offset + size-1 >
                    area->phys_addr + area->size-1)
                        continue;

_already_ contains 'offset', as we've only _just_ done this a few lines
above the loop:

        size = PAGE_ALIGN(offset + size);

So, 'size' includes the requested offset *already*.  So, Nicolas' original:

             if (__phys_to_pfn(area->phys_addr) > pfn ||
                 __pfn_to_phys(pfn) + size-1 > area->phys_addr + area->size-1)
                     continue;

was correct in the first place.  In any case, let's see what's going on
here:

                if (__phys_to_pfn(area->phys_addr) > pfn ||
                    __pfn_to_phys(pfn) + offset + size-1 >
                    area->phys_addr + area->size-1)
                        continue;

we have:

area->phys_addr = 0x00200000, __phys_to_pfn(area->phys_addr) = 0x00200
area->size = 0x4000, pfn = 0xfffff, offset = 0x400, size = 0x1000

So, this if condition becomes:

		if (0x00200 > 0xfffff ||
		    0xfffff000 + 0x400 + 0x1000-1 > 0x00200000 + 0x4000-1)
and therefore:
		if (0x00200 > 0xfffff ||
		    0x000003ff > 0x00203fff)

So, the if condition fails, and so we _believe_ that the SRAM mapping fits
our request.  Clearly that's totally bogus and crap.

Unfortunately, Pawel doesn't say what the problem he was trying to fix was,
all we have to go on is this totally crap commit comment:

    The condition checking boundaries of the requested and existing
    mappings didn't take in-page offset into consideration though,
    which lead to obscure and hard to debug problems when requested
    mapping crossed end of the static one.

In any case, I don't think it matters, and I'm going to schedule a revert
of that crap commit.  So, Joachim, well spotted.
