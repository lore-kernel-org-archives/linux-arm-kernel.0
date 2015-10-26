From: dianders@chromium.org (Doug Anderson)
Date: Mon, 26 Oct 2015 16:49:52 -0700
Subject: [PATCH 0/4] Patches to fix remote wakeup on rk3288 dwc2 "host"
 port
In-Reply-To: <CAL_JsqLtYrzvreV68V5S0wFJNAR6JusnqZrLjsJwT6yXgrQKHg@mail.gmail.com>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
 <562B9F5F.1080800@kernel.org>
 <CAD=FV=VgYU8sZfSkbNbbOFpb-nt=Yy9NjybxADBnAiQXfasDpw@mail.gmail.com>
 <CAL_JsqLtYrzvreV68V5S0wFJNAR6JusnqZrLjsJwT6yXgrQKHg@mail.gmail.com>
Message-ID: <CAD=FV=UfdEN4MzAwZLWDTQ4qMakhchpr063U1e3uk6R96wScJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Mon, Oct 26, 2015 at 4:05 PM, Rob Herring <robh@kernel.org> wrote:
>>> A DT reset controller seems like a bit of an overkill here. I think this
>>> would be much more simple if we just add a phy reset hook to the phy
>>> subsystem.
>>
>> Adding a reset hook in the PHY subsystem does seem like a reasonable
>> idea to me.  I was considering it in an earlier version of this series
>> that actually used a reset of the PHY to the fix the stuck dwc2.
>>
>> ...but I think that even if the phy subsystem had a reset hook it
>> wouldn't be the ideal solution here.  When we assert the PHY "port
>> reset" we're not actually fully resetting the PHY.  We're instead
>> doing some sort of a more minor "state machine" reset in the PHY.
>> This appears better (in my case) than resetting the whole PHY because
>> it doesn't force a de-enumeration / re-enumeration.  Exposing this
>> more minor reset as a PHY reset seems wrong to me.  ...and it also
>> precludes us later also exposing the more full reset through the PHY
>> framework if that later becomes useful.
>
> Doesn't creating a binding also have similar possibility? Maybe an
> "attach host" or re-init hook would be more appropriate. I'm sure
> there are other such cases where the host and phy need more tight
> coupling. I recently had a similar case where there was an interleaved
> sequence of phy and host register writes. I managed rework things and
> avoid changing the phy interface, but there will certainly be cases
> where we can't.
>
> Changing function names in the kernel is easy. Changing the binding
> later not so much. Also as we're looking toward dependency handling,
> this creates a circular dependency. We'll probably have to deal with
> those anyway, but here it seems a bit pointless. We already have a
> connection between the host and phy defined. Let's use that and not
> define another.

I'm probably not understanding what you're proposing.  I was imagining
that you were proposing adding into "include/linux/phy/phy.h" a
definition like:

  int phy_reset(struct phy *phy);

If that existed in the PHY interface, it wouldn't be enough for me
since the "reset" that I'm doing isn't a full reset (and there does
exist another, fuller PHY reset on this SoC).  So if we wanted to use
the PHY interface, I'd need either:

  int phy_reset(struct phy *phy, int reset_id);
...or...
  int phy_reset(struct phy *phy, const char *reset_id);

I was expecting that to stay generic you'd somehow need to add a
mapping of these resets into the device tree because a given USB
controller may have different PHYs on different boards and the same
PHY might be used with more than one USB controller.  If you don't add
some type of mapping in the device tree then in _some_ type of include
file you'd need something like:

#define DWC2_RESET_ID_PHY_PORT_RESET  1
#define DWC2_RESET_ID_PHY_FULL_RESET  2
...or...
#define DWC2_RESET_ID_PHY_PORT_RESET  "phy_port_reset"
#define DWC2_RESET_ID_PHY_FULL_RESET  "phy_full_reset"

...presumably you'd expect that to be in a dwc2 header file, to be
included by the "rk3288 USB PHY"?  ...but, oddly enough, the "rk3288
USB PHY" is not specific to dwc2, so having it include a dwc2 header
file is pretty odd.  Specifically on rk3288 there are 3 instances of
the same PHY.  One is hooked up to the dwc2 "OTG" port.  One is hooked
up to the dwc2 "host" port (which doesn't have device functionality
and also has the need for this strange reset quirk).  One is hooked up
to an EHCI port (using the generic EHCI driver).

...so, while I could add a dwc2 specific include into the rk3288 PHY
driver, I'd need to somehow figure out which of the PHYs it applied
to.  For instance, maybe we later find that we need to activate this
reset for the EHCI port.  Now we'll need to include both headers.
...and hopefully there aren't name / number conflicts.

One note: the "full" PHY reset is actually not in the register map of
the PHY.  It is amazingly enough in the CRU (clock reset unit).  So if
we actually exposed the "full" reset through the PHY framework, the
PHY would then turn around and pass it off to the reset framework,
which is how the full PHY reset is exposed from the CRU.


>> ...we could, of course, re-invent the reset framework (with string or
>> integral IDs so we can assert different types of resets) within the
>> PHY framework.  That doesn't seem ideal to me, but if that's what
>> others want to do then I guess it would be OK...
>
> I think that should already be possible as you can have multiple
> cells. Of course, you have to plan for that with your cell values.

I didn't understand this comment.


Basically: to summarize, I think that we have a reset framework that
handles this beautifully and gets all the corner cases down.  Adding a
second link to the PHY seems totally reasonable to me because I could
totally imagine that this reset could be implemented in a totally
different place in some SoCs.  It happens to be in the PHY in my
particular case, but it need not be on all SoCs.

-Doug
