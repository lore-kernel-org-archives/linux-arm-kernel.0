From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 30 Mar 2015 17:54:29 +0900
Subject: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
In-Reply-To: <20150330081613.60ff7dc0@arm.com>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>	<20150327153131.GK12400@redacted.bos.redhat.com>	<55157920.3050003@arm.com>	<20150327174044.GL12400@redacted.bos.redhat.com>	<5518A969.3090707@linaro.org>
 <20150330081613.60ff7dc0@arm.com>
Message-ID: <55190F45.1070803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2015 04:16 PM, Marc Zyngier wrote:
> On Mon, 30 Mar 2015 02:39:53 +0100
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>
>> On 03/28/2015 02:40 AM, Kyle McMartin wrote:
>>> On Fri, Mar 27, 2015 at 03:37:04PM +0000, Marc Zyngier wrote:
>>>>> [  236.260863] Kernel panic - not syncing: HYP panic:
>>>>> [  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006
>>>>
>>>> It would be interesting if you could find out what you have at offset
>>>> 0x830 of hyp-init.o (the stack trace is for EL1, and is not going to
>>>> help much).
>>>>
>>>
>>> Given the alignment, i'm going to assume i'm looking at the right thing:
>>>
>>> 0000000000000820 <__kvm_hyp_reset>:
>>>        820:       d51c2000        msr     ttbr0_el2, x0
>>>        824:       d5033fdf        isb
>>>        828:       d50c871f        tlbi    alle2
>>>        82c:       d5033f9f        dsb     sy
>>>        830:       10000060        adr     x0, 83c <__kvm_hyp_reset+0x1c>
>>>        834:       b3403c01        bfxil   x1, x0, #0, #16
>>>        838:       d61f0020        br      x1
>>>        83c:       d53c1000        mrs     x0, sctlr_el2
>>>
>>> but it seems fairly implausible to be trapping on ADR x0, 1f...
>>
>>
>> I've never seen this panic on fast model...
>>
>> ESR shows that
>>     - Exception class: Data abort taken without a change in Exception level
>>     - Data fault status code: Translation fault at EL2
>>
>> and FAR seems not to be a proper address.
>
> ... which is consistent with what we're seeing here (data fault on
> something that doesn't generate a load/store). I'm pretty sure the
> page tables are screwed.
>
> Have you tested it with 64k pages?

Hmm... It seems that I was able to reproduce the problem if 64k pages enabled.

-Takahiro AKASHI

> Thanks,
>
>          M.
>
