From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 10 Dec 2010 23:42:00 +0800
Subject: [PATCH v5 07/15] ARM: mxs: Add gpio support
In-Reply-To: <20101210102416.GH17441@pengutronix.de>
References: <1291968402-19393-1-git-send-email-shawn.guo@freescale.com>
	<1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
	<20101210102416.GH17441@pengutronix.de>
Message-ID: <AANLkTi=UKMshh+-W=irNSodmg74uHJfD8x09E3dtgzbq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
> On Fri, Dec 10, 2010 at 04:06:40PM +0800, Shawn Guo wrote:
>> + ? ? /* set level or edge */
>> + ? ? if (edge & GPIO_INT_LEV_MASK)
>> + ? ? ? ? ? ? __raw_writel(1 << (gpio & 31),
>> + ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_IRQLEV(port->id) + MXS_SET_ADDR);
>> + ? ? else
>> + ? ? ? ? ? ? __raw_writel(1 << (gpio & 31),
>> + ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_IRQLEV(port->id) + MXS_CLR_ADDR);
> Is this preferable?:
>
> ? ? ? ?__raw_writel(1 << (gpio & 31), port->base + PINCTRL_IRQLEV(port->id) +
> ? ? ? ? ? ? ? ?(edge & GPIO_INT_LEV_MASK ? MXS_SET_ADDR : MXS_CLR_ADDR))
>
> . ?I'm not sure. ?And if you like my __raw_setl/__raw_clearl (or
> __raw_clrl?) suggestion this won't work though. ?If you don't, I'd
> prefer to be easily able to see that the two commands only differ by
> MXS_SET_ADDR vs. MXS_CLR_ADDR.
>
> e.g.
>
> ? ? ? ?u32 nicename = 1 << (gpio & 31);
> ? ? ? ?correcttype addr = port->base + PINCTRL_IRQLEV(port->id);
>
> ? ? ? ?if (edge & GPIO_INT_LEV_MASK)
> ? ? ? ? ? ? ? ?__raw_writel(nicename, addr + MXS_SET_ADDR);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?__raw_writel(nicename, addr + MXS_CLR_ADDR);
>
You are more satisfied if I have the following in v6 patch, aren't you?

        if (edge & GPIO_INT_LEV_MASK)
                __raw_setl(nicename, addr);
        else
                __raw_clearl(nicename, addr);

Do we need namespace here?  __mxs_setl/__mxs_clearl or
__mxs_raw_setl/__mxs_raw_clearl?

I suppose they will be inline functions in mxs.h.

-- 
Regards,
Shawn
