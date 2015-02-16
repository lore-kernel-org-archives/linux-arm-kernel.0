From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 11:28:57 +0100
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <2708248.TZ13zqn6jW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 February 2015 23:47:33 Robert Jarzmik wrote:
> @@ -294,7 +294,8 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
>                 /* try grabbing a DMA channel with the requested priority */
>                 for (i = 0; i < num_dma_channels; i++) {
>                         if ((dma_channels[i].prio == prio) &&
> -                           !dma_channels[i].name) {
> +                           !dma_channels[i].name &&
> +                           !mmp_pdma_toggle_reserved_channel(i)) {
>                                 found = 1;
>                                 break;
>                         }
> 

How is the order between the two enforced? I.e. can it be that the dmaengine
driver uses the same channel for a different slave before we get here?

If this is ensured to work, I'm fine with your approach.

	Arnd
