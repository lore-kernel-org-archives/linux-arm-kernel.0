From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Sep 2014 10:39:27 +0100
Subject: [PATCHv2] dmaengine: fsl-edma: fixup reg offset and hw S/G
 support in big-endian model
In-Reply-To: <1411542727-11026-1-git-send-email-jingchang.lu@freescale.com>
References: <1411542727-11026-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140924093926.GT5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 03:12:07PM +0800, Jingchang Lu wrote:
>  static void edma_writeb(struct fsl_edma_engine *edma, u8 val, void __iomem *addr)
>  {
> -	iowrite8(val, addr);
> +	/* swap the reg offset for these in big-endian mode */
> +	if (edma->big_endian)
> +		iowrite8(val, (void __iomem *)((u32)addr ^ 0x3));

NAK.  /Not/ u32.  unsigned long.  Run this through sparse, and sparse
will complain with u32 here.  Just because the driver is currently used
on a 32-bit arch is no reason to be sloppy about this.

In fact, running this through sparse (make ... C=1) or even C=2 might
well be a good idea to check whether there's any other silly mistakes.

Note that Documentation/SubmitChecklist calls for checks with sparse.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
