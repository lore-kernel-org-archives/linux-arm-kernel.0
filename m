From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 11 Oct 2010 08:34:29 +1300
Subject: [PATCH 1/4] ARM: ep93xx: DMA: fix channel_disable
In-Reply-To: <43bf7ec49ce8ee7e7c7c375be053d6095ba53511.1286707213.git.mika.westerberg@iki.fi>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<43bf7ec49ce8ee7e7c7c375be053d6095ba53511.1286707213.git.mika.westerberg@iki.fi>
Message-ID: <4CB21545.7040301@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2010 11:54 PM, Mika Westerberg wrote:
> When channel_disable() is called, it disables per channel interrupts and
> waits until channels state becomes STATE_STALL, and then disables the
> channel. Now, if the DMA transfer is disabled while the channel is in
> STATE_NEXT we will not wait anything and disable the channel immediately.
> This seems to cause weird data corruption for example in audio transfers.
> 
> Fix is to wait while we are in STATE_NEXT or STATE_ON and only then
> disable the channel.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/dma-m2p.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/dma-m2p.c b/arch/arm/mach-ep93xx/dma-m2p.c
> index 8904ca4..a696d35 100644
> --- a/arch/arm/mach-ep93xx/dma-m2p.c
> +++ b/arch/arm/mach-ep93xx/dma-m2p.c
> @@ -276,7 +276,7 @@ static void channel_disable(struct m2p_channel *ch)
>  	v &= ~(M2P_CONTROL_STALL_IRQ_EN | M2P_CONTROL_NFB_IRQ_EN);
>  	m2p_set_control(ch, v);
>  
> -	while (m2p_channel_state(ch) == STATE_ON)
> +	while (m2p_channel_state(ch) >= STATE_ON)
>  		cpu_relax();
>  
>  	m2p_set_control(ch, 0x0);

Looks correct to me. CC'ed Lennert, who originally wrote the DMA M2P
support, but otherwise:

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
