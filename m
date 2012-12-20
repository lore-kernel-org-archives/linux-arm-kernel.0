From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 20 Dec 2012 21:16:15 +0100
Subject: CoreSight framework and drivers
In-Reply-To: <20121220195127.GA14877@pratikp-linux.qualcomm.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
 <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com>
 <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com>
Message-ID: <CAORVsuXB8kS69=UWA_FE42HabgaAA5gB4K52uJ_CFMv8-_hNiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratik,

On Thu, Dec 20, 2012 at 8:51 PM, Pratik Patel <pratikp@codeaurora.org> wrote:
> On Thu, Dec 20, 2012 at 11:46:13AM -0600, Jon Hunter wrote:
>>
>> On 12/19/2012 03:24 PM, Pratik Patel wrote:
>>
>> [snip]
>>
>> > Currently we use the CoreSight virtual bus to conveniently list
>> > sysfs configuration attributes for all the registered CoreSight
>> > devices.
>> >
>> > For eg:
>> > /sys/bus/coresight/devices/coresight-etm0/<attribute>
>> > /sys/bus/coresight/devices/coresight-etm1/<attribute>
>> > /sys/bus/coresight/devices/coresight-stm/<attribute>
>> > /sys/bus/coresight/devices/coresight-tmc-etf/<attribute>
>> > ...
>> > ...
>> >
>> > Some of the attributes are based on device type (i.e. source,
>> > link or sink) so they will exist for all devices of that type
>> > while some are device specific.
>> >
>> > Maybe I am misunderstanding the question but are you suggesting
>> > to register CoreSight devices to the AMBA bus instead of the
>> > CoreSight core layer code?
>>
>> Yes exactly.
>>
>> > Will Deacon mentioned earlier that AMBA framework can be changed
>> > to accomodate devices with a different class but I am more
>> > concerned with losing some of the stuff that the core layer code
>> > does (eg. coresight_register, coresight_enable, coresight_disable
>> > in coresight.c) if we register CoreSight drivers to the AMBA bus
>> > without letting the core layer know about the device connections.
>>
>> I may be missing something, but couldn't you keep all the
>> register/enable/disable stuff but just register the device with the amba
>> bus? Obviously some changes would need to be made.
>>
>
> Ok, so are you referring to making CoreSight devices register
> with AMBA bus instead of platform bus keeping everything else
> intact?
>
>> Personally, I don't have strong feeling either way, but we have ETM/ETB
>> drivers using AMBA today and so I am hoping we can come to agreement on
>> this going forward.
>>
>> Russell, Will, what are your thoughts?
>>
>> Otherwise, looking at the code, I like what you have implemented. I
>> still need to look closer, but I am struggling to figure out how a
>> coresight device such as the cross-trigger-interface fits with this
>> model. This model appears to be geared towards coresight devices used
>> for traces purposes and are either source, links or sinks. The
>> cross-trigger-interface is not a source or a sink. However, although you
>> it could be considered as a link (routing events), it is not really, as
>> it may not link to other coresight sinks/source.
>>
>> In my case, I have PMU-IRQ --> CTI --> GIC. So a non-coresight source
>> and sink. In away the CTI looks more like a 2nd-level interrupt
>> controller than anything else. Hence, another type of coresight device
>> may be needed in addition to source, links and sinks. Or link is
>> extended in some way to connect to non-coresight sources/sinks.
>>
>> Let me know if you have any thoughts.
>>
>
> I had left the "None" type for miscellaneous stuff but I agree it
> should be a separate type - maybe "debug".
>
> Having said that I like the CTI driver you have uploaded. Need to
> look at it in more detail. Since CTI connections can vary between
> chip to chip, we need a generic way to deal with it.
I am also interested to look at such a framework in order to have a
clean implementation of the ETM, PMI/CMI (HW tracing IP on OMAP4+).
I am currently busy on a driver for PMI/CMI which requires some
configuration of the Coresight, ETM, ETB, ATB etc. IP blocks.

Could you send your patches to linux-arm and linux-omap mailing lists?
I will be pleased to review them.

Regards,
Jean

>
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
