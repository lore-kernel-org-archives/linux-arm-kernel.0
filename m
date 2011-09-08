From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Sep 2011 10:03:52 -0700
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <201109081845.58260.arnd@arndb.de>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-3-git-send-email-dave.martin@linaro.org>
	<201109081845.58260.arnd@arndb.de>
Message-ID: <CAMPhdO82ho2WPrJ3irwLgfPOycQt=kyqK3hhtrLCjOw1vptTrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 9:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 08 September 2011, Dave Martin wrote:
>> The iwmmxt code contains some code to implement a pseudo-ISB, but
>> this is not buildable for Thumb-2.
>>
>> This patch replaces the pseudo-ISB with a real one for Thumb-2
>> kernels.
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> ---
>> ?arch/arm/kernel/iwmmxt.S | ? ?9 +++++++++
>> ?1 files changed, 9 insertions(+), 0 deletions(-)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Maybe it'll be much simpler to have something like below:

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a087838..5998f7d 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -319,8 +319,9 @@ ENTRY(iwmmxt_task_switch)
        PJ4(eor r1, r1, #0xf)
        PJ4(mcr p15, 0, r1, c1, c0, 2)

-       mrc     p15, 0, r1, c2, c0, 0
-       sub     pc, lr, r1, lsr #32             @ cpwait and return
+       XSC(mrc p15, 0, r1, c2, c0, 0)
+       PJ4(isb)
+       mov     pc, lr                          @ cpwait and return

 /*
  * Remove Concan ownership of given task
