From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 22:20:09 +0100
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
Message-ID: <5414359.8GMja3pNrI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:
> > Is there a non-"under the covers" way to say "flush this region" without
> > the arch second-guessing whether it really needs to be flushed?
> Any advice on how to resolve this? I looked into trying to do a
> non-cacheable mapping of the
> memory so that the flush wouldn't be required but the ioremap code
> prevents mapping normal
> memory in this way.  The QMan device requiresthis memory to be zeroed at
> startup. Because the device
> does non coherent reads and writes to the memory we must ensure that any
> cache in the CPU cluster(s)
> is flushed in order to prevent a future castout from overwriting data.
> This happened before on PPC
> platforms and made for some very unfun debug session trying to
> understand what was causing the failure.

If this is normal RAM, you should be able to just write zeroes, and then
do a dma_map_single() for initialization. Are there any other requirements
what to do with the memory later, is it used for communication at all,
or just required to be zero?

	Arnd
