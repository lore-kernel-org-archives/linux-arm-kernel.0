From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 9 Dec 2011 19:45:34 +0530
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4EE20FF1.5070702@arm.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com>
 <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
 <4ED3B89E.7070903@arm.com>
 <000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>
 <4ED4AB9A.3060807@arm.com>
 <CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>
 <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>
 <4EDF3989.3060108@arm.com> <4EDFD278.9090101@arm.com>
 <4EE1F7F0.70107@arm.com>
 <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
 <4EE20FF1.5070702@arm.com>
Message-ID: <CABb+yY0f8xxAj+rFeZ4e61Sfk0+0bMsAiZ-H5AeY4cfCd_VE5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 7:11 PM, Javi Merino <javi.merino@arm.com> wrote:
> On 09/12/11 13:04, Jassi Brar wrote:
>> Hi Javi,
>>
>> On 9 December 2011 17:28, Javi Merino <javi.merino@arm.com> wrote:
>>>
>>>>>>> Javi, could you please check if you too get the memcpy failure with
>>>>>>> dmatest ?
>>>>>>
>>>> Ok, I think I've just reproduced it in my end with the kernel's dmatest
>>>> module. ?After the first transaction it looks like the dma test wasn't
>>>> able to issue any more transactions.
>>>>
>>> If you submit a transaction, it finishes and there's nothing else to run,
>>> pl330_update() calls _start() but there is nothing to send. ?This is all
>>> right. ?Then, if another transaction is submitted, pl330_submit_req() will
>>> put it in buffer 0 again. ?This time, the PC of the DMA is in the last
>>> instruction of buffer 0 (the DMAEND of the *previous* transaction that
>>> finished long ago) so _thrd_active() thinks that this buffer is active,
>>>
>> Many thanks for the in-depth analysis.
>>
>> Though before the PC check, the IS_FREE() should return true since
>> pl330_update() does MARK_FREE()
>>
>> Could you please check if the client's callback function called
>> successfully for the
>> first submitted transfer ?
>
> Yes, it calls MARK_FREE() and indeed in pl330_update(), _thrd_active()
> returns 0. ?The problem comes when, afterwards, pl330_submit_req()
> introduces a new request and chooses the same buffer. Then, IS_FREE()
> returns false (obviously) but the PC of the DMA is at the end of the
> buffer, so _thrd_active() claims that it is active so pl330_chan_ctrl()
> doesn't start it.
>
OK, I see what you mean.
We need to be able to differentiate between 'programmed' state
and 'running' state.
So instead of employing  _state() or another marker, we'd rather
alternate between buff 0 & 1 as a workaround.

That is, I am ok with your following fix.

-       idx = IS_FREE(&thrd->req[0]) ? 0 : 1;
+       idx = IS_FREE(&thrd->req[1 - thrd->lstenq]) ? 1 - thrd->lstenq
: thrd->lstenq;

Thanks.
