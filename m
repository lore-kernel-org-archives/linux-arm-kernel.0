From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Jan 2016 09:21:28 -0700
Subject: [PATCH v3 3/3] reset: Add support for shared reset controls
In-Reply-To: <56AB044F.7090102@redhat.com>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-4-git-send-email-hdegoede@redhat.com>
 <56AA7813.7080907@wwwdotorg.org> <56AB044F.7090102@redhat.com>
Message-ID: <56AB9188.9030009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2016 11:18 PM, Hans de Goede wrote:
> Hi,
>
> On 01/28/2016 09:20 PM, Stephen Warren wrote:
>>
>> On 01/27/2016 11:15 AM, Hans de Goede wrote:
>>> In some SoCs some hw-blocks share a reset control. Add support for this
>>> setup by adding new:
>>>
>>> reset_control_get_shared()
>>> devm_reset_control_get_shared()
>>> devm_reset_control_get_shared_by_index()
>>>
>>> methods to get a reset_control. Note that this patch omits adding of_
>>> variants, if these are needed later they can be easily added.
>>>
>>> This patch also changes the behavior of the existing exclusive
>>> reset_control_get() variants, if these are now called more then once
>>> for the same reset_control they will return -EBUSY. To catch existing
>>> drivers triggering this error (there should not be any) a WARN_ON(1)
>>> is added in this path.
>>>
>>> When a reset_control is shared, the behavior of reset_control_assert /
>>> deassert is changed, for shared reset_controls these will work like the
>>> clock-enable/disable and regulator-on/off functions. They will keep a
>>> deassert_count, and only (re-)assert the reset after
>>> reset_control_assert
>>> has been called as many times as reset_control_deassert was called.
>>>
>>> Calling reset_control_assert without first calling
>>> reset_control_deassert
>>> is not allowed on a shared reset control. Calling reset_control_reset is
>>> also not allowed on a shared reset control.
>>
>> Hmmm. Do you have some examples of how drivers are supposed to
>> co-ordinate use of the shared reset? Reference counting implies all
>> the drivers need to get together and all assert and de-assert the
>> reset in unison when some event happens. That seems difficult to
>> co-ordinate.
>
> Right, for now this is only intended for drivers which need to de-assert
> the
> reset and probe time and (re-)assert it when unbound (and maybe for
> suspend / resume, in which case the driver should be able to handle the
> reset
> never heaving been asserted on resume). This is also why
> reset_control_reset
> is not supported for shared resets.
>
> I hope that we will never see a case where a reset is actually needed
> for error handling (so used outside of probe / suspend cases) and it is
> shared.

OK, that sounds reasonable.

I guess the assumption is that the reset starts out asserted, and the 
first de-assert clears the reset signal. What if the default HW state 
has the reset de-asserted; is there any way for a driver to guarantee 
that the first deassert call is actually a deassert rather than a no-op? 
That would be useful so that drivers could assume their module's 
registers were reset due to the deassert call.

>> Instead, would it be better to require some central device to
>> exclusively get the reset, and manage it. That device could then react
>> to appropriate events to manage the reset. In this scheme, we wouldn't
>> need the concept of shared resets at all. However, depending on
>> why/when the reset needed to be re-asserted at run-time, this scheme
>> wouldn't eliminate the co-ordination issue, but equally I don't
>> believe it makes it any worse.
>
> If we ever need this kind of complexity, then yes a central service, with
> callbacks in to drivers requesting them to prepare for handling
> reset (like how usb does this) might be the best solution, but lets cross
> that bridge when we get there.

OK. Perhaps it's a good idea to spell out this usage model assumption 
explicitly somewhere? Perhaps it already is and I simply didn't look in 
enough detail.
