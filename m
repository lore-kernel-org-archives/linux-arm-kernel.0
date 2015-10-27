From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 27 Oct 2015 17:57:46 -0300
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151027202124.GK4931@pengutronix.de>
References: <20151026012710.GA17365@laptop>
 <20151027202124.GK4931@pengutronix.de>
Message-ID: <CAAEAJfBOcxwq=L2aq5=KYedN=gs=gM6rupUWS9bPceEDCZniSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 17:21, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Ezequiel,
>
> On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
>> I've been trying to make my ARM v7-M LPC43xx board
>> boot a XIP kernel from flash. Currently, this seems
>> to be broken in mainline due to this:
>>
>> arch/arm/mm/proc-v7m.S
>> [..]
>>         @ SVC to run the kernel in this mode
>>         badr    r1, 1f
>>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
>>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
>>         mov     r6, lr                  @ save LR
>>         mov     r7, sp                  @ save SP
>>       ldr     sp, =__v7m_setup_stack_top @ <<< Breaks XIP!
>
> How does this fail for you?
>

My CPU just seems to stall.
I've added calls to the printch in arch/arm/kernel/debug.S
and can't get past the SVC call.

As Stefan suggested, maybe a fault handler is called,
but I'm not getting any fault message printed.

>>         cpsie   i
>>         svc     #0
>> 1:      cpsid   i
>>         str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
>>         mov     lr, r6                  @ restore LR
>>         mov     sp, r7                  @ restore SP
>>
>> Here, a temporary stack is prepared before making a
>> supervisor call (SVC) to switch to handler mode.
>
> OK, the effect of svc is that something is written to where sp points
> to. On my efm32 nothing obvious happens when something random is written
> there. I guess if that results in some CFI commands I have a problem
> though. What about your machine?
>

Good, I was under the same impression. My only explanation for the fact
that Maxime and you seem to have no problem was that a store
to the internal flash doesn't stall the MCU.

On my side, I have U-Boot and the DTB on the internal flash,
and the kernel is on SPIFI, which can be configured to allow
code execution.

Haven't checked what the effect is if you try to write there.
In any case, it seems wrong to have the stack point to flash.

>> The temporary stack is allocated in the .text.init section
>> and so this doesn't work when the kernel is executing from ROM.
>>
>> A similar problem has been reported for v7:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357106.html
>>
>> While trying to come up with a proper fix, I've noticed how
>> the stack doesn't seem to be used.
>>
>> So, I've been trying to understand why the need for the temporary
>> stack at all, but I still can't get it.
>>
>> The below patch seems to work just fine, and allows to boot a
>> LPC43xx kernel either as XIP from ROM or non-XIP from RAM.
>>
>> However, I'm still wondering if the stack is really unused or not,
>> so any lights that can be shed here will be appreciated.
>>
>> Thanks!
>>
>> From a7c880c73b8ad2e4c4b07f4d11809ea541a65e1d Mon Sep 17 00:00:00 2001
>> From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> Date: Sat, 24 Oct 2015 13:27:27 -0300
>> Subject: [PATCH] ARM: Don't prepare any temporary stack in __v7m_setup
>>
>> Since __v7m_setup() is implemented as the PROCINFO_INITFUNC
>> called in head-nommu.S it's called at the very beggining to
>> do some very basic setup.
>>
>> The function prepares a temporary stack in the .text.init
>> section before calling SVC. However, this stack seems to
>> be completely unused and hence is not needed.
>>
>> Moreover, this breaks on XIP kernels, when the text is in ROM.
>> Hence, this commit simply removes the temporary stack setup.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>  arch/arm/mm/proc-v7m.S | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
>> index 67d9209077c6..6a383e619a0c 100644
>> --- a/arch/arm/mm/proc-v7m.S
>> +++ b/arch/arm/mm/proc-v7m.S
>> @@ -103,7 +103,6 @@ __v7m_setup:
>>       str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
>>       mov     r6, lr                  @ save LR
>>       mov     r7, sp                  @ save SP
>> -     ldr     sp, =__v7m_setup_stack_top
>>       cpsie   i
>>       svc     #0
>>  1:   cpsid   i
>> @@ -123,11 +122,6 @@ __v7m_setup:
>>       ret     lr
>>  ENDPROC(__v7m_setup)
>>
>> -     .align 2
>> -__v7m_setup_stack:
>> -     .space  4 * 8                           @ 8 registers
>> -__v7m_setup_stack_top:
>> -
>
> The effect of your patch is that the value of sp as it is when
> __v7m_setup is entered is used. I didn't check, but I wouldn't be
> surprised if that's the value of sp when the boot loader gave control to
> Linux. This might or might not work. Something more robust would be
> better of course.
>

Well, this is where I'm a bit lost, as I was unable to find where
the stack is setup in Linux.

But on the other side, the current code, just sets a *temporary*
stack to fit the 8 registers needed for the SVC call. The stack
pointer is restored right after that.

So in reality, the effect of the patch above is to require some
additional space for the already in-use stack.

I can't see why it wouldn't be robust.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
