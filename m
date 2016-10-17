From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 10:30:02 +0200
Subject: [PATCH] RFC: ARM: fix the uaccess crash on PB11MPCore
In-Reply-To: <CACRpkdYJjxVsUsFUHxhy5dgjkCvYRHFRfqJwyireysMRbrLwRg@mail.gmail.com>
References: <1468256893-12811-1-git-send-email-linus.walleij@linaro.org>
 <78f8cd15-6cde-0493-e429-43d047dd58f7@baylibre.com>
 <CACRpkdYJjxVsUsFUHxhy5dgjkCvYRHFRfqJwyireysMRbrLwRg@mail.gmail.com>
Message-ID: <dd63a9f1-ed63-14c4-d47c-ceb43c76830f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2016 03:36 PM, Linus Walleij wrote:
> On Fri, Sep 9, 2016 at 9:57 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 07/11/2016 07:08 PM, Linus Walleij wrote:
> 
>>> The following patch was sketched by Russell in response to my
>>> crashes on the PB11MPCore after the patch for software-based
>>> priviledged no access support for ARMv8.1. See this thread:
>>> http://marc.info/?l=linux-arm-kernel&m=144051749807214&w=2
>>>
>>> I am unsure what is going on, I suspect everyone involved in
>>> the discussion is. I just want to repost this to get the
>>> discussion restarted, as I still have to apply this patch
>>> with every kernel iteration to get my PB11MPCore Realview
>>> running.
>>>
>>> I also know that Oxnas has actual, mass-deployed NAS (PogoPlug
>>> Pro variants) using PB11MPCore, and that they may or may not
>>> be seeing the same issue so I want their feedback on this: do
>>> you or do you not see this with mainline, or have you not even
>>> tested?
>>>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Fixes: a5e090acbf54 ("ARM: software-based priviledged-no-access support")
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>  arch/arm/kernel/smp_tlb.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>
>> Hi Linus, Russell, Arnd,
>>
>> I made a quick port ox OX820 over v4.8-rc4 and when enabling CONFIG_CPU_SW_DOMAIN_PAN
>> I get the following trace at boot time :
>> [    1.690000] Unable to handle kernel paging request at virtual address b6f23684
>> [    1.690000] Unable to handle kernel paging request at virtual address b6f95ef4
>> [    1.690000] pgd = c281c000
>> [    1.690000] [b6f95ef4] *pgd=62821831, *pte=00000000, *ppte=00000000
>> [    1.690000] Internal error: Oops: 81f [#1] SMP ARM
>> [    1.690000] Modules linked in:
>> [    1.690000] CPU: 1 PID: 65 Comm: mount Not tainted 4.8.0-rc4-00001-g0e9c45d-dirty #22
>> [    1.690000] Hardware name: Generic DT based system
>> [    1.690000] task: c2aad860 task.stack: c2814000
>> [    1.690000] PC is at ipi_flush_tlb_page+0x34/0x44
>> [    1.690000] LR is at on_each_cpu_mask+0x58/0x60
>> [    1.690000] pc : [<c010d3dc>]    lr : [<c017d584>]    psr: 20000193
>> [    1.690000] sp : c2815da0  ip : 00000002  fp : 00067c40
>> [    1.690000] r10: c0702744  r9 : 67c4079f  r8 : 67c9e75f
>> [    1.690000] r7 : c2815dbc  r6 : c010d3a8  r5 : c2816164  r4 : 20000113
>> [    1.690000] r3 : 00000000  r2 : b6f95003  r1 : 00000003  r0 : 00000003
>> [    1.690000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [    1.690000] Control: 00c5787d  Table: 6281c00a  DAC: 00000051
>> [    1.690000] Process mount (pid: 65, stack limit = 0xc2814190)
>> [    1.690000] Stack: (0xc2815da0 to 0xc2816000)
>> [...]
>> [    1.690000] ---[ end trace 8f1207a6d611da09 ]---
>>
>> When applying this patch, it solved the issue.
>>
>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> So this problem appears on all ARM11MPcore, not just the RealView.
> 
> Yours,
> Linus Walleij
> 

Hi Russell,

Is there a plan to push this fix as it appears to break the Realview platform and the OX820 I am currently pushing ?

Thanks,
Neil
