From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jul 2016 11:26:57 +0200
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <20160728131826.GA7582@Red>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <4697175.RMdFEWr9V5@wuerfel> <20160728131826.GA7582@Red>
Message-ID: <4552489.XcKoxjnXeP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 28, 2016 3:18:26 PM CEST LABBE Corentin wrote:
> 
> I will reworked locking and it seems that no locking is necessary.
> I have added the following comment about the locking strategy:
> 
> /* Locking strategy:
>  * RX queue does not need any lock since only sun8i_emac_poll() access it.
>  * (All other RX modifiers (ringparam/ndo_stop) disable NAPI and so sun8i_emac_poll())
>  * TX queue is handled by sun8i_emac_xmit(), sun8i_emac_complete_xmit() and sun8i_emac_tx_timeout()
>  * (All other RX modifiers (ringparam/ndo_stop) disable NAPI and stop queue)
>  *
>  * sun8i_emac_xmit() could fire only once (netif_tx_lock)
>  * sun8i_emac_complete_xmit() could fire only once (called from NAPI)
>  * sun8i_emac_tx_timeout() could fire only once (netif_tx_lock) and couldnt
>  * race with sun8i_emac_xmit (due to netif_tx_lock) and with sun8i_emac_complete_xmit which disable NAPI.
>  *
>  * So only sun8i_emac_xmit and sun8i_emac_complete_xmit could fire at the same time.
>  * But they never could modify the same descriptors:
>  * - sun8i_emac_complete_xmit() will modify only descriptors with empty status
>  * - sun8i_emac_xmit() will modify only descriptors set to DCLEAN
>  * Proper memory barriers ensure that descriptor set to DCLEAN could not be
>  * modified latter by sun8i_emac_complete_xmit().
>  * */

Sounds good, the comment is certainly very helpful here.

	Arnd
