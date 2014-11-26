From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Nov 2014 17:18:46 +0000
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <CAJe_ZheX5KwraFMmuA+uMq95BprJVxaPSWjKd7gOjeEKLDXSdQ@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <alpine.LFD.2.11.1411251205500.11690@knanqh.ubzr>
 <20141125184609.GA29425@e102568-lin.cambridge.arm.com>
 <CAJe_ZheX5KwraFMmuA+uMq95BprJVxaPSWjKd7gOjeEKLDXSdQ@mail.gmail.com>
Message-ID: <54760B76.8050308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/11/14 16:29, Jassi Brar wrote:
> On 26 November 2014 at 00:16, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Tue, Nov 25, 2014 at 05:42:32PM +0000, Nicolas Pitre wrote:
>>> On Thu, 20 Nov 2014, Vincent Yang wrote:
>>>
>>>> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
>>>> CPU/CLUSTER power up/down done by SCB over mailbox.
>>>>
>>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>>>> ---

[...]
>>>> +asmlinkage void mb86s70evb_outer_flush_all(void)
>>>> +{
>>>> +     outer_flush_all();
>>>> +}
>>>> +
>>>> +#define mb86s70evb_exit_coherency_flush(level) { \
>>>> +     asm volatile( \
>>>> +     "stmfd  sp!, {fp, ip}\n\t" \
>>>> +     "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>>>> +     "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>>>> +     "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>>>> +     "isb\n\t" \
>>>> +     "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>>>> +     "bl     mb86s70evb_outer_flush_all\n\t" \
>>>
>>> This is wrong.  As mentioned already, this unconditionally flushes L2 in
>>> all cases which shouldn't be necessary in the "louis" case.
>>
>> Is this a bL system with unified and architected L2s ? I think so, so
>> what's the outercache for ?
>>
> Yes, the CA15 has 1MB and CA7 256KB L2 cache, that's it.
> This thing sneaked in via a patch from someone desperate to make
> Suspend-To-Ram (not yet submitted) work and I failed to spot it. We
> should remove the mb86s70evb_outer_flush_all()

Good, so this platform doesn't have any outer cache at all ?
And that shouldn't sneak-in back again for suspend2ram case also.
So you can use the generic v7_exit_coherency_flush as is ?

Regards,
Sudeep
