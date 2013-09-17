From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Sep 2013 09:59:17 +0200
Subject: [PATCH] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <52374FF7.8040604@wwwdotorg.org>
References: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379033737-30015-2-git-send-email-soren.brinkmann@xilinx.com>
 <52373314.5070806@wwwdotorg.org> <20130916164927.GB21352@roeck-us.net>
 <5237390E.5070203@wwwdotorg.org> <20130916173540.GA3481@roeck-us.net>
 <52374FF7.8040604@wwwdotorg.org>
Message-ID: <52380BD5.8080105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 08:37 PM, Stephen Warren wrote:
> On 09/16/2013 11:35 AM, Guenter Roeck wrote:
>> On Mon, Sep 16, 2013 at 10:59:58AM -0600, Stephen Warren wrote:
>>> On 09/16/2013 10:49 AM, Guenter Roeck wrote:
>>>> On Mon, Sep 16, 2013 at 10:34:28AM -0600, Stephen Warren wrote:
>>>>> On 09/12/2013 06:55 PM, Soren Brinkmann wrote:
>>>>>> Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
>>>>>> The devices generate low-jitter clock signals and are reprogrammable via
>>>>>> an I2C interface.
> ...
>>>>>> +Optional properties:
>>>>>> + - initial-fout: Initial output frequency to set during probe
>>>>>
>>>>> "probe" is a Linux-specific concept. This property should be removed. If
>>>>> the driver is asked to set a specific frequency, it should do so, but I
>>>>> don't think it should program something pro-actively just because it
>>>>> starts up.
>>>>>
>>>>> If this property is acceptable, it'd be better to describe it more along
>>>>> the lines of the following:
>>>>>
>>>>> initial-fout: The frequency at which the system requires the clock to
>>>>> operate.
>>>>
>>>> It should probably be something like "clock-frequency". In many use cases
>>>> the programmed frequency is set to a constant frequency at system startup
>>>> and never changed, similar to other clocks.
>>>
>>> I was going to suggest that too, but re-considered since I think
>>> clock-frequency is more appropriate for fixed-frequency clocks, rather
>>> than to specify the value at which a programmable clock generator should
>>> operate?
>>>
>>> I don't think we have a good story yet for how to represent
>>> how-we-want-the-clock-tree-configured, as opposed to representing the HW
>>> itself (which is what DT should be more about).
>>
>> In many cases the chip _is_ used to generate a fixed frequency, so we will
>> have to have a means to describe it. That it _can_ be used differently is a
>> different matter. After all, that is true for many clock generators.
>
> Perhaps if clock-frequency is specified, the driver should refuse to
> provide anything else. If clock-frequency isn't specified, the driver
> shouldn't touch the HW when it initializes, but should honor any
> requests that come in from other drivers? That would maintain what I
> feel is clock-frequency's connection to being a fixed clock.

For the clk-si5351 programmable clock driver in mainline, it already
uses "clock-frequency" for initial clock setup but allows to set it
later on. IMHO that is ok, because from a initial point-of-view, an
initial frequency is fixed. As soon as the driver takes over, the user
is free to do whatever he wants and should not be limited by DT.

But if we vote against that approach, we should probably also modifiy
clk-si5351 accordingly.

Sebastian
