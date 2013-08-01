From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 1 Aug 2013 09:33:12 +0800
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731141512.GU2810@htj.dyndns.org>
References: <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <CAL411-qQm9vgDHswEM6PEvFKAaqd=e3qm-zViUbNztv0tJYa8Q@mail.gmail.com>
 <20130731141512.GU2810@htj.dyndns.org>
Message-ID: <20130801013311.GH8540@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 10:15:12AM -0400, Tejun Heo wrote:
> hello,
> 
> On Wed, Jul 31, 2013 at 09:55:26PM +0800, Peter Chen wrote:
> > I think the main point is we should allocate managed resource which is used
> > at interrupt handler before devm_request_irq, and all resources used
> > at interrupt
> > handler should be managed.
> > 
> > If we use non-managed resource at interrupt handler, but using managed interrupt
> > handler, things still will go wrong if there is an odd (unexpected)
> > interrupt after
> > we finish deactivation at removal.
> 
> In general, applying devm partially isn't a good idea.  It's very easy
> to get into trouble thanks to release order dependency which isn't
> immediately noticeable and there have been actual bugs caused by that.
> The strategies which seem to work are either
> 
> * Convert everything over to devm by wrapping deactivation in a devres
>   callback too.  As long as your init sequence is sane (ie. irq
>   shouldn't be request before things used by irq are ready).
> 
> * Allocate all resources using devres but shut down the execution
>   engine in the remove_one().  Again, as all releases are controlled
>   by devres, you won't have to worry about messing up the release
>   sequencing.
> 

thanks, Tejun. So, Alex and Fabio, this patch may not be suitable currently,
since many resources at both EHCI and device side are non-managed.
-- 

Best Regards,
Peter Chen
