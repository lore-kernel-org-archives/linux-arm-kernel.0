From: james.morse@arm.com (James Morse)
Date: Wed, 17 Feb 2016 10:10:00 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C43A23.1020301@virtuozzo.com>
References: <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
 <CAKv+Gu8WE=fTZF0Pou24FKDocgshWu8dJRbaC5SJ11E-6T=2Hw@mail.gmail.com>
 <56C34204.60605@virtuozzo.com> <20160216164245.GC8022@leverpostej>
 <56C43A23.1020301@virtuozzo.com>
Message-ID: <56C446F8.3050906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/16 09:15, Andrey Ryabinin wrote:
> On 02/16/2016 07:42 PM, Mark Rutland wrote:
>> On Tue, Feb 16, 2016 at 06:36:36PM +0300, Andrey Ryabinin wrote:
>>> You are right. 
>>> So we should write 'shadow_start' instead of 'i'.
>>
>> FWIW with the below patch I don't see any "screwed shadow mapping"
>> warnings on my board, and still later see a tonne of KASAN splats in the
>> scheduler.
>>
> 
> It is possible that I missed something, but I think it means that shadow is alright.
> 
> I wonder whether this happens on 4.4. If not, than something in 4.5-rc1 caused this, and the obvious suspect
> here is irq stack.

This quick hack will prevent ever switching to the irq stack:

---------------------------%<---------------------------
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1f7f5a2b61bf..83ae736429b6 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -188,7 +188,7 @@ alternative_endif
         */
        and     x25, x19, #~(THREAD_SIZE - 1)
        cmp     x25, tsk
-       b.ne    9998f
+       b       9998f

        this_cpu_ptr irq_stack, x25, x26
        mov     x26, #IRQ_STACK_START_SP
---------------------------%<---------------------------


James
