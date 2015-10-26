From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 26 Oct 2015 10:12:55 -0300
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151026080537.GW4931@pengutronix.de>
References: <20151026012710.GA17365@laptop>
 <20151026080537.GW4931@pengutronix.de>
Message-ID: <CAAEAJfB0yywtQ2MrYf2ih5+a3fZJXAy0hFSXWA038wQMQswa7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2015 at 05:05, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
>> I've been trying to make my ARM v7-M LPC43xx board
>> boot a XIP kernel from flash. Currently, this seems
>
> I admit I didn't update my efm32 machine for quite some time, but this
> can only boot with XIP.
>

Executing directly from read-only memory? Hmm, that's odd.

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
> If you make the tab above 8 spaces the line will align in the git
> commit, too.
> Hmm, this line is there from the beginning (i.e. 55bdd6941165 ("ARM: Add
> base support for ARMv7-M")).
>

Yes, I know. And was there in Catalin's first patches, hence why I'm asking :-)

>>         cpsie   i
>>         svc     #0
>> 1:      cpsid   i
>>         str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
>>         mov     lr, r6                  @ restore LR
>>         mov     sp, r7                  @ restore SP
>>
>> Here, a temporary stack is prepared before making a
>> supervisor call (SVC) to switch to handler mode.
>>
>> The temporary stack is allocated in the .text.init section
>> and so this doesn't work when the kernel is executing from ROM.
>
> If sp isn't used, how does it break you setup?

Well, the supervisor call uses the stack, but not the Linux code.
>From the Application Note 179:

""
2.7. Supervisor Calls (SVC)
[..]
On the Cortex-M3, the core saves the argument registers to the stack
on the initial exception entry.
A late-arriving exception, taken before the first instruction of the
SVC handler executes,
might corrupt the copy of the arguments still held in R0 to R3. This
means that the stack copy
of the arguments must be used by the SVC handler
""

> Did you try to put a watchpoint to the location in question?
>

Sort of. I used a low level assembly call to printuart and followed
the execution
to that instruction. The CPU never seems to get pass the supervisor call.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
