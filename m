From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Oct 2016 09:17:01 +0100
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580BF1D4.2030509@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
Message-ID: <acb89755-61aa-65a7-2597-b22c1d3bba4c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/16 00:10, Mason wrote:
> On 22/10/2016 13:37, Marc Zyngier wrote:
> 
>> Mason wrote:
>>
>>> In my mental picture of interrupts (which is obviously so
>>> incomplete as to be wrong) interrupts are a way for hardware
>>> to tell the CPU that they urgently need the CPU's attention.
>>
>> That's how the CPU interprets it, but this is even more basic than
>> that, see below.
>>
>>> Obviously, the hardware being idle (line high) is not an urgent
>>> matter which interests the CPU. Likewise, I'm not sure the CPU
>>> cares that the hardware is busy (line low). It seems to me the
>>> interesting event from the CPU's perspective is when the
>>> hardware completes a "task" (transition from low to high).
>>
>> There is no such thing as "busy" when it comes to interrupts. An
>> interrupt signals the CPU that some device-specific condition has been
>> satisfied. It could be "I've received a packet" or "Battery is about to
>> explode", depending if the device is a network controller or a
>> temperature sensor. The interrupt doesn't describe the process that
>> leads to that condition (packet being received or temperature rising),
>> but the condition itself.
>>
>> In your cases, as the device seems to do some form of processing
>> (you're talking about task completion), then the interrupt seems to
>> describe exactly this ("I'm done").
> 
> The device is a graphics engine, which can be programmed to perform
> some operation on one or several frame buffers stored in memory.
> It outputs its state (idle vs busy) on interrupt line 23.
> 
>>> So I had originally configured the interrupt as IRQ_TYPE_EDGE_RISING.
>>> (There is an edge detection block in the irqchip, but the HW designer
>>> warned me that at low frequencies, it is possible to "miss" some edges,
>>> and we should prefer level triggers if possible.)
>>
>> Level and edge are not interchangeable. They do describe very different
>> thing:
>>
>> - Level indicates a persistent state, which implies that the device
>>   needs to be serviced so that this condition can be cleared (the UART
>>   has received a character, and won't be able to received another until
>>   it has been read by the CPU). Once the device has been serviced and
>>   that condition cleared, it will lower its interrupt line.
> 
> With this graphics engine, there is nothing the CPU can do to
> change what the engine outputs on the interrupt line:
> 
> When the graphics engine is idle, the line remains high, forever.
> When the graphics engine is busy, the line remains low, until
> all operations have been performed (engine idle).
> 
> All the CPU can do is mask the interrupt line at the interrupt
> controller, as far as I understand.

Then this is unambiguously a rising edge interrupt.

> 
>> - Edge is indicative of an event having occurred ("I'm done") that
>>   doesn't require any action from the CPU. Because the device can
>>   continue its life without being poked by the CPU, it can continue
>>   delivering interrupts even if the first one hasn't been serviced.
>>   Being edge triggered, the signals get coalesced into a single
>>   interrupt. For example, the temperature sensor will say "Temperature
>>   rising" multiple times before the battery explodes, and it is the
>>   CPU's job to go and read the sensor to find out by how much it has
>>   risen.
>>
>> If your device only sends a pulse, then it is edge triggered, and it
>> should be treated as such, no matter what your HW guy is saying. This
>> usually involves looking at the device to find out how many times the
>> interrupt has been generated (assuming the device is some kind of
>> processing element). Of course, this is racy (interrupts can still be
>> generated whilst you're processing them), and you should design your
>> interrupt handler to take care of the possible race.
> 
> It is clear that the block does not send a pulse on the
> interrupt line.
> 
> For reasons I don't understand, Linux didn't hang when I set
> the IRQ type to IRQ_TYPE_EDGE_RISING, so it seemed better
> than locking up the system.

Because that's exactly what that is.

> 
> I'm also fuzzy on what purpose the edge detector is supposed
> to serve... I had the impression is what supposed to "capture"
> an edge, to turn it into a level?

If you care to read the explanation I've given above, you'll realize
that you cannot turn an edge into a level, because they don't represent
the same thing (state vs event). The interrupt controller will latch on
a rising edge (for example), and present that information to the CPU, no
matter what the line does after that.

>> So, to make it short: find out how your device works, and configure
>> your interrupt controller in a similar way. Write your device driver
>> with the interrupt policy in mind (state vs event). Keep it simple.
> 
> Thomas said "We describe the level which is raising the interrupt".
> But I'm not sure I want the state "engine is busy" to raise an
> interrupt. "engine is idle" makes more sense. But you said it's
> stupid to set IRQ_TYPE_LEVEL_HIGH... /me confused

Because you insist on considering as a level something that is an edge.
Once you try to understand the nature of the signal the device is
providing, then you may stop getting confused.

You definitely don't want to generate an interrupt when the device is
idle, because that's a state on which you cannot act (apart from
constantly generating job for your graphics engine). What you want to
detect is the *transition* from busy to idle (event). Nothing else matters.

> Maybe the fact that disable_irq locks the system up is an orthogonal
> issue that needs to be fixed anyway.

Indeed.

	M.
-- 
Jazz is not dead. It just smells funny...
