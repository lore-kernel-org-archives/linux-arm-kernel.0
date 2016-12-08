From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 8 Dec 2016 10:59:47 +0100
Subject: [RFC PATCH net-next v3 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20161207193908.GA13062@netboy>
References: <1481134912-2243-1-git-send-email-andrei.pistirica@microchip.com>
 <20161207193908.GA13062@netboy>
Message-ID: <19ff9840-62cb-0de1-9d3d-f1312cfaf715@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/12/2016 ? 20:39, Richard Cochran a ?crit :
> On Wed, Dec 07, 2016 at 08:21:51PM +0200, Andrei Pistirica wrote:
>> +#ifdef CONFIG_MACB_USE_HWSTAMP
>> +void gem_ptp_init(struct net_device *ndev);
>> +void gem_ptp_remove(struct net_device *ndev);
>> +
>> +void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb);
>> +void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb);
> 
> These are in the hot path, and so you should do the test before
> calling the global function, something like this:
> 
> void gem_ptp_txstamp(struct macb *bp, struct sk_buff *skb);
> 
> static void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb)
> {
> 	if (!bp->hwts_tx_en)
> 		return;
> 	gem_ptp_txstamp(bp, skb);
> }
> 
> Ditto for Rx.

Hi Richard,

So you mean that as the "global" function won't be "inlined" by the
compiler as the function is not "static" neither in the same file and
that the jump will be implemented anyway. And this even if the function
is only called at a single location...

This way, if we add a kind or accessors function like the one that you
propose, with the test in it, the branch prediction can play his role
without breaking the processor pipeline as the accessors function will
be inlined by the compiler: Am I right?

So, yes, makes sense. Thanks for the hint.

Regards,
-- 
Nicolas Ferre
