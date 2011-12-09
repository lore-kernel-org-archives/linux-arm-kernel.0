From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 9 Dec 2011 18:34:07 +0530
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4EE1F7F0.70107@arm.com>
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
Message-ID: <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javi,

On 9 December 2011 17:28, Javi Merino <javi.merino@arm.com> wrote:
>
>>>>> Javi, could you please check if you too get the memcpy failure with
>>>>> dmatest ?
>>>>
>> Ok, I think I've just reproduced it in my end with the kernel's dmatest
>> module. ?After the first transaction it looks like the dma test wasn't
>> able to issue any more transactions. ?I'll have a look at it tomorrow
>> and try to answer my own questions ;)
>
> The problem is that pl330_submit_req() always puts the request in buffer 0 if
> both buffers are free.
>
There should be nothing wrong in that.
It is but natural to prefer 0 if both 0 and 1 are available.

> If you submit a transaction, it finishes and there's nothing else to run,
> pl330_update() calls _start() but there is nothing to send. ?This is all
> right. ?Then, if another transaction is submitted, pl330_submit_req() will
> put it in buffer 0 again. ?This time, the PC of the DMA is in the last
> instruction of buffer 0 (the DMAEND of the *previous* transaction that
> finished long ago) so _thrd_active() thinks that this buffer is active,
>
Many thanks for the in-depth analysis.

Though before the PC check, the IS_FREE() should return true since
pl330_update() does MARK_FREE()

Could you please check if the client's callback function called
successfully for the
first submitted transfer ?

Then we can decide upon one of the following 2 options (I *think*
either should fix the issue)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 97912fa..f550d46 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -846,7 +846,7 @@ static inline bool _req_active(struct pl330_thread *thrd,
 	if (IS_FREE(req))
 		return false;

-	return (pc >= buf && pc <= buf + req->mc_len) ? true : false;
+	return (pc >= buf && pc < buf + req->mc_len) ? true : false;
 }

--OR--

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 97912fa..ad85a75 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -233,7 +233,7 @@
 			} while (0)

 /* If the _pl330_req is available to the client */
-#define IS_FREE(req)	(*((u8 *)((req)->mc_cpu)) == CMD_DMAEND)
+#define IS_FREE(req)	((req)->mc_len == 0)

 /* Use this _only_ to wait on transient states */
 #define UNTIL(t, s)	while (!(_state(t) & (s))) cpu_relax();


Thanks.
