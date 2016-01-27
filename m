From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 27 Jan 2016 09:50:27 +0000
Subject: Problem with component helpers and probe deferral in 4.5-rc1
In-Reply-To: <1453886324.2847.12.camel@linaro.org>
References: <1453831153.2850.107.camel@linaro.org>
 <20160126223551.GU10826@n2100.arm.linux.org.uk>
 <1453886324.2847.12.camel@linaro.org>
Message-ID: <1453888227.2847.19.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-27 at 09:18 +0000, Jon Medhurst (Tixy) wrote:
> On Tue, 2016-01-26 at 22:35 +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 26, 2016 at 05:59:13PM +0000, Jon Medhurst (Tixy) wrote:
> > > I believe I've found a problem with the component helpers and/or how
> > > drivers use them. I discovered this whilst trying to get ARM's HDLCD
> > > driver [1] working on 4.5-rc1, however I believe that code is following
> > > a pattern used by drivers already in 4.5 and the problem isn't specific
> > > to it. This is what I have observed...
> > 
> > Hmm, it all looks plausible, and I'm again left wondering how the code
> > passed testing over the last year (I've been running this code for
> > ages both on iMX6 and Dove, where deferred probing does happen.)
> 
> It depends on the order of things. To go wrong, components must already
> be there before the master is added, then the master needs to defer
> probing from it's bind callback. So, components deferring won't trigger
> the issue,

Actually, looks like drm drivers for armada and imx will end up calling
component_bind_all from their bind callpath, so if components return
-EPROBE_DEFER from their bind function, then the master will bail out
with that, triggering my failure scenario. Hmmm...

-- 
Tixy
