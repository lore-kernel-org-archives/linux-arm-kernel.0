From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 15:55:27 +0100
Subject: [PATCH] driver-core: platform: Resolve DT interrupt references
 late
In-Reply-To: <4589157.TquA4Q59fC@wuerfel>
References: <20140108011957.GK5074@atomide.com>
 <1389185477-507-1-git-send-email-treding@nvidia.com>
 <4589157.TquA4Q59fC@wuerfel>
Message-ID: <20140108145525.GB21974@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 02:41:19PM +0100, Arnd Bergmann wrote:
> On Wednesday 08 January 2014 13:51:17 Thierry Reding wrote:
> > When devices are probed from the device tree, any interrupts that they
> > reference are resolved at device creation time. This causes problems if
> > the interrupt provider hasn't been registered yet at that time, which
> > results in the interrupt being set to 0.
> 
> Thanks for looking at this problem, it has bothered a lot of people
> for a long time. I'm sorry I wasn't there for the discussion in November,
> but when it came up before, I suggested a different solution that
> apparently didn't get implemented.
> 
> > Note that this patch is the easy way out to fix a large part of the
> > problems for now. A more proper solution for the long term would be to
> > transition drivers to an API that always resolves resources of any kind
> > (not only interrupts) at probe time.
> > 
> > For some background and discussion on possible solutions, see:
> > 
> > 	https://lkml.org/lkml/2013/11/22/520
> 
> I hope I read this thread correctly, sorry if I missed an important
> part. My idea was to add the code not in platform_get_irq() but add
> the resource in platform_drv_probe(), and just bail out with
> -EPROBE_DEFER there if necessary.

One of the reasons we can't do that just yet is that we don't actually
get back an accurate error code from the OF IRQ helpers. Therefore if we
want to support deferred probing we either have to return -EPROBE_DEFER
for all errors (which is a bad idea because some errors just can't be
resolved by deferral) or we change the OF IRQ functions to propagate the
error code properly so that we know exactly when -EPROBE_DEFER makes
sense (i.e. the IRQ domain for an interrupt-parent hasn't been
registered yet).

Actually I posted a round of patches quite a while back that did exactly
this for interrupts. The changes were somewhat involved because it means
propagating an error code from fairly deep down in the OF code back to
the various higher-level helpers. If you're interested, the last version
of that is here:

	https://lkml.org/lkml/2013/9/18/216

Grant in particular seemed to be uncomfortable about how invasive the
patch series is.

Perhaps I should step back for a minute and provide some background on
how the initial idea came about. This was first triggered by the IOMMU
probe ordering issue that you may have heard about. One of the reasons
to do this for interrupts was because they are an existing type of
resource yet suffer from a very similar problem, so I wanted to solve
the issue for interrupts and thereby get a better overview of what
needed to be done for IOMMUs.

The most logical place for this code to reside seemed to be in the probe
path of platform devices (or I2C and other devices for that matter). The
patch series introduced an of_platform_probe() function that's called
from platform_drv_probe(). This would automatically give us deferred
probe support provided that we could propagate the appropriate error
code while at the same time giving us some flexibility to hook up other
resource types (such as IOMMUs).

One problem with the IOMMU patches is that they've received some strong
pushback from both Greg and Grant, arguing that it doesn't belong in the
core. If you want to read up on that, here's a link to the latest
version:

	https://lkml.org/lkml/2013/12/12/74

Some things had been discussed in earlier iterations of that series, but
this should give you the basic idea.

It stands to reason that if they push back on the IOMMU variant of what
is essentially the same thing, they will push back on the IRQ variant as
well. One alternative I proposed was to, just as you suggested earlier,
move the code into platform_drv_probe() or rather a function called from
it. That proposal never got any replies, though.

	https://lkml.org/lkml/2013/12/14/39

> We could then skip adding the resources at device creation time.
> Is this something you already plan to do later, or is there a reason
> it wouldn't work?

The current thread here suggests that it would be preferable not to have
any static allocations at all, but rather introduce a new API to resolve
things at probe time if necessary. I think the idea was to have a set of
functions like:

	int device_get_irq(struct device *dev, unsigned int num);
	struct resource *device_get_mem_region(struct device *dev,
					       unsigned int num);

Or even possible the more generic:

	struct resource *device_get_resource(struct device *dev,
					     unsigned int type,
					     unsigned int num);

If every driver used these functions, all resources could trivially be
resolved at probe time. That solution is also the most invasive one of
course, because it requires all existing drivers to be converted. At
least the API would be all new and therefore the conversion could happen
piecemeal.

One downside of that approach is that, while it maps well to platform
devices or generic devices that have some sort of firmware interface
such as OF or ACPI, I don't see how it can be made to work with an I2C
client that's registered from board setup code for example. Well, I
suppose that problem could be solved by throwing another lookup table at
it, just like we do for clocks, regulators, PWMs and GPIOs.

The good thing about it would be more consistency between the various
types of resources. Eventually I could imagine that we could even get
rid of struct resource (or at least only use it for a single type of
resource). But as I said, it'll take quite a bit of work to convert
everything to that.

> In the meantime, I don't see anything with your patch, but it also
> wouldn't hurt to do it now if it solves all the problems.

Well, the commit message explicitly states that this is only a temporary
measure, mostly to fix a number of regressions on OMAP where things were
broken by the conversion to DT in 3.13. The same is probably true of
other boards as well.

I'm willing to help fix things properly in the long run, but I think a
simple and low-risk patch like this would be worthwhile if it means that
a good many boards aren't broken in 3.13. Also given the history of the
above I can imagine that it will take more than the 3.14 cycle to get
this resolved satisfactorily, so at least for interrupts this would give
us a good stopgap solution in the meantime.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/d3199ff3/attachment.sig>
