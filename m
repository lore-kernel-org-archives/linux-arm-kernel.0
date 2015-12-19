From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Dec 2015 11:55:11 +0100
Subject: [linux-sunxi] Re: [PATCH v2 1/3] reset: Add shared
 reset_control_[de]assert variants
In-Reply-To: <20151218110810.GK30359@lukather>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <20151214093607.GF19456@lukather> <1450086655.3407.23.camel@pengutronix.de>
 <20151216102934.GR19456@lukather> <1450264908.3421.36.camel@pengutronix.de>
 <20151218110810.GK30359@lukather>
Message-ID: <5675378F.5010904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18-12-15 12:08, Maxime Ripard wrote:
> On Wed, Dec 16, 2015 at 12:21:48PM +0100, Philipp Zabel wrote:
>> Hi Maxime,
>>
>> Am Mittwoch, den 16.12.2015, 11:29 +0100 schrieb Maxime Ripard:
>>> On Mon, Dec 14, 2015 at 10:50:55AM +0100, Philipp Zabel wrote:
>>>> Am Montag, den 14.12.2015, 10:36 +0100 schrieb Maxime Ripard:
>>>>> Hi,
>>>>>
>>>>> On Fri, Dec 11, 2015 at 04:41:58PM +0100, Hans de Goede wrote:
>>>>>> diff --git a/include/linux/reset.h b/include/linux/reset.h
>>>>>> index c4c097d..1cca8ce 100644
>>>>>> --- a/include/linux/reset.h
>>>>>> +++ b/include/linux/reset.h
>>>>>> @@ -11,6 +11,8 @@ int reset_control_reset(struct reset_control *rstc);
>>>>>>   int reset_control_assert(struct reset_control *rstc);
>>>>>>   int reset_control_deassert(struct reset_control *rstc);
>>>>>>   int reset_control_status(struct reset_control *rstc);
>>>>>> +int reset_control_assert_shared(struct reset_control *rstc);
>>>>>> +int reset_control_deassert_shared(struct reset_control *rstc);
>>>>>
>>>>> Shouldn't that be handled in reset_control_get directly?
>>
>> I think I see your point now. Maybe we should add a flags parameter to
>> reset_control_get and/or wrap it in two versions,
>> reset_control_get_exclusive and reset_control_get_shared (or just add
>> the _shared variant). Then reset_control_get(_exclusive) could return
>> -EBUSY if a reset line is already in use.
>
> I guess the current assumption was that reset_control_get was
> exclusive.
>
> So we could have something like:
>
> reset_control_get (..) {
>    return __reset_control_get(.., 0);
> }
>
> reset_control_get_shared (..) {
>    return __reset_control_get(.., RESET_SHARED);
> }
>
> And all the logic shared between the two, without exposing any flag
> (that would change the prototype and require to fix every callers).
>
>>
>>>> This is about different expectations of the caller.
>>>> A driver calling reset_control_assert expects the reset line to be
>>>> asserted after the call.
>>>
>>> Is that behaviour documented explicitly somewhere?
>>
>> /**
>>   * reset_control_assert - asserts the reset line
>>   * @rstc: reset controller
>>   */
>
> Yeah, but it's not said when it would happen, or if it happens
> synchronously.
>
>> Also, that expected behavior matches the function name, which I like.
>> So I still welcome adding new API calls for the shared/refcounting
>> variant.
>>
>>>> A driver calling reset_control_assert_shared
>>>> just signals that it doesn't care about the state of the reset line
>>>> anymore.
>>>> We could just as well call the two new functions
>>>> reset_control_deassert_get and reset_control_deassert_put.
>>>
>>> What happens if you mix them? What happens if you have several drivers
>>> ignoring this API?
>>
>> The core should give useful error messages and disallow non-shared reset
>> calls on shared lines.
>
> I guess we could also have something like this:
>
>    * The driver gets the reference to the reset line using
>      reset_control_get or its shared variant.
>
>      - If you call reset_control_get on a free line, it succeeds, and
>        marks the line in exclusive use.
>      - If you call reset_control_get on a busy line, it fails with
>        EBUSY
>
>      - If you call the shared variant on a free line, it succeeds
>      - If you call the shared variant on a busy exclusive line, it
>        fails with EBUSY
>      - If you call the shared variant on a busy !exclusive line, it
>        succeeds.
>
>    * The customer driver can then call reset_control_assert / deassert:
>
>      - If the reset line is in exclusive use, the assertion happens
>        right away, it succeeds and returns 0.
>
>      - If the reset line is in a !exclusive use, but with a single
>        user, the assertion happens right away, it succeeds and returns
>        0.

Ack for all of the above, this is what I had in mind at first, but I started
with a more lightweight version as I'm lazy :)  If Philipp likes this
suggestion I can rework my patch-set into this.

>      - If the reset line is in a !exclusive use with more than 1 user,
>        the refcount is modified and an error is returned to notify that
>        it didn't happen.

Also ack, except for returning the error, if a driver has used
reset_control_get_shared, it should simply be aware that doing an assert
might not necessarily actually assert the line, just like doing a clk-disable
does not really necessary disable the clock, etc. If a driver is not prepared
to deal with this, it should simply not use reset_control_get_shared.

I see returning an error if the assert did not happen due to other users /
deassert_count != 0 as inconsistent compared to how clks, regulators and phys
handle this, these all simply return success in this case.

Regards,

Hans
