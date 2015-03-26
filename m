From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Mar 2015 19:38:18 +0000
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <CAMuHMdVpXCFk9Z68OeVt0924dhR_9vdLYmBkWun1UGY3NJJ4wg@mail.gmail.com>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <20150304120003.GL32624@x1> <20150306190812.11109.82130@quantum>
 <20150309092804.GB3427@x1>
 <CAMuHMdV8_uKQQgYkRPFOBgrqgw_y9A7T84ukfgWZpJmTL0eFCQ@mail.gmail.com>
 <20150326135144.GI5951@x1>
 <CAMuHMdVpXCFk9Z68OeVt0924dhR_9vdLYmBkWun1UGY3NJJ4wg@mail.gmail.com>
Message-ID: <20150326193818.GQ5951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Thu, Mar 26, 2015 at 2:51 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 25 Mar 2015, Geert Uytterhoeven wrote:
> >> On Mon, Mar 9, 2015 at 10:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> > On Fri, 06 Mar 2015, Mike Turquette wrote:
> >> >> This approach looks fine to me. In practice I think it is restricted to
> >> >> hardware blocks that don't exist in DT yet (e.g. no driver, in the case
> >> >> of your interconnect) and that restriction is probably for the best.
> >> >
> >> > Agreed.
> >>
> >> I think this restriction should be documented in the DT binding more clearly,
> >> as adding a "clk-always-on" node prohibits you from handling the clock
> >> correctly in
> >> the future.
> >
> > Would you mind taking the time to explain what you think those
> > limitations are?
> 
> If you add a "clk-always-on" node, the clock will always on using that DT.
> That will still be true later, when you get a better understanding of the
> hardware, and might discover you're gonna need a driver for the currently
> hidden core component that's driven by the clock, and may want to manage
> that clock.

So I have two points here.

First point; I think you're looking at an older version of my set.
The newer one can be found at [1] and no longer uses 'always-on'
nodes.  Instead the 'clk-always-on' property is applied to the
provider.  See the documentation patch [2] for more details.

Second point; this binding is _not_ to be used as a hack because the
hardware isn't understood.  Genuine uses are for clocks that must not
be turned off ever, else bad things will happen.  If the hardware is
not understood, use 'clk-disable-unused' on the kernel cmdline
instead.

> When that happens, you're gonna need a DT update to make use of the
> newly introduced driver and the features it provides (e.g. better power
> management).

The whole point of this set is to manage clocks that can't be power
managed.  Using the 'clk-always-on' property labels the clock with a
big-red-sign saying "DO NOT TURN ME OFF, OR RISK CATASTROPHIC
FAILURE", not a "TODO: Fix-me when you understand me".

> On the other hand, if you would describe the actual hardware topology in DT,
> the device node for the future driver would already be there, and no DT update
> is needed (assuming you can guess right w.r.t. its bindings; usually these are
> transparent buses, for which bindings are fairly generic, cfr. e.g.
> "simple-pm-bus").

In our case the devices these clocks control will never be added to
Device Tree.  Linux can't see them, they have no registers and they
can't be controlled.  Added a device driver for all such devices would
be foolhardy.

> Until you have (a need for) a real driver, you do need some platform code that
> makes sure the clock is enabled. When a real driver is introduced, the
> platform code has to be updated, but DT doesn't have to change.

No, this binding is _not_ for that use-case.  If your platform is
incomplete you must use 'clk-disable-unused'.  

> (The same is true for devices where the current driver isn't aware of the
>  clock, and shouldn't be, but you still need to enable the clock until the
>  driver has Runtime PM support (E.g. ARM GIC on shmobile, cfr.
>  https://www.marc.info/?l=linux-pm&m=142670617929493&w=3 (good, now
>  we have a bidirectional link between these two threads :-) Using a
>  "clk-always-on" property there instead of adding a reference to the clock
>  in the existing GIC device node would be just lying.)

If this clock should _genuinely_ be always-on, then use my new
binding in the clock controller node and the Clk framework will not
turn it off.

> If we start seeing many users, perhaps we need a general framework where
> the platform code can register a list of clocks that must be enabled (properly,
> i.e. using clk_prepare_enable())? But I don't think the list should be put
> in DT: DT describes hardware, not behavior.

I did this in the very first iteration of this set.  The DT guys
didn't like it, which is why I re-wrote it to look like [1].

> If you don't care about DT stability, and can afford always updating your DT
> with your kernel, the above doesn't apply. I heard during the ELC hallways
> chats this is actually the case for you?

My ears burning eh?  Do tell...

I think you currently misunderstand the use-case for this set.  I hope
my points above will clarify the point somewhat.  Once we write the
bindings and the DT nodes in [1], I don't plan for them to be changed,
thus our DT will stay stable in this regard.

NB: Yes, we are quite fortunate by the fact that most of are bindings
can be considered fairly transient, but that is irrelevant in this
particular case.

[1] https://lkml.org/lkml/2015/2/27/548
[2] https://lkml.org/lkml/2015/2/27/551

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
