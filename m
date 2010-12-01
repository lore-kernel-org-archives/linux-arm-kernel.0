From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 1 Dec 2010 19:23:59 +0800
Subject: [PATCH 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <20101130135623.GH20449@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-5-git-send-email-shawn.guo@freescale.com>
	<20101130135623.GH20449@pengutronix.de>
Message-ID: <AANLkTi=wjBOp9L5neRKLkjsJXi6fmpmxfbS=HRw0qpjN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/11/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
> On Fri, Nov 26, 2010 at 02:49:03PM +0800, Shawn Guo wrote:
[...]
>> +static void icoll_ack_irq(unsigned int irq)
>> +{
>> + ? ? __raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
> You need to write this before handling the irq, no?
>
No need, indeed.  Will remove it.

>> +
>> + ? ? /* ACK current interrupt (level 0) */
>> + ? ? __raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
>> + ? ? ? ? ? ? ? ? ? ? icoll_base + HW_ICOLL_LEVELACK);
>> +}
>> +
[...]
>> +
>> + ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
>> + ? ? ldr ? ? \base, =icoll_base
> Maybe it's worth to hardcode the base address if only a single cpu is
> compiled in? ?And what about setting the base register in
> get_irqnr_preamble?
>
I suppose you have known that MX23 and MX28 could be built into single
zImage.  So you are asking something as below, right?

        .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
        ldr     \irqnr, [\base, #0x70]
        cmp     \irqnr, #0x7F
        moveqs  \irqnr, #0
        .endm

        .macro  get_irqnr_preamble, base, tmp
#if defined (CONFIG_SOC_IMX23) && defined (CONFIG_SOC_IMX28)
        ldr     \base, =icoll_base
        ldr     \base, [\base]
#elif defined (CONFIG_SOC_IMX23)
        ldr     \base, =MX23_ICOLL_BASE_ADDR
#else
        ldr     \base, =MX28_ICOLL_BASE_ADDR
#endif
        .endm

>> + ? ? ldr ? ? \base, [\base]
>> + ? ? ldr ? ? \irqnr, [\base, #0x70]
>> + ? ? cmp ? ? \irqnr, #0x7F
>> + ? ? moveqs ?\irqnr, #0
> Hmm, you only need that cmp+moveqs because you cannot be sure that an
> irq is pending, right. ?Maybe it would make sense not to check for irqs
> in a loop? ?(This is a arm-global thing, Russell?) ?(BTW, you're lucky,
> for your irq controller it's only ugly to check if there is an irq
> pending. ?IIRC ns9xxx has a race here.)
>
Right.  But we actually have a problem with that on i.MX28, because
i.MX28  uses IRQ 127 as below.

#define MX28_INT_GPIO0                  127

So GPIO0 interrupt will not work.  Any suggestion to work around it?

-- 
Regards,
Shawn
