From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Dec 2012 21:25:51 +0000
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
Message-ID: <201212012125.51935.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 December 2012, Alexander Shiyan wrote:
> +       switch (d->irq) {
> +       case IRQ_IXP4XX_TIMER1:
> +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> +               break;
> +       case IRQ_IXP4XX_TIMER2:
> +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> +               break;
> +       case IRQ_IXP4XX_TIMESTAMP:
> +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_TS_PEND;
> +               break;
> +       case IRQ_IXP4XX_WDOG:
> +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_WDOG_PEND;
> +               break;

Since you are touching these lines, it probably makes sense to convert them
to use writel_relaxed() in the process. Dereferencing a volatile pointer
in order to do MMIO is strongly discouraged, see
Documentation/volatile-considered-harmful.txt

	Arnd
