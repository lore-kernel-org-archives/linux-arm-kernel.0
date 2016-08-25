From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 25 Aug 2016 19:59:46 +0200
Subject: [PATCH v2 7/7] musb: sunxi: Add support for platform_set_mode
In-Reply-To: <20160822161037.GK1853@uda0271908>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <1471288892-21702-8-git-send-email-hdegoede@redhat.com>
 <20160819213049.GC1853@uda0271908>
 <2a55a1bf-7ebf-3ab4-b231-85eba20103f1@redhat.com>
 <20160822141158.GF1853@uda0271908>
 <9699b62e-421a-ae8e-c25e-ef48beb84ce0@redhat.com>
 <20160822152421.GH1853@uda0271908>
 <fd1e9692-2c69-da16-0e6e-ac7fa50077ac@redhat.com>
 <20160822153842.GI1853@uda0271908>
 <2e1d2bb6-c3c4-17ab-79a6-8f9efa45a831@redhat.com>
 <20160822161037.GK1853@uda0271908>
Message-ID: <00986b3a-1a2a-1c67-f8bd-3a4c916cfbba@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-08-16 18:10, Bin Liu wrote:
> On Mon, Aug 22, 2016 at 05:55:50PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 22-08-16 17:38, Bin Liu wrote:
>>> On Mon, Aug 22, 2016 at 05:32:57PM +0200, Hans de Goede wrote:
>>
>> <snip>
>>
>>>>>>>>> When switching from host to peripheral mode, if an usb device is still
>>>>>>>>> plugged and enumerated, how do you handle the device disconnect?
>>>>>>>>
>>>>>>>> The phy code will report vbus low for long enough for the musb to end
>>>>>>>> the current session. It already does this for boards which do not
>>>>>>>> have working vbus detection.
>>>>>>>
>>>>>>> But you didn't disconnect DP/DM, right? then musb detects vbus is gone
>>>>>>> without receiving disconnect event, this is vbus error case, not a normal
>>>>>>> teardown.
>>>>>>
>>>>>> Correct, there is no way to disconnect DP/DM and reporting Vbus low for
>>>>>> a while does the trick.
>>>>>
>>>>> Without physically disconnecting DP/DM, we still have a way to properly
>>>>> teardown the enumerated devices. Please check musb_softconnect_write()
>>>>> in musb_debugfs.c.
>>>>
>>>> That is manipulating the session bit in the devctl reg, that does not
>>>> work to switch from device to host role or from host to device role,
>>>> at least not on allwinner's musb implementation. I've already tried that
>>>> before writing the code to report VBus low.
>>>
>>> I would think you have to call musb_root_disconnect() first to notify
>>> the core to teardown the enumerated devices.
>>
>> I tried that it does not help. It only affects the software state, the
>> hardware will still stay in host-mode if it does not see vbus low for
>> long enough).
>
> I didn't mean to use musb_root_disconnect() to replace your
> implementation. I suggest to add this call before lowing vbus to let the
> core tearing down the numerated devices.
>
>>
>> Note this is on devices which lack vbus detection (again this is simply
>> physically not available on the PCB, just like some PCB's miss the
>> id-pin). Normally this never is an issue, because when a host cable gets
>> unplugged from a AB connector we see the id pin go high, disable the
>> boards driving of Vbus and then the phy's Vbus detect will report low to
>> the musb controller.
>
> In this case, DP/DM get disconnected before vbus line, so
> musb_root_disconnect() gets called in handling the disconnect interrupt
> event. I think it is better simulate this in your usecase, which does
> not generate disconnect event.

Ah right, I ran some tests and indeed the hcd does not see a disconnect
on role-change unless musb_root_disconnect() gets called, I'll send a v4
fixing this.

Thank you for catching this.

Regards,

Hans


>
> Regards,
> -Bin.
>
>>
>> Anyways this is a solved problem, the reporting of Vbus low has been
>> working fine for both boards which lack vbus-detection as well as
>> for role-changing from sysfs.
>>
>> Regards,
>>
>> Hans
