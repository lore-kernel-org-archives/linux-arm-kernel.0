From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 28 Jun 2010 14:49:23 -0700
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <AANLkTimB0_OfLDvtkwwTE-kVeZrardIxVIsD5IEia-vL@mail.gmail.com>
	(Grant Likely's message of "Fri, 25 Jun 2010 17:04:13 -0600")
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<876316eno5.fsf@deeprootsystems.com>
	<AANLkTimB0_OfLDvtkwwTE-kVeZrardIxVIsD5IEia-vL@mail.gmail.com>
Message-ID: <87d3vaygik.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, Jun 25, 2010 at 4:46 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Grant Likely <grant.likely@secretlab.ca> writes:
>>
>>> Another way to look at the problem is that these runtime
>>> customizations are kind of a property of the parent device (the bus,
>>> not the bus_type). ?Would it make sense for parent devices to have
>>> runtime ops to perform for each child that is suspended/resumed? ?That
>>> would make it simple to register another device that implements the
>>> bus behaviour and attach it at runtime instead of compile time.
>>
>> Maybe I didn't fully understand your idea, but the problem here is
>> devices do not have dev_pm_ops. ?Only busses, classes, and types have
>> dev_pm_ops.
>
> Sorry, I mistyped.  What I meant was for the parent device's
> device_driver to be able to have a set of child dev_pm_ops; but I'm
> wading into territory (power management) I'm not particularly familiar
> with, and that might be making things far too complex.

I see your point now, but I think this indeed might complicate things
too much.  

Also, I'm not crazy about how this would delay the per-device PM hooks
to be essentially batched until all devices under the parent are
"ready."

But anyways, it just needs some more research on my part.
Unfortunately, I'll be away from this work on vacation for most of July,
so this won't get any attention from me until August.

>> Though I'm horribly unfamiliar with the intended usage of 'struct
>> device_type', an interesing discovery is that dev->type also has
>> dev_pm_ops, and it takes precedence over the bus type in the
>> suspend/resume. ?IOW, when suspending, when deciding which dev_pm_ops to
>> use, it checks class, type, then bus in that order.
>
> So I guess my suggestion above boils down to somehow inserting
> "parent" between type and bus in that list.
>
>> I need to explore this 'type' feature a little more, but using that or
>> the 'class' might be another way to have custom PM ops for certain
>> platform_devices.
>
> Should maybe start cc'ing Greg and linux-kernel/linux-pm in this discussion.

They were involved in the early discussions about overriding the
platform_bus dev_pm_ops methods, which led us to the current
implementation.

But as I explore the custom bus approach a bit more (in August) I'll
broaden the audience.

Thanks again for all your helpful suggestions,

Kevin
