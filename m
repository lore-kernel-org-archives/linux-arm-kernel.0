From: rjui@broadcom.com (Ray Jui)
Date: Mon, 19 Jan 2015 11:15:41 -0800
Subject: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54BBA36A.10608@broadcom.com>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com> <20150118094741.GE22880@pengutronix.de>
 <20150118110658.GA1113@katana> <20150118111759.GG22880@pengutronix.de>
 <54BB9D2B.20408@broadcom.com> <20150118115650.GH22880@pengutronix.de>
 <54BBA36A.10608@broadcom.com>
Message-ID: <54BD57DD.9080002@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/18/2015 4:13 AM, Arend van Spriel wrote:
> On 01/18/15 12:56, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> On Sun, Jan 18, 2015 at 12:46:51PM +0100, Arend van Spriel wrote:
>>> On 01/18/15 12:17, Uwe Kleine-K?nig wrote:
>>>> Hello Wolfram,
>>>>
>>>> On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
>>>>> On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K?nig wrote:
>>>>>> On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
>>>>>>> On 01/17/15 00:42, Ray Jui wrote:
>>>>>>>> +    complete_all(&iproc_i2c->done);
>>>>>>>
>>>>>>> Looking over this code it seems to me there is always a single
>>>>>>> process waiting for iproc_i2c->done to complete. So using complete()
>>>>>>> here would suffice.
>>>>>> Yeah, there is always only a single thread waiting. That means both
>>>>>> complete and complete_all are suitable. AFAIK there is no reason
>>>>>> to pick
>>>>>> one over the other in this case.
>>>>>
>>>>> Clarity?
>>>> And which do you consider more clear? complete_all might result in the
>>>> question: "Is there>1 waiter?" and complete might yield to "What about
>>>> the other waiters?". If you already know there is only one, both are on
>>>> par on clarity. Might only be me?! I don't care much.
>>>
>>> Maybe it is me, but it is not about questions but it is about
>>> implicit statements that the code makes (or reader derives from it).
>>> When using complete_all you indicate to the reader "there can be
>>> more than one waiter". When using complete it indicates "there is
>>> only one waiter". If those statements are not true that is a code
>> No, complete works just fine in the presence of>1 waiter. It just wakes
>> a single waiter and all others continue to wait.
> 
> Yes. Agree.
> 
>> That is, for single-waiter situations there is no semantic difference
>> between complete and complete_all. But there is a difference for
>> multi-waiter queues.
> 
> Indeed.
> 
>> I think this is just a matter of your POV in the single-waiter
>> situation: complete might be intuitive because you just completed a
>> single task and complete_all might be intuitive because it signals
>> "I'm completely done, there is noone waiting for me any more.".
> 
> Ok. Let's leave it to the author's intuition or to say it differently
> "sorry for the noise" ;-)
Will stay with complete_all since I meant to say "after this transfer
complete interrupt, there should be no one waiting anymore (although
there's currently only one waiter, and will likely stay that way)"

Thanks!

> 
> Regards,
> Arend
> 
>> Best regards
>> Uwe
>>
> 
