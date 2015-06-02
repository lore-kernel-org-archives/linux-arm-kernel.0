From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Tue, 2 Jun 2015 17:21:11 +0200
Subject: [PATCH v2] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <20150602145254.GE2067@n2100.arm.linux.org.uk>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <1432821287-31436-1-git-send-email-michael@smart-africa.com>
 <CACRpkdY4sZQr+VzMKzU2Rtm7sP2zMztBioCPQRJjq=VjyapAEA@mail.gmail.com>
 <20150602145254.GE2067@n2100.arm.linux.org.uk>
Message-ID: <E0CBFB71-15B1-4C83-8B97-AF1C5CA48B98@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 02 Jun 2015, at 4:52 PM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> On Tue, Jun 02, 2015 at 01:16:38PM +0200, Linus Walleij wrote:
>>> +static int __init tcm_handler(struct pt_regs *regs, unsigned int instr)
>>> +{
>>> +       regs->uregs[(instr >> 12) & 0xf] = 0;
>>> +       regs->ARM_pc += 4;
>>> +       return 0;
>>> +}
>> 
>> Is the action here totally obvious to everyone except me?
>> I guess it is masking off something and advancing past a
>> failed instruction but whatdoIknow. Can you put in a small comment
>> above the function or something?
> 
> I know what it's doing :)
> 
> It's storing '0' into the destination register of the faulted MRC
> instruction, and advancing past the instruction.  So, an undef fault
> on either:
> 
> 	mrc	15, 0, rX, cr9, cr1, {0}
> 	mrc	15, 0, rX, cr9, cr1, {1}
> 
> causes them to return zero.

It?s almost depressing how quickly you grokked that!

I?ve addressed the comments from Linus is a v3 patch that crossed this mail in-flight.

Given your explanation I now fear I may have over-documented!

Michael
