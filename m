From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 09:44:04 +0300
Subject: [PATCH v2 3/4] mtd: mxc_nand: fix truncate of unaligned oob
 copying
In-Reply-To: <20150513063903.GC28888@pengutronix.de>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <ff526c6b889682e36e7d086dd5e6dec8936f86d9.1430636819.git.baruch@tkos.co.il>
 <20150508072432.GJ12671@pengutronix.de>
 <20150513051202.GI2558@tarshish>
 <20150513063903.GC28888@pengutronix.de>
Message-ID: <20150513064404.GM2558@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, May 13, 2015 at 08:39:03AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, May 13, 2015 at 08:12:02AM +0300, Baruch Siach wrote:
> > On Fri, May 08, 2015 at 09:24:32AM +0200, Uwe Kleine-K?nig wrote:
> > > On Sun, May 03, 2015 at 10:18:53AM +0300, Baruch Siach wrote:
> > > > Copy to/from oob io area might not be aligned to 4 bytes. When 8 bit ECC is
> > > > used, the buffer size is 26. Add memcpy16_{to,from}io, and use them to avoid
> > > > truncating the buffer. Prefer memcpy32_{to,from}io when the buffer is properly
> > > > aligned for better performance.
> > > Did you measure this performance difference? I doubt it's worth the
> > > complexity given that we're talking about buffers with a size of up to
> > > 26 bytes.
> > 
> > We'll need both memcpy16_{to,from}io and memcpy32_{to,from}io anyway. So by 
> > "complexity" you refer to the additional alignment check and memcpy32 
> > fallback?
> I thought we could get rid of the memcpy32 variants. Where do we need
> memcpy32_* where memcpy16 wouldn't work?

memcpy16 should work, but would take twice as much IO/memory accesses. That 
would definitely affect performance, as this is the flash data read/write hot 
path. I didn't test, though.

Are you sure we want to do that?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
