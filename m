From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 30 Jan 2012 11:10:56 +0000
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
Message-ID: <1327921856.11124.12.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-01-29 at 14:55 +0000, Russell King - ARM Linux wrote:
> So, 'size' includes the requested offset *already*.  So, Nicolas' original:
> 
>              if (__phys_to_pfn(area->phys_addr) > pfn ||
>                  __pfn_to_phys(pfn) + size-1 > area->phys_addr + area->size-1)
>                      continue;
> 
> was correct in the first place.  In any case, let's see what's going on
> here:

Uh. Sincere apologies - I was too happy to see my problem "fixed" and I
rushed things :-/ Lesson learned - I shall not post patches 5 minutes
after creating them and 5 minutes before leaving work.

> Unfortunately, Pawel doesn't say what the problem he was trying to fix was,
> all we have to go on is this totally crap commit comment:

After rebasing my DT4VE patches on top of 3.3-rc1 I seemed not to get
any interrupts from peripherals. Bisect pointed to Nico's patch and
commenting out the loop checking existing mappings made things work, so
did enlarging the static mapping that is created for MPCore peripherals.
Also some data from printk (I'll have to get them back to the code to
see were I made the mistake) made me think that the condition gets a
false positive. Back to debugging then.

> In any case, I don't think it matters, and I'm going to schedule a revert
> of that crap commit.  So, Joachim, well spotted.

I'm really sorry about the hassle.

Pawe?
