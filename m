From: mgorman@techsingularity.net (Mel Gorman)
Date: Fri, 3 Jun 2016 13:36:55 +0100
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <CAPv3WKfrgNg00M4oE3VKLYimYqN6NO6ziR7LWYXQ1d_M-bo67A@mail.gmail.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
 <20160531131520.GI24936@arm.com>
 <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
 <20160602135226.GX2527@techsingularity.net>
 <CAPv3WKd8Zdcv5nhr2euN7L4W5JYLex_Hmn+9AVd6reyD-Vw4kg@mail.gmail.com>
 <20160603095344.GZ2527@techsingularity.net>
 <CAPv3WKfrgNg00M4oE3VKLYimYqN6NO6ziR7LWYXQ1d_M-bo67A@mail.gmail.com>
Message-ID: <20160603123655.GA2527@techsingularity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 01:57:06PM +0200, Marcin Wojtas wrote:
> >> For the record: the newest kernel I was able to reproduce the dumps
> >> was v4.6: http://pastebin.com/ekDdACn5. I've just checked v4.7-rc1,
> >> which comprise a lot (mainly yours) changes in mm, and I'm wondering
> >> if there may be a spot fix or rather a series of improvements. I'm
> >> looking forward to your opinion and would be grateful for any advice.
> >>
> >
> > I don't believe we want to reintroduce the reserve to cope with CMA. One
> > option would be to widen the gap between low and min watermark by the
> > size of the CMA region. The effect would be to wake kswapd earlier which
> > matters considering the context of the failing allocation was
> > GFP_ATOMIC.
> 
> Of course my intention is not reintroducing anything that's gone
> forever, but just to find out way to overcome current issues. Do you
> mean increasing CMA size?

No. There is a gap between the low and min watermarks. At the low point,
kswapd is woken up and at the min point allocation requests either
either direct reclaim or fail if they are atomic. What I'm suggesting
is that you adjust the low watermark and add the size of the CMA area
to it so that kswapd is woken earlier. The watermarks are calculated in
__setup_per_zone_wmarks

-- 
Mel Gorman
SUSE Labs
