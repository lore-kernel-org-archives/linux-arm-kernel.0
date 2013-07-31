From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 10:15:12 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <CAL411-qQm9vgDHswEM6PEvFKAaqd=e3qm-zViUbNztv0tJYa8Q@mail.gmail.com>
References: <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <CAL411-qQm9vgDHswEM6PEvFKAaqd=e3qm-zViUbNztv0tJYa8Q@mail.gmail.com>
Message-ID: <20130731141512.GU2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello,

On Wed, Jul 31, 2013 at 09:55:26PM +0800, Peter Chen wrote:
> I think the main point is we should allocate managed resource which is used
> at interrupt handler before devm_request_irq, and all resources used
> at interrupt
> handler should be managed.
> 
> If we use non-managed resource at interrupt handler, but using managed interrupt
> handler, things still will go wrong if there is an odd (unexpected)
> interrupt after
> we finish deactivation at removal.

In general, applying devm partially isn't a good idea.  It's very easy
to get into trouble thanks to release order dependency which isn't
immediately noticeable and there have been actual bugs caused by that.
The strategies which seem to work are either

* Convert everything over to devm by wrapping deactivation in a devres
  callback too.  As long as your init sequence is sane (ie. irq
  shouldn't be request before things used by irq are ready).

* Allocate all resources using devres but shut down the execution
  engine in the remove_one().  Again, as all releases are controlled
  by devres, you won't have to worry about messing up the release
  sequencing.

Thanks.

-- 
tejun
