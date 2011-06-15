From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jun 2011 10:53:31 +0100
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <BANLkTinov=XKF5dH9EOpMj=oQC7oyKGKfA@mail.gmail.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>	<4DDD3C57.6020705@samsung.com>	<1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>	<4DDD531A.50604@samsung.com>	<1306422710.27474.237.camel@e102391-lin.cambridge.arm.com>	<BANLkTi=fjq5ki8BGDhQxHVD3u-s7W-C1rw@mail.gmail.com>	<1307003689.31098.6.camel@e102391-lin.cambridge.arm.com>	<BANLkTi=mvCgi_6Y57aVjpwrMhL58zPcUHw@mail.gmail.com>	<1307004853.31098.12.camel@e102391-lin.cambridge.arm.com>	<BANLkTi=hEBKTpEq6daMyEdLo63aet52Gbg@mail.gmail.com>
	<BANLkTinov=XKF5dH9EOpMj=oQC7oyKGKfA@mail.gmail.com>
Message-ID: <4DF8811B.9090506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/11 01:52, Kyungmin Park wrote:
> On Wed, Jun 15, 2011 at 7:26 AM, Angus Ainslie <angus.ainslie@linaro.org> wrote:
>> On Thu, Jun 2, 2011 at 2:54 AM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>>> On Thu, 2011-06-02 at 17:39 +0900, Kyungmin Park wrote:
>>>> On Thu, Jun 2, 2011 at 5:34 PM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>>>>> On Thu, 2011-06-02 at 16:01 +0900, Kyungmin Park wrote:
>>>>>> On Fri, May 27, 2011 at 12:11 AM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>>>>>>> On Wed, 2011-05-25 at 12:06 -0700, Kukjin Kim wrote:
>>>>>>>> On 05/25/11 11:04, Marc Zyngier wrote:
>>>>>>>>> On Wed, 2011-05-25 at 10:28 -0700, Kukjin Kim wrote:
>>>>>>>>>> On 05/20/11 06:46, Marc Zyngier wrote:
>>>>>>>>
>>>>>>>> (snip)
>>>>>>>>
>>>>>>>>> So that address has changed between two SoC revisions? That's
>>>>>>>>> unfortunate, to say the least. I'm most probably using an early revision
>>>>>>>>> of the hardware (EVT0?), as it doesn't even support MCT.
>>>>>>>>>
>>>>>>>> I'm afraid :( and I agree secondary CPU should work on all of
>>>>>>>> Exynos4210. But I'm still think about the method...
>>>>>>>>
>>>>>>>>> What about the following patch?
>>>>>>>>>
>>>>>>>> Uhm...this is really hack but I'd like to use another normal way...?
>>>>>>>
>>>>>>> Oh, no question about the hack status. The trouble is, unless there is a
>>>>>>> sure way to tell which SoC revision we're running on, there's little
>>>>>>> else we can do than poke both locations and pray.
>>>>>>>
>>>>>>> Is there such a way to identify the SoC revision?
>>>>>>
>>>>>> It's also required for OneNAND. as you know C210 EVT0 OneNAND DMA has
>>>>>> bug and need to workaround.
>>>>>>
>>>>>> platform codes should provide the these function. please see the OMAP
>>>>>> codes. how to handle it.
>>>>>
>>>>> So we know there's a need beyond the wish to see the second core up and
>>>>> running on my board.
>>>>>
>>>>> Now what is the proper method to detect the revision of the SOC?
>>>>> Handling it is no problem, once we have the information. Unfortunately
>>>>> the documentation I have is less than helpful on that subject.
>>>>
>>>> It can be distinguished by chip id. but there's no code to handle this one.
>>>>
>>>> 0x4320 0200 EVT0
>>>> 0x4321 0210 EVT1
>>>> 0x4321 0211 EVT2
>>>
>>> Apparently, the low 8 bits can be overloaded by the efuse. Which makes
>>> telling EVT1 from EVT2 unreliable.
>>>
>>> But at least this is a start. I'll see if I can come up with something
>>> minimal enough to be merged as a fix.
>>>
>>> Thanks,
>>>
>>>        M.
>>> --
>>> Reality is an implementation detail.
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Would something like this work instead ? It seems to work on EVT0 but
>> I haven't had a chance to test on EVT1.
>>
>>
>> From a4c1b643596599df9d79776c9b94f2536661a4c9 Mon Sep 17 00:00:00 2001
>> From: Angus Ainslie <angus.ainslie@linaro.org>
>> Date: Tue, 14 Jun 2011 16:13:35 -0600
>> Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revisions
>>
>> It appears that the system-wide flags register that used to be at
>> 0x02025000 on the first revision of Exynos4 has moved to 0x02020000.
>>
>> The kernel has been updated accordingly, but this unfortunately leaves
>> early boards without SMP support (the secondary CPU spins endlessly
>> in BL0 waiting for an address to be written at that memory location).
>>
>> Use the CPU id to decide whether we are running on EVT0 and use the
>> old location in that case.
> 
> Hi Angus,
> 
> Now this information is also required for other device drivers such as OneNAND.
> So can you make a generic function at common place such as plat-s5p?
> I mean we need a generic helper function for handling the EVT version
> at samsung platform.

Here's what I have in my current tree. I just added a s3c_get_chip_id()
helper, and used that in the secondary boot path. The same function
could be used for OneNAND and MCT.

Cheers,

	M.

-- 
Jazz is not dead. It just smells funny...
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-ARM-exynos4-fix-secondary-CPU-boot-on-early-SoC-revi.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110615/6ce337a7/attachment.txt>
