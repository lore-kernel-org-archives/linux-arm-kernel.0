From: imp@bsdimp.com (Warner Losh)
Date: Thu, 16 Aug 2012 09:15:18 -0600
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <20120816121852.GA7439@game.jcrosoft.org>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
 <20120816121852.GA7439@game.jcrosoft.org>
Message-ID: <2ABEF8B7-7F9C-4A5F-8303-0196970CA300@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 16, 2012, at 6:18 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 16:38 Wed 15 Aug     , Linus Walleij wrote:
>>> +static void at91_mux_pio3_set_A_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask,
>>> +                                               pio + PIO_ABCDSR1);
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
>>> +                                               pio + PIO_ABCDSR2);
>>> +}
>>> +
>>> +static void at91_mux_pio3_set_B_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask,
>>> +                                               pio + PIO_ABCDSR1);
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
>>> +                                               pio + PIO_ABCDSR2);
>>> +}
>>> +
>>> +static void at91_mux_set_A_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +       __raw_writel(mask, pio + PIO_ASR);
>>> +}
>>> +
>>> +static void at91_mux_set_B_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +       __raw_writel(mask, pio + PIO_BSR);
>>> +}
>>> +
>>> +static void at91_mux_set_C_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask, pio + PIO_ABCDSR1);
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
>>> +}
>>> +
>>> +static void at91_mux_set_D_periph(void __iomem *pio, unsigned mask)
>>> +{
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask, pio + PIO_ABCDSR1);
>>> +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
>>> +}
>> 
>> I have no clue whatsoever what is going on here, A? B? C? D?
>> Some small comment or something giving a hint about this grouping
>> system and how it works would be really nice.
> periph (mux)
>> 

You should read it in the context that's there.  'A_periph', 'B_periph', etc.  These functions select what device is connected to a given pin.  These are designated A, B, C, or D in the data sheets.  The overloading of PIO names with letters and Peripheral names with letters is mildly confusion in the Atmel datasheets, but is something one quickly gets used to.  Adding a one line comment wouldn't hurt here.  Maybe '/* Select proper peripheral for pin mux. */'

No comments on the rest of the patch, since I've only seen the replies to the original and can't find it any of the archives.  From what was quoted, however, this looks like a giant leap forward.  DT in 3.5 looked to be very limited, and this is one of the last pieces needed to avoid any board specific files in the general case.  I'm glad to see it coming along.

Warner
