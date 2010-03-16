From: me@felipebalbi.com (Felipe Balbi)
Date: Tue, 16 Mar 2010 16:46:45 +0200
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <4B9F59DE.4070807@windriver.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
	<4B9E187E.6090802@ru.mvista.com> <20100315161024.GC3879@gandalf>
	<4B9F59DE.4070807@windriver.com>
Message-ID: <20100316144644.GA3870@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 16, 2010 at 06:13:50PM +0800, wanghui wrote:
> Thank you for your comments.
> It is right that in this function, we should only change id pin rules 
> according to user's choice, and
> leave mode transition to the ISR.
> But things are different on omap platforms, because the id pin change 
> can't trigger ISR.
> For example, when we configure the kernel, we choose musb working as OTG 
> mode. Then we plug a mini-A or a mini-B cable in the socket, after
> that we execute insmod g_ether.ko, at this time, the musb will 
> initialize to A or B working mode. how to change
> its working mode from A to B or B to A at this time? I think if the 
> platform can support id detection ISR, your method
> is workable. But on omap platforms, we must change cable(id pin state) 
> manually first, then let the controller to re-initiate a session forcibly.
> This action (clear/set session bit) don't 100% equal to send a SRP, and 
> i don't really want to send a SRP too.
> 
> If without this function for omap platforms, we can change musb working 
> mode only through rebooting kernel or rmmod/insmod gadget driver module.

it should be doable with the transceiver ISR. When you get id pin irq,
you should put the transceiver into A_IDLE state and power up vbus. MUSB
changes to host mode automatically.

-- 
balbi
