From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Jan 2014 12:40:14 +0000
Subject: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
In-Reply-To: <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>
 <20140109175208.GK12858@sirena.org.uk>
 <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com>
Message-ID: <20140110124014.GI29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 08:11:33AM +0000, Chao Fu wrote:

> [Chao Fu] Our CPUs are working on only ARM architecture. But DSPI have two endianness 
> In different series CPU, so we use __raw_read that do not take of endianness.
> We need observe ARM io methods  make sure avoid instructions executing reorder .
> ARM IO methods :
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
> #define readw(c)                ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
> #define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> 
> #define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
> #define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
> #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
> 
> So add barrier here. Could you give some suggestions? Many thanks!

OK that makes sense, please add comments explaining that this is due to
the endinaness translation.  Given that people are starting to use big
endian more it might be sensible to have these factored out into generic
code but that can wait.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/7d8b491e/attachment.sig>
