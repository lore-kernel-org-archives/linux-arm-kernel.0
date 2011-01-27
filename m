From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Thu, 27 Jan 2011 20:53:38 +0530
Subject: [PATCH v10 18/18] OMAP2, 3: DSS2: Get DSS IRQ from platform device
In-Reply-To: <4D416D69.6030200@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	<1295850125-21405-19-git-send-email-sumit.semwal@ti.com>
	<4D4169D1.20001@ti.com>
	<20110127125955.GC26418@n2100.arm.linux.org.uk>
	<4D416D69.6030200@ti.com>
Message-ID: <AANLkTimrU=TNeX46dK9LZSNxa6QXJZJewKonSWFOSpkv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raghuveer,

On Thu, Jan 27, 2011 at 6:34 PM, Raghuveer Murthy <x0075817@ti.com> wrote:
> On Thursday 27 January 2011 06:29 PM, Russell King - ARM Linux wrote:
>>
>> On Thu, Jan 27, 2011 at 06:19:21PM +0530, Raghuveer Murthy wrote:
>>>>
>>>> + ? ? ? r = request_irq(dss_irq,
>>>> + ? ? ? ? ? ? ? cpu_is_omap24xx()
>>>> + ? ? ? ? ? ? ? ? dss_irq_handler_omap2
>>>> + ? ? ? ? ? ? ? : dss_irq_handler_omap3,
>>>
>>> it should be
>>>
>>> ? ? ? ? ? ? ? ?cpu_is_omap24xx()
>>> ? ? ? ? ? ? ? ?? dss_irq_handler_omap3
>>> ? ? ? ? ? ? ? ?: dss_irq_handler_omap2,
>>>
>>> I am seeing a crash on Panda, which gets rectified with this
>>> change. The root cause is access to DSS_IRQSTATUS register in the
>>> dss_irq_handler_omap3 handler, which is not valid for OMAP4.
>>
>> That really doesn't look right. ?Let me translate the code you've just
>> written:
>>
>> ? ? ? ?if (cpu_is_omap24xx())
>> ? ? ? ? ? ? ? ?handler = dss_irq_handler_omap3;
>> ? ? ? ?else
>> ? ? ? ? ? ? ? ?handler = dss_irq_handler_omap2;
>>
>> Which means: if we have an OMAP24xx device, use the OMAP3 handler,
>> otherwise use the OMAP2 handler. ?That's got to be wrong.
>>
> I agree, that the logic seems counter-intuitive. I was doing a quick test.
>
> However, to ?keep the correct sequence, the logic inside the respective
> handlers need to be looked at.
If you see the patch series, this is relevant only for OMAP2,3. OMAP4
related IRQ handling is not yet introduced.
There would a different patch set which should set the correct irq
handler for OMAP4.
>
> Regards,
> Raghuveer
>
