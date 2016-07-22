From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 21 Jul 2016 17:07:53 -0700
Subject: [Xen-devel] [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <alpine.DEB.2.10.1607141132000.26575@sstabellini-ThinkPad-X260>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <146836236759.73491.11707389619985827497@resonance>
 <c320f820-8749-f4a4-435e-ddd9379655b5@de.bosch.com>
 <alpine.DEB.2.10.1607131941200.26575@sstabellini-ThinkPad-X260>
 <57868EDE.6060406@gmail.com>
 <146844380895.73491.4867379517577413421@resonance>
 <7df784ab-d0c0-939b-393e-214535c4b191@de.bosch.com>
 <alpine.DEB.2.10.1607141132000.26575@sstabellini-ThinkPad-X260>
Message-ID: <146914607316.8780.7961396342647226841@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefano Stabellini (2016-07-14 03:38:04)
> On Thu, 14 Jul 2016, Dirk Behme wrote:
> > On 13.07.2016 23:03, Michael Turquette wrote:
> > > Quoting Dirk Behme (2016-07-13 11:56:30)
> > > > On 13.07.2016 20:43, Stefano Stabellini wrote:
> > > > > On Wed, 13 Jul 2016, Dirk Behme wrote:
> > > > > > On 13.07.2016 00:26, Michael Turquette wrote:
> > > > > > > Quoting Dirk Behme (2016-07-12 00:46:45)
> > > > > > > > Clocks described by this property are reserved for use by Xen, and
> > > > > > > > the OS
> > > > > > > > must not alter their state any way, such as disabling or gating a
> > > > > > > > clock,
> > > > > > > > or modifying its rate. Ensuring this may impose constraints on
> > > > > > > > parent
> > > > > > > > clocks or other resources used by the clock tree.
> > > > > > > 
> > > > > > > Note that clk_prepare_enable will not prevent the rate from changing
> > > > > > > (clk_set_rate) or a parent from changing (clk_set_parent). The only
> > > > > > > way
> > > > > > > to do this currently would be to set the following flags on the
> > > > > > > effected
> > > > > > > clocks:
> > > > > > > 
> > > > > > >     CLK_SET_RATE_GATE
> > > > > > >     CLK_SET_PARENT_GATE
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Regarding setting flags, I think we already talked about that. I think
> > > > > > the
> > > > > > conclusion was that in our case its not possible to manipulate the
> > > > > > flags in
> > > > > > the OS as this isn't intended to be done in cases like ours. Therefore
> > > > > > no API
> > > > > > is exported for this.
> > > > > > 
> > > > > > I.e. if we need to set these flags, we have to do that in Xen where we
> > > > > > add the
> > > > > > clocks to the hypervisor node in the device tree. And not in the
> > > > > > kernel patch
> > > > > > discussed here.
> > > > > 
> > > > > These are internal Linux flags, aren't they?
> > > > 
> > > > 
> > > > I've been under the impression that you can set clock "flags" via the
> > > > device tree. Seems I need to re-check that ;)
> > > 
> > > Right, you cannot set flags from the device tree. Also, setting these
> > > flags is done by the clock provider driver, not a consumer. Xen is the
> > > consumer.
> > 
> > 
> > Ok, thanks, then I think we can forget about using flags for the issue we are
> > discussing here.
> > 
> > Best regards
> > 
> > Dirk
> > 
> > P.S.: Would it be an option to merge the v4 patch we are discussing here,
> > then? From the discussion until here, it sounds to me that it's the best
> > option we have at the moment. Maybe improving it in the future, then.
> 
> It might be a step in the right direction, but it doesn't really prevent
> clk_set_rate from changing properties of a clock owned by Xen.  This
> patch is incomplete. We need to understand at least what it would take
> to have a complete solution.
> 
> Michael, do you have any suggestions on how it would be possible to set
> CLK_SET_RATE_GATE and CLK_SET_PARENT_GATE for those clocks in a proper
> way?

No, there is no way for a consumer to do that. The provider must do it.

> 
> Like you wrote, I would imagine it needs to be done by the clock
> provider driver. Maybe to do that, it would be easier to have a new
> device tree property on the clock node, rather than listing phandle and
> clock-specifier pairs under the Xen node?

Upon further reflection, I think that your clock consumer can probably
use clk_set_rate_range() to "lock" in a rate. This is good because it is
exactly what a clock consumer should do:

1) get the clk
2) enable the clk
3) set the required rate for the clock
4) set rate range constraints, or conversely,
5) lock in an exact rate; set the min/max rate to the same value

The problem with this solution is that it requires the consumer to have
knowledge of the rates that it wants for that clock, which I guess is
something that Linux kernels in a Xen setup do not want/need?

Is it correct that you would prefer some sort of never_touch_this_clk()
api?

Regards,
Mike

> 
