From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 20 Nov 2017 10:27:44 -0500
Subject: [PATCH v3][for 4.15] dmaengine: dmatest: move callback wait queue
 to thread context
In-Reply-To: <CAPcyv4gw3++W0DG=84ansCjJAop_KZSXXinY7eDEsWQ4quhXCQ@mail.gmail.com>
References: <1510927894-15297-1-git-send-email-awallis@codeaurora.org>
 <CAPcyv4hF=LjEdhPvD3TNWa4+XfN83NCuW2Lv7ERwo4ChFSyTbg@mail.gmail.com>
 <7637068c-4079-1235-cd6b-777907a42e8b@codeaurora.org>
 <CAPcyv4h2O7+nbxu2fyBNtcrisCntqRtFxAzDgP-7D9iAyGJSKw@mail.gmail.com>
 <79ea89ca-d8b6-0bfc-7bb5-053dcf5c40e4@codeaurora.org>
 <89ac9914-f1a9-3857-585e-1882668e839b@codeaurora.org>
 <CAPcyv4gw3++W0DG=84ansCjJAop_KZSXXinY7eDEsWQ4quhXCQ@mail.gmail.com>
Message-ID: <d59802cd-8bf2-8ad8-a9aa-6117b433746b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2017 12:33 PM, Dan Williams wrote:
> On Fri, Nov 17, 2017 at 9:28 AM, Adam Wallis <awallis@codeaurora.org> wrote:
>> On 11/17/2017 12:01 PM, Adam Wallis wrote:
> [..]
>>> Dan
>>> An important part of my patch was severed in this v3 submission. My apologies.
>>>
>>> There is a change that addresses, I believe, your concern that was in v2
>>>
>>>       /* terminate all transfers on specified channels */
>>> -     if (ret)
>>> +     if (ret || failed_tests)
>>>               dmaengine_terminate_all(chan);
>>>
>>> Will clean up again, retest, and resubmit. Thanks for your patience and instruction.
>>
>> Dan, I thought the patch was truncated, but it's all there in V3. I should have
>> finished my coffee before responding. You are absolutely right that in the timed
>> out case that dmaengine_terminate_all(chan) should be called, and that change is
>> in fact already included in this patch set
>>
>> @@ -789,7 +782,7 @@ static int dmatest_func(void *data)
>>                 dmatest_KBs(runtime, total_len), ret);
>>
>>         /* terminate all transfers on specified channels */
>> -       if (ret)
>> +       if (ret || failed_tests)
>>                 dmaengine_terminate_all(chan);
>>
>> Would you prefer that I add a better description in the commit text to address
>> the fact this was in fact added?
> 
> Ah, sorry I overlooked that.
> 
> What about the case where the dmaengine does not support the
> terminate_all operation? I think we should WARN in that case, but
> that's also where the per-operation allocation of a done variable can
> prevent done notifications leaking between operations.
> 

Dan, thanks for your comments. I just released v4 of this patch. Let me know if
I misunderstood what you said above. I do acknowledge that container_of might be
less desirable than just changing the argument that we pass to the callback.
Open to your suggestions!

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
