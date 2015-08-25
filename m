From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 25 Aug 2015 15:45:55 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 (Doug Anderson's message of "Tue, 25 Aug 2015 14:48:41 -0700")
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
Message-ID: <7htwrn6l7g.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson <dianders@chromium.org> writes:

> Kevin,
>
> On Tue, Aug 25, 2015 at 2:07 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Caesar Wang <wxt@rock-chips.com> writes:
>>
>>> We can add more domains node in the future.
>>> This patch add the needed clocks into power-controller.
>>> As the discuess about all the device clocks being listed in
>>> the power-domains itself.
>>>
>>> There are several reasons as follows:
>>>
>>> Firstly, the clocks need be turned off to save power when
>>> the system enter the suspend state. So we need to enumerate
>>> the clocks in the dts. In order to power domain can turn on and off.
>>
>> Yes, but this is the job of device drivers which are runtime PM adapted
>> to gate their own clocks.  I agree these clocks need to be enumerated in
>> the DTS, but they should be in the device nodes.
>
> I _think_ what Caesar means is that the alternative to this patch is
> to leave the clocks on all the time as they were during the early days
> of Rockchip (AKA last year).  If the clocks are on all the time then
> the power domain patches can work fine.  However, once you start
> letting clocks turn off then you need to make sure that the power
> domain code turns the back on temporarily.

Yup, I understand that part, and many SoCs have this same "feature".

>>> Secondly, the reset-circuit should reset be synchronous on RK3288,
>>> then sync revoked. So we need to enable clocks of all devices.
>>> In other words, we have to enable the clocks before you operate them
>>> if all the device clocks are included in someone domians.
>>
>> Yes, this is pretty common for reset.
>>
>>> Someone wish was to get the clocks by reading the clocks from the
>>> device nodes, We can do that but we can solve the above issues.
>>
>> I don't follow this sentence.  Are you saying doing that will not solve
>> the above issues?  Why not?  Please explain.
>>
>> If there are non-device clocks that also need to be enabled before
>> asserting reset, then those are candidates for the power-domain node,
>> but not device clocks.
>
> It's been a long time and I don't know that I've reviewed every
> revision of this series, but I think there was a proposal that we
> shouldn't list clocks here.  Instead we should search through and find
> all devices that refer to this power domain, reach in and find their
> clocks, and turn them on.  Did I get that right?  

Yes...

> To put things in a
> concrete way, for pd_vio we'd go through the entire device tree
> ourselves and find all properties that look like "power-domains =
> <&power RK3288_PD_VIO>;".  We'd then find the parent of those
> properties and look for a property named "clocks".  We'd then iterate
> over all those clocks and turn those on.  Did I get that right?

... but you make it sound like more work than it is.  The genpd already
keeps a list of devices that refer to the power domain.  In fact, the
genpd 'attach' method can be platform-specific, so could be used to keep
track of a list (or a subset) of clocks which are needed for reset.

> The above doesn't seem like a terribly great idea to me for a number
> of reasons, including:
>
> 1. If I remember correctly, it's important to turn on clocks for
> devices even if they're not something you're using / have a driver
> for.  If you don't then the device won't get reset properly and this
> can affect things like suspend/resume because the hardware in the SoC
> will query all devices at suspend time to make sure they're ready.  

Correct.  This condition also exists in the clock framework when unused
clocks are disabled, or if you have drivers but PM_RUNTIME is disabled
(which can happen from userspace on a per-device basis) so it needs to
be understood and managed already.

> If
> a device is wedged because its clock wasn't on at the right them then
> it will cause problems.

Right.  I'm not arguing that the power domain doesn't have to deal with
device clocks. It has to for sync reset.  The objection I have have is
where these clocks are described.

> 2. If we absolutely need to turn all clocks and we get clocks from
> device tree nodes on then it means we need device tree nodes for every
> device in the domain.  

Isn't that the end goal?

> These would be needed even if there are no
> accepted bindings for this device yet.  So we'd need to do one of: A)
> Block power domain patches on feature complete bindings for all
> drivers; B) Make up non-approved compatible strings for all devices
> and throw them into the DTS; C) Add nodes in the DTS without a
> compatible string just to satisfy the power domain requirements.  None
> of these seem terribly appealing.

well, I think we can be slightly more accomodating than that and go for
somewhere in between:

D) In the power-domain DTS, clearly describe why each clock is needed by
the power-domain.  In particular list out clocks that are not device
clocks (and why they need to be asserted for reset) and separate those
from device clocks which are only listed in the power-domain because
there is not *yet* a driver/binding for that device node.

Doing it that way also makes it clear that when a new driver/binding is
added, the clocks should be removed from the power-domain node and put
into the device node.

Also, this addresses my primary concern that the DTS acurately describes
the hardware.  IOW, in hardware, most of these clocks are are properties
of devices, not power-domains, and the DT should reflect that.

IMO, if it's not describing the hardware, and is a placeholder until a
driver/binding is in place, it should be properly documented.

> 3. It is entirely possible that there are clocks that will be listed
> in the individual devices that aren't needed for powering on the power
> domain.  I'd tend to believe that PCLK_EDP_CTRL (the pixel clock)
> doesn't really need to be turned on when adjusting the "VIO" power
> domain.  Right now Caesar has it listed, but it probably isn't needed
> (Caesar: can you confirm?).

Yes, I suspect there are several of those, which is also why I'd like to
see the clocks in the power-domain node described in detail, and exacly 
why they're needed to be enabled.

Also, in the current proposed DTS, clocks that are listed in both device
nodes and the power domain are also suspicous, especially when the
device node doesn't have a power-domain property.  (c.f. vop[bl] nodes
and ACLK_VOP[01] clocks.)  For that matter, this series doesn't add any
devices to the power domains, which makes it even more confusing about
how this is meant to work.  IOW, with no devices belonging to
power-domains, how are the power-domain power_on/power_off callbacks
being called?

> 4. It seems just slightly brittle to be reaching into other device
> nodes and making assumptions about their properties.  Yeah, it's
> probably safe to assume that "clocks" has a list of clocks and
> "power-domains" will point to something whose first entry is a
> phandle, but it still seems just a tad bit like violating an
> abstraction barrier.

shmobile is already doing this with platform-specific genpd attach
callbacks, and using the pm_clk API.  I don't see any issues with that.

> Anyway, perhaps I'm misunderstanding, or perhaps my concerns are
> simply not for important things.  If so feel free to yell at me.  ;)

No need for me to yell. Your concerns are perfectly valid, and it's not
my style anyways. ;)

Thanks for the feedback,

Kevin
