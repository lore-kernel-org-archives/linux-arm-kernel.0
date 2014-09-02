From: davem@davemloft.net (David Miller)
Date: Mon, 01 Sep 2014 20:26:32 -0700 (PDT)
Subject: [PATCH 1/5] net: mvberlin_eth: add an Ethernet driver for
 Marvell Berlin
In-Reply-To: <1409320263-10295-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1409320263-10295-1-git-send-email-antoine.tenart@free-electrons.com>
 <1409320263-10295-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140901.202632.1784070145688270115.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Fri, 29 Aug 2014 15:50:59 +0200

> +struct rx_desc {
> +	u16 buf_size;		/* Buffer size				*/
> +	u16 byte_cnt;		/* Descriptor buffer byte count		*/
 ...
> +	u16 byte_cnt;		/* buffer byte count			*/
> +	u16 l4i_chk;		/* CPU provided TCP checksum		*/

I'm really suspcious that you're ordering these two members differently
than that used by the mv643xx_eth driver.

Looking at a diff of the two drivers, most of the transmit and recieve paths
are largely the same.

WRT. register differences, adding indirection to handle that is a no-brainer
because the cost of the register access itself will absolutely dwarf whatever
it costs to do an indirect call or whatever to implement the register access.

I really think you should look into sharing code more seriously.
