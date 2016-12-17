From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 17 Dec 2016 16:26:58 +0100
Subject: [PATCH] net: mvpp2: fix dma unmapping of TX buffers for fragments
In-Reply-To: <20161217.102057.1497114610120684110.davem@davemloft.net>
References: <1481647995-7213-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20161217.102057.1497114610120684110.davem@davemloft.net>
Message-ID: <20161217162658.63bc2423@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 17 Dec 2016 10:20:57 -0500 (EST), David Miller wrote:

> You're really destroying cache locality, and making things overly
> complicated, by having two arrays.  Actually this is now the third in
> this structure alone.  That's crazy.
> 
> Just have one array for the TX ring software state:
> 
> struct tx_buff_info {
> 	struct sk_buff	*skb;
> 	dma_addr_t	dma_addr;
> 	unsigned int	size;
> };
> 
> Then in the per-cpu TX struct:
> 
> 	struct tx_buff_info	*info;
> 
> This way every data access by the cpu for processing a ring entry
> will be localized, increasing cache hit rates.
> 
> This also significantly simplifies the code that allocates and
> frees this memory.

Yes, I was thinking of moving towards a single array, as it's indeed
crazy to have three arrays for that. However, since it's a fix going
into stable, I also wanted to keep it as simple/straightforward as
possible and avoid refactoring other parts of the code.

If you however believe moving to one array should be done as part of
the fix, I'll do this.

Thanks for your feedback,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
