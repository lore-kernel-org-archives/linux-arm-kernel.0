From: javi.merino@arm.com (Javi Merino)
Date: Fri, 9 Dec 2011 13:41:05 +0000
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
References: <4E8C5425.80303@arm.com>	<1317892206-3600-1-git-send-email-javi.merino@arm.com>	<CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>	<4EB7B79A.2020004@arm.com>	<000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>	<4ED3B89E.7070903@arm.com>	<000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>	<4ED4AB9A.3060807@arm.com>	<CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>	<03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>	<4EDF3989.3060108@arm.com>	<4EDFD278.9090101@arm.com>	<4EE1F7F0.70107@arm.com>
 <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
Message-ID: <4EE20FF1.5070702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/11 13:04, Jassi Brar wrote:
> Hi Javi,
>
> On 9 December 2011 17:28, Javi Merino <javi.merino@arm.com> wrote:
>>
>>>>>> Javi, could you please check if you too get the memcpy failure with
>>>>>> dmatest ?
>>>>>
>>> Ok, I think I've just reproduced it in my end with the kernel's dmatest
>>> module.  After the first transaction it looks like the dma test wasn't
>>> able to issue any more transactions.
>>>
>> If you submit a transaction, it finishes and there's nothing else to run,
>> pl330_update() calls _start() but there is nothing to send.  This is all
>> right.  Then, if another transaction is submitted, pl330_submit_req() will
>> put it in buffer 0 again.  This time, the PC of the DMA is in the last
>> instruction of buffer 0 (the DMAEND of the *previous* transaction that
>> finished long ago) so _thrd_active() thinks that this buffer is active,
>>
> Many thanks for the in-depth analysis.
>
> Though before the PC check, the IS_FREE() should return true since
> pl330_update() does MARK_FREE()
>
> Could you please check if the client's callback function called
> successfully for the
> first submitted transfer ?

Yes, it calls MARK_FREE() and indeed in pl330_update(), _thrd_active()
returns 0.  The problem comes when, afterwards, pl330_submit_req()
introduces a new request and chooses the same buffer. Then, IS_FREE()
returns false (obviously) but the PC of the DMA is at the end of the
buffer, so _thrd_active() claims that it is active so pl330_chan_ctrl()
doesn't start it.

> Then we can decide upon one of the following 2 options (I *think*
> either should fix the issue)
>
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 97912fa..f550d46 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -846,7 +846,7 @@ static inline bool _req_active(struct pl330_thread *thrd,
>       if (IS_FREE(req))
>               return false;
>
> -     return (pc >= buf && pc <= buf + req->mc_len) ? true : false;
> +     return (pc >= buf && pc < buf + req->mc_len) ? true : false;
>  }

This reintroduces the race condition.  The DMA thread finishes and sends
the IRQ just after pl330_chan_ctrl() disables interrupts.  With this
patch, _thrd_active() returns false and _start() reissues the
just-finished transaction.

> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 97912fa..ad85a75 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -233,7 +233,7 @@
>                       } while (0)
>
>  /* If the _pl330_req is available to the client */
> -#define IS_FREE(req) (*((u8 *)((req)->mc_cpu)) == CMD_DMAEND)
> +#define IS_FREE(req) ((req)->mc_len == 0)

No, this doesn't fix it.  pl330_submit_req() introduces a valid request,
IS_FREE() returns false as it should.  The problem is that the DMA pc is
pointing at buf + req->mc_len .

>> The problem is that pl330_submit_req() always puts the request in buffer 0 if
>> > both buffers are free.
>> >
> There should be nothing wrong in that.
> It is but natural to prefer 0 if both 0 and 1 are available.

On second thoughts, with the solution I proposed in the previous email
the DMA will freeze if you call pl330_submit_req() twice before calling
pl330_chan_ctrl().  Can that happen?  I'd assume that each call to
pl330_submit_req() is always followed by a pl330_chan_ctrl(PL330_OP_START)

Another way of solving this would be to revert
ee3f615819404a9438b2dd01b7a39f276d2737f2 and go back to my original
patch (in the beginning of this thread):

http://article.gmane.org/gmane.linux.ports.arm.kernel/133110

Cheers,
Javi

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
