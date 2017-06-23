From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jun 2017 16:55:40 +0100
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
In-Reply-To: <20170623152227.GA21989@leverpostej>
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
Message-ID: <20170623155539.GT4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 04:22:27PM +0100, Mark Rutland wrote:
> The prior discussion on that front were largely to do with teh
> shareability of that memory, which is an orthogonal concern.
> 
> If these are actually MMIO registers, a Device memory type must be used,
> rather than a Normal memory type. There are a number of things that
> could go wrong due to relaxations permitted for Normal memory, such as
> speculative reads, the potential set of access sizes, memory
> transactions that the endpoint might not understand, etc.

Well, we have:

        dma_wmb();
        mc->cr->_ncw_verb = myverb | mc->vbit;
        dpaa_flush(mc->cr);

and we also have:

        mc->cr = portal->addr.ce + BM_CL_CR;
        mc->rridx = (__raw_readb(&mc->cr->_ncw_verb) & BM_MCC_VERB_VBIT) ?
                    0 : 1;

and:

        dpaa_zero(mc->cr);

which is just another name for a 64-byte memset() which doesn't have
any flushing.

Note that this is memory obtained from the ioremap() family of functions,
so all of these pointers _should_ have __iomem annotations (but don't.)
However, if this isn't iomem, then it shouldn't be using the ioremap()
family of functions, and should be using memremap() instead.

Without really having an understanding of what this chunk of code is
doing (and abuse like the above makes it harder than necessary) no one
can really say from just reading through the code... which brings up
another problem - that of long term maintanability.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
