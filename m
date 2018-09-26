From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Wed, 26 Sep 2018 15:22:59 +0530
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <CAJWu+orL63-qfDL7B_Fs_Vx_rUr4fwn+DXK1mosmyM4jhj_BSw@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
 <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
 <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
 <CAJWu+oorTRschpgLODgVv50S57U6Su9SM57WVrVKiQBSXEVC9w@mail.gmail.com>
 <CAJWu+orL63-qfDL7B_Fs_Vx_rUr4fwn+DXK1mosmyM4jhj_BSw@mail.gmail.com>
Message-ID: <67f42dd8-31e3-99fa-06b7-bd9f860ccef8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/2018 2:10 AM, Joel Fernandes wrote:
> On Tue, Sep 25, 2018 at 1:39 PM, Joel Fernandes <joelaf@google.com> wrote:
>> On Tue, Sep 25, 2018 at 1:37 PM, Joel Fernandes <joelaf@google.com> wrote:
>>> On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>>>>
>>>>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>>>>
>>>>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>>>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> +
>>>>>>> +       trace_seq_init(&iter->seq);
>>>>>>> +       iter->ent = fbuffer->entry;
>>>>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>>>>> +       trace_seq_putc(&iter->seq, 0);
>>>>>>
>>>>>>
>>>>>> Would it be possible to store the binary trace record in the pstore
>>>>>> buffer instead of outputting text? I suspect that will both be faster
>>>>>> and less space.
>>>>>>
>>>>>
>>>>> I will try this and come back.
>>>>>
>>>>
>>>> Hi Joel,
>>>>
>>>> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>>>>
>>>> # dd if=/dev/zero of=/dev/null status=progress
>>>> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
>>>> 24171926+0 records in
>>>> 24171926+0 records out
>>>> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>>>>
>>>> This seems good when compared to 190 MB/s seen previously.
>>>> If this is Ok, then I will spin v2 with changes suggested.
>>>
>>> Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.
>>>
>>
>> Well so I think you should still not use spinlock to synchronize and
>> split the buffer. You could expand pstore_record to have a ts field or
>> introduce a new API like ->write_percpu instead of write, or
>> something. But I strongly feel you should lock. For ftrace function
> 
> Aargh, I meant you should *not* lock :-)
> 

OK I can try this and will measure some perf difference.

BTW I guess you missed my previous comment about not able to combine 
logs based on timestamp? Anyways I think if I add some extra ts field, 
then should be able to do it.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
