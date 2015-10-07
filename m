From: joe@perches.com (Joe Perches)
Date: Tue, 06 Oct 2015 23:53:02 -0700
Subject: [PATCH] mlxsw: fix warnings for big-endian 32-bit dma_addr_t
In-Reply-To: <30258520.VaA2vDyUiY@wuerfel>
References: <30258520.VaA2vDyUiY@wuerfel>
Message-ID: <1444200782.26237.8.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-06 at 23:47 +0200, Arnd Bergmann wrote:
> The recently added mlxsw driver produces warnings in ARM
> allmodconfig:
> 
> drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_cmd_exec':
> drivers/net/ethernet/mellanox/mlxsw/pci.c:1585:59: warning: right shift count >= width of type [-Wshift-count-overflow]
> linux/byteorder/big_endian.h:38:51: note: in definition of macro '__cpu_to_be32'
> drivers/net/ethernet/mellanox/mlxsw/pci.c:76:2: note: in expansion of macro 'iowrite32be'
> 
> This changes the type of the local variable to u64, which gets rid of the
> warning and seems nicer than adding #ifdefs.

Using upper_32_bits instead of the shift might be
nicer than changing the type.
