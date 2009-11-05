From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Nov 2009 22:11:49 -0500
Subject: [PATCH] Fix PXA-27x/3xx interrupts when CONFIG_PXA_HAVE_ISA_IRQS=y
In-Reply-To: <f17812d70911031920t706d9909w3750a2eb9b1d958@mail.gmail.com>
References: <20091103210439.2a6c1f20@taxman.wild-wind.fr.eu.org>
	<771cded00911031827m34f36dc7r1bc7e1096bb98690@mail.gmail.com>
	<f17812d70911031920t706d9909w3750a2eb9b1d958@mail.gmail.com>
Message-ID: <771cded00911041911qded36d3sf9ce4384e1ad80b6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2009 at 10:20 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Nov 4, 2009 at 10:27 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Tue, Nov 3, 2009 at 3:04 PM, Marc Zyngier <maz@misterjones.org> wrote:
>>>
>>> Commit d2c37068429b29d6549cf3486fc84b836689e122 ([ARM] pxa:
>>> initialize default interrupt priority and use ICHP for IRQ handling)
>>> broke ISA interrupt support on PXA-27x/3xx.
>>>
>>> In such a case, PXA_IRQ(0) != 0, and the IRQ number computed from
>>> ICHP must be offset by PXA_IRQ(0).
>>>
>>> Tested on an Arcom Zeus (PXA-270).
>>>
>>> Signed-off-by: Marc Zyngier <maz@misterjones.org>
>>> ---
>>> ?arch/arm/mach-pxa/include/mach/entry-macro.S | ? ?3 +++
>>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
>>> index 2418806..f7eb9d8 100644
>>> --- a/arch/arm/mach-pxa/include/mach/entry-macro.S
>>> +++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
>>> @@ -46,5 +46,8 @@
>>> ? ? ? ? ? ? ? ?beq ? ? 1001f
>>> ? ? ? ? ? ? ? ?bic ? ? \irqstat, \irqstat, #0x80000000
>>> ? ? ? ? ? ? ? ?mov ? ? \irqnr, \irqstat, lsr #16
>>> +#ifdef CONFIG_PXA_HAVE_ISA_IRQS
>>> + ? ? ? ? ? ? ? add ? ? \irqnr, \irqnr, #(PXA_IRQ(0))
>>> +#endif
>
> The #ifdef here might not be necessary since PXA_IRQ() has already
> encoded the difference, check arch/arm/mach-pxa/include/mach/irqs.h
>
>>> ?1001:
>>> ? ? ? ? ? ? ? ?.endm
>>> --
>>> 1.6.0.4
>> Hi Marc,
>>
>> I have a question on this. Do you use CONFIG_PXA_HAVE_ISA_IRQS in
>> pxa270? In my patch, I only enable interrupt priority in pxa27x and
>> pxa3xx since silicon can support this feature. And this feature isn't
>> supported by pxa25x.
>>
>> I also find that CONFIG_PXA_HAVE_ISA_IRQS is only used in pxa25x. Is
>> it right? So I think that we needn't add this into pxa27x and pxa3xx.
>> What's your opinion?
>>
>
> Haojian,
>
> CONFIG_PXA_HAVE_ISA_IRQS is used on some platforms which emulates
> ISA expansion slots so some legacy ISA cards can still be used on pxa
> platforms, not necessarily related to pxa25x, could be pxa27x and pxa3xx.
> We need to take a look into the patch indeed.
>

I'm OK on this patch. It works well on my platform.
