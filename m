From: peda@axentia.se (Peter Rosin)
Date: Tue, 8 Aug 2017 14:46:30 +0200
Subject: [PATCH v2 2/3] usb: chipidea: Hook into mux framework to toggle
 usb switch
In-Reply-To: <150215709134.18242.599725161375995991@sboyd-linaro>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-3-stephen.boyd@linaro.org>
 <7080030c-c9c2-657d-aad4-aef636438cb1@axentia.se>
 <150215709134.18242.599725161375995991@sboyd-linaro>
Message-ID: <c5c411fe-2f5a-88cc-73e8-28ab61f5de04@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-08-08 03:51, Stephen Boyd wrote:
> Quoting Peter Rosin (2017-07-31 03:33:22)
>> On 2017-07-14 23:40, Stephen Boyd wrote:
>>> @@ -1964,16 +1965,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
>>>  
>>>  static int udc_id_switch_for_device(struct ci_hdrc *ci)
>>>  {
>>> +     int ret = 0;
>>> +
>>>       if (ci->is_otg)
>>>               /* Clear and enable BSV irq */
>>>               hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
>>>                                       OTGSC_BSVIS | OTGSC_BSVIE);
>>>  
>>> -     return 0;
>>> +     if (!ci_otg_is_fsm_mode(ci))
>>> +             ret = mux_control_select(ci->platdata->usb_switch, 0);
>>> +
>>> +     if (ci->is_otg && ret)
>>> +             hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
>>> +
>>> +     return ret;
>>>  }
>>>  
>>>  static void udc_id_switch_for_host(struct ci_hdrc *ci)
>>>  {
>>> +     mux_control_deselect(ci->platdata->usb_switch);
>>> +
>>
>> This looks broken. You conditionally lock the mux and you unconditionally
>> unlock it. Quoting the mux_control_deselect doc:
>>
>>  * It is required that a single call is made to mux_control_deselect() for
>>  * each and every successful call made to either of mux_control_select() or
>>  * mux_control_try_select().
>>
>> Think of the mux as a semaphore with a max count of one. If you lock it,
>> you have to unlock it when you're done. If you didn't lock it, you have
>> zero business unlocking it. If you try to lock it but fail, you also have
>> no business unlocking it. Just like a semaphore.
> 
> Good catch. I've added a if (!ci_otg_is_fsm_mode()) check here.
> 
>>
>> Another point: I do not know if udc_id_switch_for_host is *only* called
>> when there has been a prior call to udc_id_switch_for_device that
>> succeeded or how this works exactly. But this all looks fragile. Using
>> mux_control_select and mux_control_deselect *must* be done in pairs.
>> If you want a mux to be locked for "a while", such as in this case, you
>> have to make sure you stay within the rules. There is no room for half
>> measures, or you will likely cause a deadlock when something unexpected
>> happens.
>>
> 
> Can you elaborate? Is it bad that we keep it "locked" while we're in
> host or device mode?

No no, that's good. You do not want some other consumer of the same mux
controller to clobber your state (in case it's shared), so you absolutely
want to have the mux locked when you want it to remain in a specific
position.

>                      It looked like we paired the start/stop ops with
> each other so that the mux is properly managed across these ops.

Yes, it *looks* ok...

>                                                                  My
> testing hasn't shown a problem, but maybe there's some corner case
> you're thinking of? I'll double check the code.

...but since I do not know the usb code, I can't tell. What I worry about
is the usb core calling udc_id_switch_for_host or udc_id_switch_for_device
more than once without any call to the other in between. Maybe that is a
guarantee that the usb core makes? Or maybe it isn't? If e.g. there is a
third mode (or if one is added in the future), then the calls to
mux_control_select and mux_control_deselect would not be paired correctly.
Ok, sure, a third mode probably doesn't exist and will probably not be
added, but but but...

Also, what happens if udc_id_switch_for_device fails? Is it certain that
it will be called again before udc_id_switch_for_host is called, or is
the failure simply logged? If the latter, you might have a call to
mux_control_deselect without a preceding (and successful) call to
mux_control_select. That's fatal.

I have similar worries for host_start/host_stop, but for that case
host_stop is not allowed to fail, and it seems like a safe bet that
host_stop will only be called if host_start succeeds. So, I'm not as
worried there.

In other words, the question is if the usb core is designed to allow
this kind of "raw" resource administration in udc_id_switch_for_host and
udc_id_switch_for_device, or if you need to keep a local record of the
state so that you do not do double resource acquisition or attempt to
free resources you don't have?

I think I would feel better if the muxing for the device mode could
be done in a start/stop pair of function just like the host mode is
doing. Again, I don't know the usb code and don't know if such hooks
exist or not?

Cheers,
Peter
