From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 24 Oct 2012 16:40:17 +0300
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
In-Reply-To: <5087E3D9.6040007@ti.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
 <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
 <5087E3D9.6040007@ti.com>
Message-ID: <CANOLnONCL=anZa9u6AEd4YHkZpRAS2n-4VLbCv98rL3jRwSpyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 3:49 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 24 October 2012 05:32 PM, Grazvydas Ignotas wrote:
>>
>> On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>>
>>> From: Kevin Hilman <khilman@ti.com>
>>>
>>> When debounce clocks are disabled, ensure that the banks
>>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>>> subsequent off-mode transition will restore previous value from the
>>> shadow copies (bank->context.debounce*) leading to mismatch state
>>> between driver state and hardware state.
>>
>>
>> This doesn't look right to me, aren't you effectively disabling
>> debounce forever here? _gpio_dbck_disable is called from
>> omap_gpio_runtime_suspend() and nothing will ever restore
>> dbck_enable_mask back to what it was set by _set_gpio_debounce and
>> debounce functionality is lost.
>>
> As per commit log, the issue seen with request->debounce->free()
> sequence and hence on free, debounce state needs to be cleared.
> Next gpio_set_debounce() should set the debounce mask right so
> the patch seems to be right.
>
>
>>>
>>> This was discovered when board code was doing
>>>
>>>    gpio_request_one()
>>>    gpio_set_debounce()
>>>    gpio_free()
>>>
>>> which was leaving the GPIO debounce settings in a confused state.
>>> Then, enabling off mode causing bogus state to be restored, leaving
>>> GPIO debounce enabled which then prevented the CORE powerdomain from
>>> transitioning.
>>>
>
> But there is one more case which might break because of this patch.
> As part of idle, we might end up with below without gpio_free()
> omap2_gpio_prepare_for_idle()
>  ->pm_runtime_put_sync_suspend()
>   -> omap_gpio_runtime_suspend()
>    ->_gpio_dbck_disable()
>
> And last call will clear the debounce mask state which will lost and
> hence the debounce clock won't be enabled on resume.
>
> I let Kevin comment whether this is the valid case or not.

That's exactly what I had in mind - we lose debounce functionality on
first runtime suspend.

-- 
Gra?vydas
