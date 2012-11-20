From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 14:17:24 -0700
Subject: [PATCH v3 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <20121120203127.GX14643@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
 <1353142266-1289-2-git-send-email-andrew@lunn.ch>
 <50AA6E7E.5060501@wwwdotorg.org> <20121120083749.GM10259@lunn.ch>
 <50ABB9B6.1010506@wwwdotorg.org> <20121120203127.GX14643@lunn.ch>
Message-ID: <50ABF364.1010004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 01:31 PM, Andrew Lunn wrote:
> On Tue, Nov 20, 2012 at 10:11:18AM -0700, Stephen Warren wrote:
>> On 11/20/2012 01:37 AM, Andrew Lunn wrote:
>>> Hi Jason
>>>
>>> These are good comments from Stephan that i want to address. However,
>>> i also don't want to delay the pull-requests direction arm-soc, the
>>> merge window is getting close. Both Linus and Anton have Acked the
>>> current version, so please go with what you have and i will produce a
>>> patch over the top. If its available before Arnd pulls, you can squash
>>> it, otherwise send it upstream as a standalone patch.
>>
>> I'm not sure I agree here; the comments I made re: the delays and
>> pulse-vs-level may affect the definition of the DT binding, and that's
>> something that should be correct from the start.
> 
> Hi Stephen
> 
> There should be no need to change the binding is a none-backwards
> compatible way. The current delays work for all current users.

Well, the binding isn't written for current users, the description is
just a generic "GPIO to turn off the system".

> If some
> other user comes along which needs longer delays, they can add an
> optional property which specified a longer delay.

The DT maintainers have in the past expressed a wish to define DT
bindings completely, rather than incrementally adding stuff if at all
possible. I guess they weren't CC'd on this patch; I've added them here
for comment. I'll defer to whatever they think here.

> The pulse-vs-level is needed for the potential PXA use case, which is
> where i took this code from. When we first proposed this driver,
> Russel King pointed to the PXA reset.c code and requested we create
> something which PXA could use. The configuring the GPIO as an input
> also come from PXA, which the current two uses user don't need.
> 
> I agree it need better documentation, but the current code covers all
> bases. It will turn off a level based system, it will also turn off an
> edge based system. There is no need to specify in the DT which is
> needed, it will just work.

I'm not convinced the pulse logic can be correct for arbitrary users who
expect a level-sensitive GPIO; what if the MPU (or whatever the GPIO is
connected to) is confused by the pulse and fails to power down when it
sees a pulse (e.g. as a safety measure), but would have worked fine with
just a regular level?

>> The implementation of gpio_poweroff_do_poweroff() really doesn't seem to
>> make sense; related to the above.
>>
>> Also, probe deferral doesn't work, which will likely make this code
>> completely ineffective.
> 
> This code has been tested by the two current users. It works. However,
> i agree about your comment here, and i will fix it in the follow up
> patch.

If this were a specific driver just for certain platforms, I think it
might be OK. Yet the driver purports to be generic. As such, I think we
need to make it explicitly work for the general case, not just happen to
work for the platforms that have been tested so far.
