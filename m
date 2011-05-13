From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 May 2011 16:31:04 +0200
Subject: [QUERY] amba/pl022: DMA channel allocation always fail.
In-Reply-To: <4DCD1D80.7060409@st.com>
References: <4DCD1D80.7060409@st.com>
Message-ID: <BANLkTinMH9TpTTzqoMPS7JZUBRss3pScWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/13 viresh kumar <viresh.kumar@st.com>:

> amba/pl022 and my dma driver dw_dmac.c, both have registered init() routines
> with subsys_initcall(). Now at bootup, spi boots up before DMA and so DMA
> channels are never available at spi probe.
>
> What should be done to solve this issue?

If you check drivers/dma/ste_dma40.c you can see that our solution was to
simply move the DMA engine to arch_initcall().

Which sort of makes sense for a DMA engine.

Does this work for dw_dmac.c?

> One idea is allocate DMA channel as and when required, instead of allocating them
> at probe. But in that case too i am not sure, that this issue will be solved.

For the serial port I've added a real funny tweak to queue the ports
and add DMA later since these are initialized very early.

Check in drivers/tty/serial/amba-pl011.c

Hope this helps,
Linus Walleij
