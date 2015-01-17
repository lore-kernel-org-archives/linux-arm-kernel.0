From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 12:07:10 +0100
Subject: [PATCH] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on
 Vbus change
In-Reply-To: <20150117104358.0282b27f@bbrezillon>
References: <1421446870-26653-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117014231.GW3843@piout.net>
 <20150117104358.0282b27f@bbrezillon>
Message-ID: <20150117110710.GB24176@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

On Sat, Jan 17, 2015 at 10:43:58AM +0100, Boris Brezillon wrote:
> 
> You're right, except that calling enable/disable on the PLL clk in irq
> context is pretty much useless since the activation/deactivation code
> of the PLL is in prepare/unprepare, so you won't save much power by
> doing that (gating the peripheral clk should save a bit though). 
> 
> To solve that issue I thought we could move to a threaded_irq (where we
> can safely sleep), but you'll also have to take of not calling
> prepare/unprepare in sections where at least one spinlock is taken (for
> the same reason => you cannot sleep with while you hold spinlocks).

Hummm, I must admit I waited for such a useful tip, adding the 
prepare/unprepare in interrupt context looked dirty at first sight, 
thank you very much :)

I will try with a threaded_irq.

Sylvain
