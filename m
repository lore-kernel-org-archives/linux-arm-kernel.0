From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Oct 2018 13:33:32 +0200
Subject: [PATCH] mmc: tmio: simplify the DMA mode test
In-Reply-To: <20181014223636.GH3260@kunai>
References: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223636.GH3260@kunai>
Message-ID: <20181015113332.uqnd4kmoabzto5kr@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 12:36:36AM +0200, Wolfram Sang wrote:
> On Sat, Oct 13, 2018 at 12:03:08AM +0900, Masahiro Yamada wrote:
> > host->chan_{rx,tx} represents the DMA capability of the platform.
> > Even if DMA is supported, there are cases where we want to use PIO,
> > for example, data length is short enough as commit 5f52c3552946
> > ("mmc: tmio: use PIO for short transfers") mentioned.
> > 
> > Regarding the hardware control flow, we are interested in whether DMA
> > is currently enabled or not, instead of whether the platform has the
> > DMA capability.
> > 
> > Hence, the several conditionals in tmio_mmc_core.c end up with
> > checking host->chan_{rx,tx} and !host->force_pio. This is not nice.
> > 
> > Let's flip the flag host->force_pio into host->dma_on.
> > 
> > host->dma_on represents whether the DMA is currently enabled or not.
> > This flag is set false in the beginning of each command, then should
> > be set true by tmio_mmc_start_dma() when the DMA is turned on.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> I like it. Much easier to read!
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions,
especially no performance regressions (since "when to enable DMA" code
was refactored).

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/eefce754/attachment.sig>
