From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 16:53:50 +0200
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4yHrYRQKO7tMeJhjj_aEhV69xnJSZzuHhq8hnBrmnG+dg@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201107011819.43316.arnd@arndb.de>
	<CAGsJ_4yHrYRQKO7tMeJhjj_aEhV69xnJSZzuHhq8hnBrmnG+dg@mail.gmail.com>
Message-ID: <201107041653.50962.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011, Barry Song wrote:
> Great idea. in fact there is only one reset bit for every device. So
> maybe the rstc.c can be
> ...

Yes, looks good.

>         /*
>          * Writing 1 to this bit resets corresponding block.
>          * Writing 0 to this bit de-asserts reset signal of
>          * the corresponding block.
>          */
>         writel(sirfsoc_rstc_base + (reset_bit / 32) * 4,
>                 readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit);
>         msleep(10);
>         writel(sirfsoc_rstc_base + (reset_bit / 32) * 4,
>                 readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit);

One remark about the msleep here: I find arbitrary wait periods a
bit unclean, and most hardware allows you to poll whether it's
done by reading back the register you have just written.

If your hardware can do that, you can replace the msleep() with a
single readl or a readl()/msleep(1) loop?

	Arnd
