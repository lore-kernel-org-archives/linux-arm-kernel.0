From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 28 Nov 2016 14:43:24 +0100
Subject: [PATCH 1/1] net: macb: fix the RX queue reset in macb_rx()
In-Reply-To: <20161127.202549.1887792653016840262.davem@davemloft.net>
References: <fd8131cbe6c0546b2b8ee35bcaac5e7eb1a1647f.1480063339.git.cyrille.pitchen@atmel.com>
 <20161127.202549.1887792653016840262.davem@davemloft.net>
Message-ID: <a7091340-e8e9-db01-4abb-3cc3227a842b@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Le 28/11/2016 ? 02:25, David Miller a ?crit :
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Date: Fri, 25 Nov 2016 09:49:32 +0100
> 
>> On macb only (not gem), when a RX queue corruption was detected from
>> macb_rx(), the RX queue was reset: during this process the RX ring
>> buffer descriptor was initialized by macb_init_rx_ring() but we forgot
>> to also set bp->rx_tail to 0.
>>
>> Indeed, when processing the received frames, bp->rx_tail provides the
>> macb driver with the index in the RX ring buffer of the next buffer to
>> process. So when the whole ring buffer is reset we must also reset
>> bp->rx_tail so the driver is synchronized again with the hardware.
>>
>> Since macb_init_rx_ring() is called from many locations, currently from
>> macb_rx() and macb_init_rings(), we'd rather add the "bp->rx_tail = 0;"
>> line inside macb_init_rx_ring() than add the very same line after each
>> call of this function.
>>
>> Without this fix, the rx queue is not reset properly to recover from
>> queue corruption and connection drop may occur.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to handle RX errors")
> 
> This doesn't apply cleanly to the 'net' tree, where
> RX_RING_SIZE is used instead of bp->rx_ring_size. It seems
> you generated this against net-next, however you didn't say
> that either in your Subject line nor the commit message.
> 
> As a bug fix this should be targetted at 'net'.
> 

Indeed, sorry. I've just sent a v2 based on net/master.

Best regards,

Cyrille
