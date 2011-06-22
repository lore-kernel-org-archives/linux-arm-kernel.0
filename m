From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 22 Jun 2011 18:26:36 +0400
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <20110622142006.GC27654@legolas.emea.dhcp.ti.com>
References: <1308745217-10883-1-git-send-email-dbaryshkov@gmail.com>
	<20110622132314.GG23598@legolas.emea.dhcp.ti.com>
	<BANLkTimK0B-620-3DfRY4yGURGs=Y4uDQA@mail.gmail.com>
	<20110622140127.GB27654@legolas.emea.dhcp.ti.com>
	<BANLkTikDiBbVLSnsTuciVK5G1yfhxTJo0A@mail.gmail.com>
	<20110622142006.GC27654@legolas.emea.dhcp.ti.com>
Message-ID: <4E01FB9C.7020205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.06.2011 18:20, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jun 22, 2011 at 06:15:17PM +0400, Dmitry Eremin-Solenikov wrote:
>> On 6/22/11, Felipe Balbi<balbi@ti.com>  wrote:
>>> Hi,
>>>
>>> On Wed, Jun 22, 2011 at 05:52:18PM +0400, Dmitry Eremin-Solenikov wrote:
>>>> On 6/22/11, Felipe Balbi<balbi@ti.com>  wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, Jun 22, 2011 at 04:20:16PM +0400, Dmitry Eremin-Solenikov wrote:
>>>>>> Some platforms would like to disable D+ pullup on suspend, to drain as
>>>>>> low power, as possible. E.g. this was requested by mioa701 board
>>>>>> maintainers.
>>>>>
>>>>> I think this makes sense to many platforms, but by doing so, you would
>>>>> loose connection to the Host PC, so you need to make sure your device
>>>>> isn't been used before you go down this road.
>>>>
>>>> I've thought about this. Should UDC driver should somehow call into OTG
>>>> layer on suspend? My understanding is that otg_set_suspend isn't the call
>>>> that should be done here, is it true?
>>>>
>>>> My idea was that board can ask for D+ disabling, knowing itself the
>>>> behaviour
>>>> of the platform driver on suspend (e.g. PXA27x does disable UDC on
>>>> suspend,
>>>> but I dunno what effect this will cause on Host PC).
>>>
>>> Host PC will only see the device disconnecting. So, what happens if the
>>> user has mounted file systems when you decide to go into suspend ?
>>
>> What happens if user has mounted filesystems when I decide to pull out
>> the cable?
>
> for starters you could have filesystem corruption. In short, the best
> way would be to return -EBUSY in your suspend if the cable is still
> attached.

That was a rhetorical question. Basically there are plenty of situations
and cases (cable is not attached; cable attached, but no gadget driver;
cable attached, block gadget driver, but filesystems aren't mounted; 
cable attached, block gadget driver , filesystem mounted, but host
is also suspended, etc.).

> You could use osme VBUS IRQ to toggle a driver flag which, if true,
> would return -EBUSY on suspend().

I'm more and more thinking that this handling this -EBUSY isn't a task 
of gpio-vbus, but rather of some higher level driver. I'd assume that
if I hit this point, all previous drivers (which depend on this 
transceiver, so registered later) permit suspending at this moment,
so everything is OK :)

>
>> I agree with you generally, but I'd like to hear any suggestions.
>
> I'm not sure how to solve this, but OTOH the original code already did
> this, just on a different way, right ?

Yes. pxa27x udc driver disables D+ pullup on suspend and that's the 
behaviour asked from me by Robert Jarzmik in comments to first cleanup 
patch serie for pxa27x UDC driver.

-- 
With best wishes
Dmitry
