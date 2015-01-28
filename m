From: behanw@converseincode.com (Behan Webster)
Date: Wed, 28 Jan 2015 14:47:36 -0800
Subject: [PATCH] ARM: teach __asmeq that r12 and ip are the same register
In-Reply-To: <CAKv+Gu_zXwLdREs1NogW4GaoYiXQz-d4HqJ6KsEPV0q-gPrVTQ@mail.gmail.com>
References: <1422480618-25371-1-git-send-email-ard.biesheuvel@linaro.org>	<alpine.LFD.2.11.1501281636170.1322@knanqh.ubzr>
 <CAKv+Gu_zXwLdREs1NogW4GaoYiXQz-d4HqJ6KsEPV0q-gPrVTQ@mail.gmail.com>
Message-ID: <54C96708.6080300@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/15 14:00, Ard Biesheuvel wrote:
> On 28 January 2015 at 21:46, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Wed, 28 Jan 2015, Ard Biesheuvel wrote:
>>
>>> The __asmeq macro is used inside inline asm statements to ensure that
>>> register asm variables that explicitly specify a register are mapped
>>> correctly onto those registers when used in inline asm input and output
>>> constraints. However, the string based matching fails to take into account
>>> that 'ip' may also be referred to as 'r12', (e.g., by clang), causing false
>>> negatives.
>>>
>>> Fix this by making __asmeq consider the ("ip","r12") and ("r12","ip")
>>> cases specifically.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> gcc is likely to do the same substitution with r10 ("sl") and r11
>> ("fp").  Might as well add them right away for completeness.
>>
> I just checked with my 4.8 gcc toolchain: r11 indeed gets emitted as
> fp when used in inline asm, but r10 is just r10.
> So I should update the patch to include fp as well.
>
>> Then, does clang call sp, lr, pc as r13, r14 and r15? I guess not as
>> this is probably against the latest ARM assembly conventions.
>>
> @Behan, could you answer this one?
These are aliased in clang as one would expect.

Behan

-- 
Behan Webster
behanw at converseincode.com
