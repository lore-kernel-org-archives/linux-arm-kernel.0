From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 12 Sep 2016 12:13:04 -0600
Subject: [PATCH v2 00/17] Make rpmsg a framework
In-Reply-To: <20160912180015.GH405@tuxbot>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
 <20160912165233.GB21885@linaro.org> <20160912180015.GH405@tuxbot>
Message-ID: <bc618ac9-13c8-e9bf-c7e9-fe5b7309a585@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/12/2016 12:00 PM, Bjorn Andersson wrote:
> On Mon 12 Sep 09:52 PDT 2016, Lina Iyer wrote:
>
>> Hi Bjorn,
>>
>> On Thu, Sep 01 2016 at 16:28 -0600, Bjorn Andersson wrote:
>>> This series splits the virtio rpmsg bus driver into a rpmsg bus and a virtio
>>> backend/wireformat.
>>>
>>>
>>> As we discussed the Qualcomm SMD implementation a couple of years back people
>>> suggested that I should make it "a rpmsg thingie". With the introduction of the
>>> Qualcomm 8996 platform, we must support a variant of the communication
>>> mechanism that share many of the characteristics of SMD, but are different
>>> enough that it can't be done in a single implementation. As such there is
>>> enough benefit to do the necessary work and being able to make SMD a "rpmsg
>>> thingie".
>>>
>>> On-top of this series I have patches to switch the current smd clients over to
>>> rpmsg (and by that drop the existing SMD implementation).
>>>
>>> All this allows me to implement the new backend and reuse all existing SMD
>>> drivers with the new mechanism.
>>>
>>
>> RPM Communication has to supported even when IRQs are disabled. The most
>> important use of this communication is to set the wake up time for the
>> CPU subsystem when all the CPUs are powered off.
>
> Can you point me to the downstream code where this is implemented so I
> can have a look? Do you expect to get the response on that request?

Have a look at -
smd_mask_receive_interrupt()
smd_is_pkt_avail()

Every request to the RPM generates a response.  The Linux RPM driver may 
decide to let the response sit in the fifo, or it may need to read and 
process it.

>
>> In addition to that,
>> "sleep" votes that are sent by the application processor subsystem to
>> allow system to go into deep sleep modes can only be triggered when the
>> CPU PM domains are power collapsed, drivers do not have a knowledge of
>> when that happens.
>
> Do you mean the actual sleep votes can only be with the CPU PM domains
> collapsed?
>
> It's been a while since I dug through that code, but there was several
> cases where sleep votes would be sent out during normal execution as
> well, and then there's the optimization of flushing out all cached sleep
> votes when we're on the way down.
>
>> This has to be done by a platform code that registers
>> for CPU PM domain power_off/on callbacks.
>>
>
> Ok, sounds like we have a legit use case for improving this.
>
>> Using rpmsg may be nice for RPM SMD communication, but mutexes need to
>> go away for this driver to be any useful than bare bones active mode
>> resource requests for QCOM SoCs. By not doing that now, we lock
>> ourselves out of using this SMD driver in the near future when CPU PM
>> domains are available in the kernel with an ability to do system low
>> power modes.
>>
>
> The last time I looked at this there where no cases when it was
> _required_ to support transmitting requests to the rpm from IRQ context.

I no longer work on SMD, but when I did this was in fact a strict 
requirement.  If I recall correctly, there was a parameter in the RPM 
driver for the transmit function that indicated if the request was being 
made in atomic context or not, which would change the behavior of how 
the transmit was handled.

>
> iirc we could set up the sleep votes in normal context and the
> transition was triggered through SAW(?)
>
>> I hope you would make rpmsg work in IRQ disabled contexts first before
>> porting the SMD driver.
>>
>
> There are two parts of this request;
>
> The first is to be able to send data from irq context. The proposed
> patches doesn't affect the implementation of send, so it's just a matter
> of changing qcom_smd_send() and make the necessary adjustments in the
> rpm driver.
>
> In the event of the tx fifo being full we normally do want to sleep on
> there being space, but if we switch to spinlocks you would be able to
> issue an rpmsg_trysend() which would bypass this - and you can roll a
> busy wait in the caller.
>
>
>
> The other part is how to receive responses in this mode. Messages are
> pulled off the fifo in IRQ context and delivered to the consumer in IRQ
> context. But if you have irqs disabled then this wouldn't be triggered.
>
> So if you need your responses we need to figure something out here. And
> part of the ugliness of downstream is the need to drain the fifo just
> enough before going to sleep, so that the RPM won't stall on a full
> fifo.
>
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
