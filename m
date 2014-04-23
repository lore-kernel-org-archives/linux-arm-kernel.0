From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 23 Apr 2014 17:31:44 +0200
Subject: [PATCH] ARM: dts: am33xx: Move the cppi41dma node so it's probed
 early
In-Reply-To: <1398176371-26468-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1398176371-26468-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <5357DCE0.5050204@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 04:19 PM, Ezequiel Garcia wrote:
> The DMA controller is needed for the USB controller to be correctly
> registered. Therefore, if the DMA node is located at the end an unecessary
> probe deferral is produced systematically.
> 
> This is easily fixed by moving the node at the beggining of the child list,
> so it's probed first.

So you do not change anything except for the order of child nodes. So
this should be fine and without a compatibility problem.

I added them according to the memory offset so you might want to add a
comment why you moved this because Mr. Structured & Organized might
noticed this one day and move it back.

> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
> Felipe, Sebastian:
> 
> I cannot see why the cppi41dma node must be placed inside the
> "ti,am33xx-usb" compatible node. Tried to move it out
> so it's probed just like the edma engine, but the USB doesn't work
> properly in that case.
> 
> Can you enlighten me?

So If I remember correctly it was a big bag of crap. If you look at the
parent node, you notice that it has a ti,hwmods member while the other
do not have such a property. According to the manual only the whole IP
block as-it has this. It has to be activated if you use one of those
devices this includes the two USB-IP cores and the DMA-IP core. I
didn't manage to come up with something else except to make one parent
node which creates the childs to have a proper relation here.

There was also something with parent - child relation in the way musb
expected it. I think this was only glue code + musb child node and had
nothing to do with the DMA engine. But I am not 100% sure?

> 
> In any case, this change is good enough to remove the deferral probe.

Sebastian
