From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 23 May 2014 13:50:40 +0200
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
In-Reply-To: <20140523112239.GB12304@sirena.org.uk>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk>
Message-ID: <537F3610.3050104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/23/2014 01:22 PM, Mark Brown wrote:
> On Fri, May 23, 2014 at 11:13:44AM +0200, Hans de Goede wrote:
> 
>> Thinking more about this, I would like to make one change to my
>> proposal, the mmc-core should only do power up of child-nodes if
>> they have a compatible of: "simple-sdio-powerup". This way
>> when we add something more complex, we can keep the simple powerup
>> code in the mmc core, keeping what we've already using this working
>> and the mmc core won't respond to the child nodes for more complex
>> devices, so it won't conflict with more complex power-up handling
>> handled by some other driver.
> 
> Would it not be better to have this be something in the driver struct
> rather than in the device tree?  Putting a compatible in there would be
> encoding details of the Linux implementation in the DT which doesn't
> seem right especially since these are details we're thinking of changing
> later on.

The compatible is not a Linux specific thing, it is a marking saying
that something needs to take care of enabling the clks (and whatever
else we will make part of the binding for this compatible), before
scanning the mmc bus.

> Something like have the driver set flags saying if it wants
> to do complicated things.

Chicken <-> egg, we won't know which driver to use before we've probed
the mmc bus, and we cannot probe the bus before enabling the clks, etc.

>> FWIW if we ever get truely complex cases I think modeling the
>> power-up hardware as a pmic platform device is not a bad idea,
>> we would then need to have a generic mmc-host pmic property, which
>> would be used both to do the initial powerup before scanning, as
>> well as for the sdio device driver to get a handle to the pmic,
>> for run time power-management (if desired).
> 
> I don't know if this will ever apply to SDIO but with other buses the
> complicated bits come when the driver wants to take over some of the
> power management do things like turn some of the supplies or clocks on
> and off independently at runtime for low power modes.

Hmm, good point in that case actually having these things in the
child node makes most sense, because then the driver can find them
their. Note that the mmc core enabling things does not mean that
the driver cannot later disable them if needed.

Regards,

Hans
