From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 17 Jul 2018 09:18:14 -0700
Subject: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
In-Reply-To: <a84da5d076924f40b1c836fe8b9d0844@TWMBX01.aspeed.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
 <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
 <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com>
 <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
 <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
 <b8232faa-58f5-f3a5-d12a-3f326cf1d03d@linux.intel.com>
 <a84da5d076924f40b1c836fe8b9d0844@TWMBX01.aspeed.com>
Message-ID: <26400cb7-972e-7be9-81ba-8e08d42abd4e@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 7/15/2018 8:05 PM, Gary Hsu wrote:
> Hi Jae,
> 
> In originally, we reserved these register bits for debug purpose. But for some error handling case, we found it is also useful to help to clarify some error conditions. So driver also can use these fields information to check something.
> As for how driver use these information in their code, I have no comment. I don?t understand the driver. But these information is the real controller state, it had no problem to use information.
> 

Thanks Gary!

Hi Brendan,
Is it acceptable now if I add this as a comment like below?

Thanks,
Jae

> Best Regards,
> 
> ??? Gary Hsu
> 
> ??????????
> ASPEED Technology Inc.
> 
> 2F,No.15,Industry East Road 4.,Hsinchu Science Park, Hsinchu City 30077, Taiwan
> ??????????? 15 ? 2F
> 
> Tel : 886-3-5789568 ext:807
> Fax : 886-3-5789586
> Web : http://www.aspeedtech.com
> 
> ************* Email Confidentiality Notice ********************
> ????:
> ???????????,???(????)????????????????? ???????????????????????????, ??????????????????????????????!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
> 
> -----Original Message-----
> From: Jae Hyun Yoo [mailto:jae.hyun.yoo at linux.intel.com]
> Sent: Saturday, July 14, 2018 2:54 AM
> To: Brendan Higgins <brendanhiggins@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; linux-i2c at vger.kernel.org; OpenBMC Maillist <openbmc@lists.ozlabs.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; james.feist at linux.intel.com; vernon.mauery at linux.intel.com; Benjamin Fair <benjaminfair@google.com>; Patrick Venture <venture@google.com>; Gary Hsu <gary_hsu@aspeedtech.com>; Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use cases stably
> 
> On 7/13/2018 11:12 AM, Brendan Higgins wrote:
>> On Fri, Jul 13, 2018 at 10:22 AM Jae Hyun Yoo
>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> On 7/12/2018 11:21 AM, Jae Hyun Yoo wrote:
>>>> On 7/12/2018 2:33 AM, Brendan Higgins wrote:
>>>>> On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
>>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>> <snip>
>>>>> <snip>
>>>>>>>> +       for (;;) {
>>>>>>>> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>>>>>>>> +                     (ASPEED_I2CD_BUS_BUSY_STS |
>>>>>>>> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
>>>>>>>
>>>>>>> Is using the Transfer Mode State Machine bits necessary? The
>>>>>>> documentation marks it as "for debugging purpose only," so
>>>>>>> relying on it makes me nervous.
>>>>>>>
>>>>>>
>>>>>> As you said, the documentation marks it as "for debugging purpose only."
>>>>>> but ASPEED also uses this way in their SDK code because it's the
>>>>>> best way for checking bus busy status which can cover both single
>>>>>> and multi-master use cases.
>>>>>>
>>>>>
>>>>> Well, it would also be really nice to have access to this bit if
>>>>> someone wants to implement MCTP. Could we maybe check with Aspeed
>>>>> what them meant by "for debugging purposes only" and document it
>>>>> here? It makes me nervous to rely on debugging functionality for
>>>>> normal usage.
>>>>>
>>>>
>>>> Okay, I'll check it with Aspeed. Will let you know their response.
>>>>
>>>
>>> I've checked it with Gary Hsu <gary_hsu@aspeedtech.com> and he
>>> confirmed that the bits reflect real information and good to be used
>>> in practical code.
>>
>> Huh. For my own edification, could you ask them why they said "for
>> debugging purpose only" in the documentation? I am just really curious
>> what they meant by that. I would be satisfied if you just CC'ed me on
>> your email thread with Gary, and I can ask him myself.
>>
> 
> I've already CC'ed Gary and Ryan in this thread.
> 
> Hi Gary,
> 
> Can you explain why the documentation says that the bit field is 'for debugging purpose only'? Any plan to change the description?
> 
> Thanks,
> 
> Jae
> 
>>>
>>> I'll add a comment like below:
>>>
>>> /*
>>>     * This is marked as 'for debugging purpose only' in datasheet but
>>>     * ASPEED confirmed that this reflects real information and good
>>>     * to be used in practical code.
>>>     */
>>>
>>> Is it acceptable then?
>>
>> Yeah, that's fine.
>>
>> <snip>
>>
>> Cheers
>>
