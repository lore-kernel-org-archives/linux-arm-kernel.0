From: davem@davemloft.net (David Miller)
Date: Wed, 29 Nov 2017 09:44:10 -0500 (EST)
Subject: [PATCH] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on
 64-bit
In-Reply-To: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
References: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20171129.094410.1537008794654450709.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Nov 2017 11:01:09 +0100

> On 64-bit (e.g. powerpc64/allmodconfig):
> 
>     drivers/net/ethernet/xilinx/ll_temac_main.c: In function 'temac_start_xmit_done':
>     drivers/net/ethernet/xilinx/ll_temac_main.c:633:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 	dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
> 			  ^
> 
> cdmac_bd.app4 is u32, so it is too small to hold a kernel pointer.
> 
> Note that several other fields in struct cdmac_bd are also too small to
> hold physical addresses on 64-bit platforms.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Yeah, I can't see much value in implementing a hash table converting between
32-bit cookies and 64-bit points just for this if it'll never be actually
used.

Applied, thanks Geert.
