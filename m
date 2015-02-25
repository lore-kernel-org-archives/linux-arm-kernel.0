From: yegor.yefremov@visionsystems.de (Yegor Yefremov)
Date: Wed, 25 Feb 2015 13:11:22 +0100
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <20150225111129.GA5062@lukather>
References: <20150121160631.GH4367@lukather>
 <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
 <54C0A8C9.3040201@visionsystems.de> <20150205132142.GD2079@lukather>
 <20150224103911.GR25269@lukather> <20150224145401.GH29829@saruman.tx.rr.com>
 <20150224165050.GX25269@lukather> <20150224173357.GB25042@saruman.tx.rr.com>
 <20150225111129.GA5062@lukather>
Message-ID: <54EDBBEA.8030509@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2015 12:11, Maxime Ripard wrote:
> On Tue, Feb 24, 2015 at 11:33:57AM -0600, Felipe Balbi wrote:
>> Hi,
>>
>> On Tue, Feb 24, 2015 at 05:50:50PM +0100, Maxime Ripard wrote:
>>> Hi Felipe,
>>>
>>> On Tue, Feb 24, 2015 at 08:54:01AM -0600, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Tue, Feb 24, 2015 at 11:39:11AM +0100, Maxime Ripard wrote:
>>>>> On Thu, Feb 05, 2015 at 02:21:42PM +0100, Maxime Ripard wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, Jan 22, 2015 at 08:37:45AM +0100, Yegor Yefremov wrote:
>>>>>>> I have the same experience with 3.15. The switching is working when
>>>>>>> CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16
>>
>> since 3.16 ?
> 
> That's what Yegor said. I never saw it working with 3.15 either.

I've used 3.15.1 and 3.15.2 with this set of patches: https://github.com/visionsystemsgmbh/onrisc_br_bsp/tree/master/board/vscom/kernel-patches/linux-3.15

And it worked so far. The system: http://www.visionsystems.de/produkte/baltos-ir-5221.html

>>>>>>> it seems to be broken. Still had no time to bisect this.
>>>>>>
>>>>>> I've been giving a few versions (from v3.15 to Tuesday's linux-next) a
>>>>>> try, and I always see the same behaviour now:
>>>>>>
>>>>>>   - Booting as a gadget (ie, with a USB cable plugged in), and
>>>>>>     swapping the cable for a (real, this time) USB OTG cable with a
>>>>>>     USB key never works. When the device is plugged, all I get is
>>>>>>
>>>>>> [  262.944846] usb 1-1: new high-speed USB device number 2 using musb-hdrc
>>>>>> [  278.064748] usb 1-1: device descriptor read/64, error -110
>>>>>>
>>>>>>     Putting in back in gadget results with a load of continuous:
>>>>>> [  315.258839] musb_bus_suspend 2484: trying to suspend as a_wait_vfall while active
>>>>>>
>>>>>>   - Booting as a host, or with nothing connected to it actually work,
>>>>>>     up to a few plug-a-device-then-plug-a-host cycles, where you end
>>>>>>     up with the following logs when disconnecting the device (somehow,
>>>>>>     it always happens when it is set in host mode).
>>>>>>
>>>>>> [   12.969075] CAUTION: musb: Babble Interrupt Occurred
>>>>>> [   12.974445] CAUTION: musb: Babble Interrupt Occurred
>>>>>> [   12.979637] musb_stage0_irq 789: unhandled DISCONNECT transition (a_wait_bcon)
>>>>>> [   12.988498] usb 1-1: USB disconnect, device number 2
>>>>>> [   13.071849] musb-hdrc musb-hdrc.0.auto: Restarting MUSB to recover from Babble
>>>>>>
>>>>>>     Plugging back our USB cable, with the AM335x acting as a device
>>>>>>     work once. Then, when it switches to the host mode, we end up with
>>>>>>     the same scenario than in the coldplug as gadget case: USB read
>>>>>>     error, before then having all the a_wait_vfall messages.
>>>>>
>>>>> Guys, any ideas/hints?
>>>>
>>>> which platform are you using ? I guess the only way to move here would
>>>> be to bisect between 3.15 and 3.16 to find the offending commit.
>>>
>>> 3.15 didn't work either unfortunately. I had the behaviour described
>>> above on all kernel between 3.15 and a 4.0-rc1-ish.
>>>
>>> This is on an custom design based on the am335x.
>>
>> has it ever worked ? I don't have a board here which can do dual role.
>> BBB has a mini-B only on the peripheral port.
> 
> I don't know if it ever worked.
> 
> Maxime
> 
