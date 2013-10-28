From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Oct 2013 21:44:25 +0100
Subject: [PATCH v6 0/5] clk: clock deregistration support
In-Reply-To: <52434CBC.2070408@gmail.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <3160771.O1gFkR91vK@avalon> <52434CBC.2070408@gmail.com>
Message-ID: <13300609.Rh0Q97QhcX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Wednesday 25 September 2013 22:51:08 Sylwester Nawrocki wrote:
> On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> > Doesn't that introduce race conditions ? If the sub-drivers require the
> > clock, they want to be sure that the clock won't disappear beyond their
> > backs. I agree that the circular dependency needs to be solved somehow,
> > but we probably need a more generic solution. The problem will become
> > more widespread in the future with DT-based device instantiation in both
> > V4L2 and KMS.
> 
> It doesn't introduce any new race conditions AFAICT. I doubt all these
> issues can be resolved in one single step. Currently the modular clock
> providers are seriously broken, there is no reference tracking and the clock
> consumers can easily get into a state where they have invalid references to
> clocks supplied by already unregistered drivers.
> 
> With this patch series the clock consumer drivers will not crash thanks
> to the clock object reference counting. So the worst thing may happen is a
> clock left in an unexpected state.
> 
> However there should be no problems with the v4l2-async API, the host driver
> in its de-initialization routine unregisters its sub-drivers (they should
> stop using the clock when notified of such an event), only then the host
> would unregister the clock (subsequently the sub-drivers get re-attached and
> put into deferred probing state).

That in itself is a workaround I believe. Unbinding/rebinding devices from/to 
drivers isn't something the v4l core should do.

> There may be issues when a sub-driver's file handle is opened while the host
> is about to de-initialize. But I doubt resolution of such problems belongs
> to the common clock framework. I have been trying to improve the situation
> in small steps, rather than waiting forever for a perfect solution.
> 
> Do you perhaps have any ideas WRT to a "more generic solution" ? In general
> I have been trying to avoid using v4l2-clk and add what's missing in the
> common clock framework.
> 
> Perhaps we should leave only the kref part in the __clk_get(), __clk_put()
> hooks and be taking reference to a clock in clk_prepare() and releasing it
> in clk_unprepare() ? This way circular reference would exist only between
> clk_prepare(), clk_unprepare() calls.
> 
> Assuming a driver prepares clock in device's open() and unprepares in device
> close() handler perhaps it could all work better, without relying on the
> host to ensure the resource reference tracking. I'm not sure if that is not
> making too many assumptions for a generic API.

This is indeed an architecture decision that goes beyond the boundaries of the 
clock framework. The question boils down to how we want to acquire/release and 
refcount resources. Should drivers acquire and release hotpluggable resources 
at probe and remove time respectively, or only when they need them ? Or should 
they acquire them at probe them and be notified when they should release them 
? The first option adds an overhead but could help solving the circular 
dependency problem in a simpler way.

-- 
Regards,

Laurent Pinchart
