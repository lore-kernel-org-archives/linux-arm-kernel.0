From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 15 Sep 2015 04:54:00 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in
 host-only mode
In-Reply-To: <20150914202533.GF4684@lukather>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
 <55C47041.3000603@schinagl.nl> <55E93D8C.9020804@schinagl.nl>
 <55F1CA9B.3070204@redhat.com> <20150910183017.GN9885@lukather>
 <55F1CE2E.7010409@redhat.com> <20150914202533.GF4684@lukather>
Message-ID: <55F78848.6020403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/14/2015 10:25 PM, Maxime Ripard wrote:
> On Thu, Sep 10, 2015 at 08:38:38PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10-09-15 20:30, Maxime Ripard wrote:
>>> On Thu, Sep 10, 2015 at 08:23:23PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 04-09-15 08:43, Olliver Schinagl wrote:
>>>>> Hey Hans,
>>>>>
>>>>> On 07-08-15 10:45, Olliver Schinagl wrote:
>>>>>> <snip>
>>>>>>> If you change the dr_mode to host then you _must_ also remove any id_det and vbus_det
>>>>>>> gpio settings from the usb_phy node in the dts, as the sun4i phy code detects
>>>>>>> host vs otg mode by checking for the presence of these.
>>>>>> Yes, this fixes it and makes it work. Thanks.
>>>>>>
>>>>> I've been going back to this and am wondering if this is something I can look into to fix properly? E.g. if the dts sets dr_mode = host, can we simply ignore the pins and treat them as unset?
>>>>
>>>> AFAIK you cannot unset something in dts. The only solution I
>>>> can comeup with is to add a dr_mode argument to the phy like
>>>> we already have for the otg controller itself.
>>>>
>>>> This is something which we likely need to do anyways to add
>>>> support for peripheral only mode, which we seem to need for
>>>> some "hdmi sticks".
>>>
>>> I haven't really followed the rest of the discussion, so sorry if you
>>> already talked about that, but why can't you just set the dr_mode to
>>> peripheral in such a case?
>>
>> This is about the usbphy code not the musb-controller code, which are
>> 2 different dts nodes, atm only the musb-controller node has a
>> dr_mode property, and the phy code decides between host-only
>> and otg mode based on whether an id pin is assigned or not.
>>
>> My proposal is to get rid of the id-pin hack to determine the mode
>> and add a dr_mode property to the usbphy dts node.
>
> I agree that we should get rid of that hack, especially since a lack
> of an ID pin might also be used on a peripheral-only device.
>
> However, we already have that information in the musb node, and
> duplicating the info seems error prone. We already have a custom
> function, maybe that's a case for another one

AFAIK the musb / phy maintainers really want to avoid adding more
custom functions ...

Felipe, Kishon any comments on this ?

Regards,

Hans
