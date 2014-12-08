From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 8 Dec 2014 21:30:51 +0100 (CET)
Subject: [PATCH] irqchip: mediatek: Fix error return code detection
In-Reply-To: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <alpine.DEB.2.11.1412082114340.16275@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Dec 2014, Yingjoe Chen wrote:

> This fix an error handling bug reported by Beniamino, this is based on
> mtk intpol patches [1]
>
> Joe.C
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305808.html
> 
> ====================
> of_io_request_and_map() return ERR_PTR wrapped error code instead of
> NULL when fail, fix code in mtk_sysirq_of_init() to correctly handle
> this.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

This is not a proper changelog. Let me write up a proper one:

Subject: irqchip: mediatek: Use IS_ERR() instead of NULL pointer check

Beniamino reported a kernel oops caused by an invalid DT file for the
mediatek interrupt polarity extension.

The reason is that the interrupt polarity support for mediatek chips
merily checks for at NULL pointer instead of a casted error return
value in mtk_sysirq_of_init() so any other casted error value passes
the NULL pointer check and causes a kernel panic when dereferenced.

Use IS_ERR() and return the error value via PTR_ERR().

Reported-and-tested-by: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Can you see the difference?

Thanks,

	tglx
