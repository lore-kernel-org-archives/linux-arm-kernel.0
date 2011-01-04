From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 04 Jan 2011 09:55:02 +0200
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <87bp3y84ng.fsf@lechat.rtp-net.org>
References: <20101220154853.254931637@rtp-net.org>	<20101220155812.122749841@rtp-net.org>	<4D109C47.6020704@compulab.co.il>
	<8762ukb67c.fsf@lechat.rtp-net.org>	<4D14B69D.4030506@compulab.co.il>
	<87fwta8b99.fsf@lechat.rtp-net.org>	<4D21D00C.3040601@compulab.co.il>
	<87bp3y84ng.fsf@lechat.rtp-net.org>
Message-ID: <4D22D256.2040504@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/03/11 16:04, Arnaud Patard (Rtp) wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
>> On 01/03/11 13:41, Arnaud Patard (Rtp) wrote:
>>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>> Hi,
>>>> On 12/23/10 22:11, Arnaud Patard (Rtp) wrote:
>>>>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>>>>> Hi Arnaud,
>>>>>>
>>>>>> On 12/20/10 17:48, Arnaud Patard (Rtp) wrote:
>>>>>>> Current code doesn't handle setting CHRGVBUS when enabling vbus.
>>>>>>> Add support for it
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>>>>>> Index: tst-usb/drivers/usb/otg/ulpi.c
>>>>>>> ===================================================================
>>>>>>> --- tst-usb.orig/drivers/usb/otg/ulpi.c	2010-12-20 15:38:41.000000000 +0100
>>>>>>> +++ tst-usb/drivers/usb/otg/ulpi.c	2010-12-20 15:38:57.000000000 +0100
>>>>>>> @@ -234,7 +234,8 @@
>>>>>>>  {
>>>>>>>  	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
>>>>>>>  
>>>>>>> -	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT);
>>>>>>> +	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT |
>>>>>>> +			ULPI_OTG_CTRL_CHRGVBUS);
>>>>>>>  
>>>>>>>  	if (on) {
>>>>>>>  		if (otg->flags & ULPI_OTG_DRVVBUS)
>>>>>>> @@ -242,6 +243,9 @@
>>>>>>>  
>>>>>>>  		if (otg->flags & ULPI_OTG_DRVVBUS_EXT)
>>>>>>>  			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
>>>>>>> +
>>>>>>> +		if (otg->flags & ULPI_OTG_CHRGVBUS)
>>>>>>> +			flags |= ULPI_OTG_CTRL_CHRGVBUS;
>>>>>>>  	}
>>>>>>>  
>>>>>>>  	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>>>>>> I think this is a wrong place to set the ChrgVbus bit.
>>>>>> As for ULPI spec. 1.1:
>>>>>> "3.8.7.1 Session Request Protocol (SRP)
>>>>>> ULPI provides full SRP support. The Link uses the ChrgVbus and DischrgVbus bits
>>>>>> in the OTG Control register to begin and end a session."
>>>>>>
>>>>>> So it is used for SRP.
>>>>>> May be it is better to implement
>>>>>> int    (*start_srp)(struct otg_transceiver *otg);
>>>>>> method for setting this bit?
>>>>>>
>>>>> I was not sure on where to put this so I took the same approach as the
>>>>> fsl bsp which was to set it in this function and to call this function
>>>>> _after_ usb_add_hcd() [ see my previous patch ]. Indeed, it fixed my
>>>>> issue so I believe it not so bad given that there has already been some
>>>>> troubles on the ehci-mxc init.
>>>> Well, the problem is that this is supposed to be a generic driver and it should
>>>> somehow follow the ULPI spec.
>>>> This patch makes it more like mxc specific.
>>>>
>>>> As far as I understand, Session Request Protocol (SRP) allows a B-device (Peripheral)
>>>> to nudge an A-device (Host) to turn on the USB's Vbus.
>>>> This patch enables SRP along with Vbus, which seems incorrect completely.
>>>> ulpi_set_vbus() should set the Vbus (as its name says) and that's it.
>>> so, if I add a srp hook as you're suggesting, which part of the driver
>>> should call it ?
>> It should be called from outside the ulpi driver by the OTG logic
>> (just like ulpi_set_vbus() is called).
>> But, again, SRP should be set by the B-device (peripheral) and Vbus by the A-device (Host).
>> Usually, the A-device and B-device are on the opposite sides of the USB cable.
>>
>>>> Have you tried without this patch or have you just applied it along with other
>>>> patches from the fsl bsp?
>>> I already tried without this patch and without it, things are not
>>> working on my systems.
>>>> Also, if this specific patch (2/5) makes your USB (Host as I understand) work,
>>>> it makes me think that there could be some problem with your Vbus supply.
>>>> Have you checked that?
>>> I don't have any schematics and I've access only to the source code of
>>> the kernel running on the efika nettop and smartbook [1]. I've not seen
>>> anything (even remotely) related to vbus supply except in the ulpi code
>>> and from what I've heard, it's unlikely that there's something to
>>> control it on theses systems. Of course, I'll be happy to be proven
>>> wrong. Without usb theses systems are useless so anything the can reduce
>>> the number of patches needed to get the systems working with mainline is
>>> welcome.
>> Well, I was certain you are trying to use that port in Host mode (A-device), but
>> now I'm confused...
>> You say "things are not working" - what are those things?
>> Can you, please, describe what are you trying to do?
>> What are you trying to connect to this USB port? What cable do you
>> use?
> I thought it was clear that "things" was everything connected on the usb
> ports. The problem is that this also means that the nettop/smartbook are
> kind of not working too as ethernet/wifi/bt/hid devs are all connected
> on usb [ they're all on the pcb ]. So, even if you boot on the mmc aka
> the only storage available which doesn't need usb, you won't be able to
> login.
>

Well, "everything connected on the usb ports" can be confusing, because
you can connect devices (usb disk drives, keyboards, mice, etc..) and hosts
(desktop PCs, mobile computers, etc..) to the OTG port.
That's why I wanted to be sure, what devices do you connect to that port.
Now it is clear, that your port should be in the Host mode and you should _not_
issue an SRP.

"ethernet/wifi/bt/hid devs are all connected on usb" - this means,
that they are either connected to several (different) usb ports or there is a usb hub
connected to that port and those devices are connected to it.
Can you confirm how those devices are connected?

>> Also, what ulpi vendor/product id is reported in ulpi_init()?
> ULPI transceiver vendor/product ID 0x0424/0x0006
> Found SMSC USB3319 ULPI transceiver.

SMSC USB3319 does not have either an integrated Vbus switch or Charge Pump,
For the device connected to that transceiver could work properly,
there is a need in _external Vbus switch_ , that should be enabled using
some kind of CPEN pin (can be GPIO).
This means, that you don't even need to call ulpi_set_vbus().

Either way, this patch is NAK.
I think you need to check your hardware (in particular Vbus supply).

-- 
Regards,
Igor.
