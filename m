From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 20 Nov 2011 10:55:28 +0000
Subject: [PATCH] arm: Add condition code check to SWP emulator
In-Reply-To: <20111120084111.GM9581@n2100.arm.linux.org.uk>
References: <CAHkRjk6Ynfh9+UbTuAtyiXCOF-yDbTNxi0ikF5ttwHViisZRZA@mail.gmail.com>
 <1321751070-7932-1-git-send-email-stepanm@codeaurora.org>
 <20111120084111.GM9581@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk4QZxoVmCsB1A3DVb5_WCUvN5NfbYz8PNL_7np7+wHGzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2011 08:41, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Nov 19, 2011 at 05:04:30PM -0800, Stepan Moskovchenko wrote:
>> +static int check_condition(struct pt_regs *regs, unsigned int insn)
>> +{
>> + ? ? unsigned int base_cond, neg, cond = 0;
>> + ? ? unsigned int cpsr_z, cpsr_c, cpsr_n, cpsr_v;
>> +
>> + ? ? cpsr_n = (regs->ARM_cpsr & PSR_N_BIT) ? 1 : 0;
>> + ? ? cpsr_z = (regs->ARM_cpsr & PSR_Z_BIT) ? 1 : 0;
>> + ? ? cpsr_c = (regs->ARM_cpsr & PSR_C_BIT) ? 1 : 0;
>> + ? ? cpsr_v = (regs->ARM_cpsr & PSR_V_BIT) ? 1 : 0;
>> +
>> + ? ? /* Upper 3 bits indicate condition, lower bit incicates negation */
>> + ? ? base_cond = insn >> 29;
>> + ? ? neg = insn & BIT(28) ? 1 : 0;
>> +
>> + ? ? switch (base_cond) {
>> + ? ? case 0x0: ? ? ? /* equal */
>> + ? ? ? ? ? ? cond = cpsr_z;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x1: ? ? ? /* carry set */
>> + ? ? ? ? ? ? cond = cpsr_c;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x2: ? ? ? /* minus / negative */
>> + ? ? ? ? ? ? cond = cpsr_n;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x3: ? ? ? /* overflow */
>> + ? ? ? ? ? ? cond = cpsr_v;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x4: ? ? ? /* unsigned higher */
>> + ? ? ? ? ? ? cond = (cpsr_c == 1) && (cpsr_z == 0);
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x5: ? ? ? /* signed greater / equal */
>> + ? ? ? ? ? ? cond = (cpsr_n == cpsr_v);
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x6: ? ? ? /* signed greater */
>> + ? ? ? ? ? ? cond = (cpsr_z == 0) && (cpsr_n == cpsr_v);
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0x7: ? ? ? /* always */
>> + ? ? ? ? ? ? cond = 1;
>> + ? ? ? ? ? ? break;
>> + ? ? };
>> +
>> + ? ? return cond && !neg;
>
> There's a much better algorithm to check this. ?See the bottom of
> arch/arm/nwfpe/fpopcode.c.
>
> It would probably be best for there to be a common function for doing
> this kind of check, rather than having several implementations of it
> scattered around the kernel.

That's what Leif started doing.

-- 
Catalin
