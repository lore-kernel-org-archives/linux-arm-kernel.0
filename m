From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 17:17:58 -0700
Subject: [PATCH v3 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <20121120220524.GZ14643@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
 <1353142266-1289-2-git-send-email-andrew@lunn.ch>
 <50AA6E7E.5060501@wwwdotorg.org> <20121120083749.GM10259@lunn.ch>
 <50ABB9B6.1010506@wwwdotorg.org> <20121120203127.GX14643@lunn.ch>
 <50ABF364.1010004@wwwdotorg.org> <20121120220524.GZ14643@lunn.ch>
Message-ID: <50AC1DB6.2080602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 03:05 PM, Andrew Lunn wrote:
> On Tue, Nov 20, 2012 at 02:17:24PM -0700, Stephen Warren wrote:
>> On 11/20/2012 01:31 PM, Andrew Lunn wrote:
>>> On Tue, Nov 20, 2012 at 10:11:18AM -0700, Stephen Warren wrote:
>>>> On 11/20/2012 01:37 AM, Andrew Lunn wrote:
>>>>> Hi Jason
>>>>>
>>>>> These are good comments from Stephan that i want to address. However,
>>>>> i also don't want to delay the pull-requests direction arm-soc, the
>>>>> merge window is getting close. Both Linus and Anton have Acked the
>>>>> current version, so please go with what you have and i will produce a
>>>>> patch over the top. If its available before Arnd pulls, you can squash
>>>>> it, otherwise send it upstream as a standalone patch.
>>>>
>>>> I'm not sure I agree here; the comments I made re: the delays and
>>>> pulse-vs-level may affect the definition of the DT binding, and that's
>>>> something that should be correct from the start.
>>>
>>> Hi Stephen
>>>
>>> There should be no need to change the binding is a none-backwards
>>> compatible way. The current delays work for all current users.
>>
>> Well, the binding isn't written for current users, the description is
>> just a generic "GPIO to turn off the system".
> 
> The current binding documentation is maybe lacking. But the binding
> itself fits the current users.
> 
>>> If some
>>> other user comes along which needs longer delays, they can add an
>>> optional property which specified a longer delay.
>>
>> The DT maintainers have in the past expressed a wish to define DT
>> bindings completely, rather than incrementally adding stuff if at all
>> possible. I guess they weren't CC'd on this patch; I've added them here
>> for comment. I'll defer to whatever they think here.
> 
> They were CC: I learn't the hard way with a USB binding....

Sorry to be picky, but I checked the original postings of the first rev
and V3 and they didn't appear to be CC'd. The mailing list was, but not
the people. I guess Grant did comment on the first rev though. He didn't
give an opinion on the DT binding that I can find.

>>> The pulse-vs-level is needed for the potential PXA use case, which is
>>> where i took this code from. When we first proposed this driver,
>>> Russel King pointed to the PXA reset.c code and requested we create
>>> something which PXA could use. The configuring the GPIO as an input
>>> also come from PXA, which the current two uses user don't need.
>>>
>>> I agree it need better documentation, but the current code covers all
>>> bases. It will turn off a level based system, it will also turn off an
>>> edge based system. There is no need to specify in the DT which is
>>> needed, it will just work.
>>
>> I'm not convinced the pulse logic can be correct for arbitrary users who
>> expect a level-sensitive GPIO; what if the MPU (or whatever the GPIO is
>> connected to) is confused by the pulse and fails to power down when it
>> sees a pulse (e.g. as a safety measure), but would have worked fine with
>> just a regular level?
> 
> Lets go through the sequence for a regular level off.....
> 
> At driver load time, assuming the optional input properties is not
> present, the GPIO line is driven inactive. At power down time, its
> driven active. One of four things can happen:
...
> 4) The delay is not long enough. In that case it goes inactive again,
> there is a short pause, and it goes active again. There is another
> pause, this time much longer.  Still the power does not go off and we
> hit the WARN_ON(1); The power remains on, until somebody pulls the
> plug.
> 
> Your scenario is that a 100ms pulse confuses the MPU, and after that,
> it won't turn off given a much longer period of the gpio being
> active. We run into 4). Is that really likely?

Yes, (4) is my concern.

Honestly, I don't know if it's likely. It's certainly theoretically
possible. Either way though, I'd rather the kernel explicitly drive the
signal in the fashion that the specific HW expects it to be driven,
rather than wiggling the GPIO in a way that by luck happens to work for
a variety of disparate requirements.

Anyway, I've made my opinion clear. Whoever would merge this patch can
choose to ignore it or not.
