From: yehuday@marvell.com (Yehuda Yitschak)
Date: Tue, 31 May 2016 13:10:44 +0000
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
Message-ID: <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin 

During some of the stress tests we also came across a different warning from the arm64  page management code
It looks like a race is detected between HW and SW marking a bit in the PTE

Not sure it's really related but I thought it might give a clue on the issue
http://pastebin.com/ASv19vZP

Thanks

Yehuda 


> -----Original Message-----
> From: Marcin Wojtas [mailto:mw at semihalf.com]
> Sent: Tuesday, May 31, 2016 13:30
> To: Robin Murphy
> Cc: linux-mm at kvack.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Lior Amsalem; Thomas Petazzoni; Yehuda
> Yitschak; Catalin Marinas; Arnd Bergmann; Grzegorz Jaszczyk; Will Deacon;
> Nadav Haklai; Tomasz Nowicki; Gregory Cl?ment
> Subject: Re: [BUG] Page allocation failures with newest kernels
> 
> Hi Robin,
> 
> >
> > I remember there were some issues around 4.2 with the revision of the
> > arm64 atomic implementations affecting the cmpxchg_double() in SLUB,
> > but those should all be fixed (and the symptoms tended to be
> considerably more fatal).
> > A stronger candidate would be 97303480753e (which landed in 4.4),
> > which has various knock-on effects on the layout of SLUB internals -
> > does fiddling with L1_CACHE_SHIFT make any difference?
> >
> 
> I'll check the commits, thanks. I forgot to add L1_CACHE_SHIFT was my first
> suspect - I had spent a long time debugging network controller, which
> stopped working because of this change - L1_CACHE_BYTES (and hence
> NET_SKB_PAD) not fitting HW constraints. Anyway reverting it didn't help at
> all for page alloc issue.
> 
> Best regards,
> Marcin
