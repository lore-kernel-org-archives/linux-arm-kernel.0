From: davem@davemloft.net (David Miller)
Date: Tue, 22 Nov 2016 11:12:23 -0500 (EST)
Subject: [PATCH net-next] net: mvneta: Only disable mvneta_bm for 64-bits
In-Reply-To: <20161122160037.14400-1-gregory.clement@free-electrons.com>
References: <20161122160037.14400-1-gregory.clement@free-electrons.com>
Message-ID: <20161122.111223.676925674747527292.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Tue, 22 Nov 2016 17:00:37 +0100

> Actually only the mvneta_bm support is not 64-bits compatible.
> The mvneta code itself can run on 64-bits architecture.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

No it cannot, it emits warnings because it casts pointers to and
from 32-bit integers.

I'm not applying this.

drivers/net/ethernet/marvell/mvneta.c: In function ?mvneta_rx_refill?:
drivers/net/ethernet/marvell/mvneta.c:1802:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  mvneta_rx_desc_fill(rx_desc, phys_addr, (u32)data);
                                          ^
drivers/net/ethernet/marvell/mvneta.c: In function ?mvneta_rxq_drop_pkts?:
drivers/net/ethernet/marvell/mvneta.c:1864:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   void *data = (void *)rx_desc->buf_cookie;
                ^
drivers/net/ethernet/marvell/mvneta.c: In function ?mvneta_rx_swbm?:
drivers/net/ethernet/marvell/mvneta.c:1902:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   data = (unsigned char *)rx_desc->buf_cookie;
          ^
drivers/net/ethernet/marvell/mvneta.c: In function ?mvneta_rx_hwbm?:
drivers/net/ethernet/marvell/mvneta.c:2023:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   data = (unsigned char *)rx_desc->buf_cookie;
          ^
