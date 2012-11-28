From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 28 Nov 2012 18:52:36 +0530
Subject: [PATCH v3 02/11] clk: davinci - add PSC clock driver
In-Reply-To: <20121127172900.21126.89528@nucleus>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-3-git-send-email-m-karicheri2@ti.com>
 <50950908.1060302@ti.com> <5097D6FC.7040202@ti.com>
 <20121110022254.18014.31873@nucleus> <50B4D6B1.3000903@ti.com>
 <20121127172900.21126.89528@nucleus>
Message-ID: <50B6101C.30502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 10:59 PM, Mike Turquette wrote:
> Quoting Sekhar Nori (2012-11-27 07:05:21)
>> Hi Mike,
>>
>> On 11/10/2012 7:52 AM, Mike Turquette wrote:
>>> Quoting Murali Karicheri (2012-11-05 07:10:52)
>>>> On 11/03/2012 08:07 AM, Sekhar Nori wrote:
>>>>> On 10/25/2012 9:41 PM, Murali Karicheri wrote:
>>>>>> This is the driver for the Power Sleep Controller (PSC) hardware
>>>>>> found on DM SoCs as well Keystone SoCs (c6x). This driver borrowed
>>>>>> code from arch/arm/mach-davinci/psc.c and implemented the driver
>>>>>> as per common clock provider API. The PSC module is responsible for
>>>>>> enabling/disabling the Power Domain and Clock domain for different IPs
>>>>>> present in the SoC. The driver is configured through the clock data
>>>>>> passed to the driver through struct clk_psc_data.
>>>>>>
>>>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>>>> ---
>>>>>> +/**
>>>>>> + * struct clk_psc - DaVinci PSC clock driver data
>>>>>> + *
>>>>>> + * @hw: clk_hw for the psc
>>>>>> + * @psc_data: Driver specific data
>>>>>> + */
>>>>>> +struct clk_psc {
>>>>>> +    struct clk_hw hw;
>>>>>> +    struct clk_psc_data *psc_data;
>>>>>> +    spinlock_t *lock;
>>>>> Unused member? I don't see this being used.
>>>>
>>>> OK. Will remove.
>>>
>>> Those locks are only used for the case where a register might contain
>>> bits for several clocks.  Thus RMW operations are protected.  On OMAP
>>> this isn't necessary due to a very generous register layout (typically
>>> one 32-bit reg per module) controlling clocks.  Seems tha tmaybe this is
>>> not needed for PSC module either?
>>
>> Sorry about the late reply. The above is not totally true for PSC. There
>> are some registers (like PTCMD) which are common for all clocks.
>>
>> There is an enable_lock used in drivers/clk/clk.c which serializes all
>> enable/disable calls across the clock tree. Since that is done, further
>> locking at clk-psc level is not really needed, no?
>>
> 
> I haven't finished looking through the PSC design document yet, but my
> answer to your question is this:
> 
> If a register is only used for clk_enable/disable calls (not touched by

This is right, all PSC registers are only touched in clk_enable/disable
calls. clk-psc.c also populates .is_enabled, but that's only a regsiter
read anyway. Plus looks like even that is always accessed under enable_lock.

> anything held under the prepare_lock mutex) and if that register isn't

The requirement that these registers should not be touched when held
under prepare_lock mutex is not met because functions like
clk_disabled_unused_subtree() which are called under prepare_lock mutex
will end up calling clk_disable() anyway.

Perhaps you meant: not touched by anything under 'prepare_lock' mutex
while being outside of the 'enable_lock' spinlock?

> used anywhere else in the code (outside of the clk framework) then yes,
> the enable_lock spinlock is enough for you.

No, they are not accessed out side of clk framework. At least currently.
PSC can also be used to provide a "reset" to some IPs, but there is no
"reset framework" which uses this feature.

> Also have you looked into regmap?  Since you are defining your own clock
> type that might be something nice for you.

No, haven't looked at regmap yet. Will look at that.

Thanks,
Sekhar
