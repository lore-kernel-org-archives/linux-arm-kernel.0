From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Apr 2014 20:28:24 +0100
Subject: [PATCH 00/75] l2c series
In-Reply-To: <533E5B71.20406@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <533D7672.4090003@monstr.eu> <20140403193328.GY7528@n2100.arm.linux.org.uk>
 <533E5B71.20406@monstr.eu>
Message-ID: <20140404192824.GG7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 09:12:49AM +0200, Michal Simek wrote:
> On 04/03/2014 09:33 PM, Russell King - ARM Linux wrote:
> > On Thu, Apr 03, 2014 at 04:55:46PM +0200, Michal Simek wrote:
> >> Hi Russell,
> >>
> >> On 03/28/2014 04:12 PM, Russell King - ARM Linux wrote:
> >>> This is another posting of the L2 cache controller series.  I'm not
> >>> planning for this for the upcoming merge window, but the one after,
> >>> as people need to test it and still need to feed back to me on
> >>> various issues.  Hence, this is not a finalised series.
> >>>
> >>> There are still various issues which I've raised, and have had no
> >>> feedback on.
> >>>
> >>> This series is being posted with Cc's on the individual patches.
> >>
> >> I just want to also point you that we have sent EDAC support for pl310
> >> which will be good to have it for L2.
> >> [RFC PATCH] EDAC support for ARM PL310 cache controller
> >> [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
> >> http://lkml.org/lkml/2014/3/2/85
> >> http://lkml.org/lkml/2014/3/2/87
> > 
> > As seems to be the norm, lkml.org is broken... please find a different
> > archive instead. :)
> > 
> 
> Here it is:
> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00250.html
> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00251.html

A number of comments immediately spring to mind:

- the use of writel/readl rather than their ARM specific _relaxed
  versions is not a good idea: using the standard macros will result
  in another write due to the barrier.

- a driver coupled to the arm,pl310-cache compatible for this which is
  distinctly separate from the main "driver" is probably a bad idea.
  what if we want our existing l2 stuff to couple into the driver model
  to expose some properties at a later date (eg, maybe to deal with
  stuff like the power management settings?)  For example, it may be
  that we want to expose the prefetch offset so that people can easily
  play with the value to determine the correct tuning for their workload.

- casting to void * is unnecessary for devm_request_irq()

- you really ought to check whether the interrupt registers are accessible
  in non-secure mode - and I guess if we're going to have this driver, we
  should have the L2 cache enabling code always try to set the NS access
  bit for the interrupt registers.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
