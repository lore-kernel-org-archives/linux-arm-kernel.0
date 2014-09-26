From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 21:51:53 +0100
Subject: [PATCH 2/3] pm: add FSM configuration for deep sleep
In-Reply-To: <20140926120201.GN5182@n2100.arm.linux.org.uk>
References: <1411730703-25836-1-git-send-email-chenhui.zhao@freescale.com>
 <1411730703-25836-3-git-send-email-chenhui.zhao@freescale.com>
 <20140926120201.GN5182@n2100.arm.linux.org.uk>
Message-ID: <20140926205153.GY5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 01:02:01PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 26, 2014 at 07:25:02PM +0800, Chenhui Zhao wrote:
> > +void fsm_write32(void __iomem *addr, u32 val)
> > +{
> > +#ifdef __arm__
> > +	iowrite32be(val, addr);
> > +#endif
> > +
> > +#ifdef __powerpc__
> > +	out_be32(addr, val);
> > +#endif
> 
> The idea of iowrite* is that it should be able to address MMIO or IO
> memory irrespective of the platform.  Why is PowerPC not implementing
> this accessor, or why can't it be used for PowerPC?
> 
> This should just use iowrite32be(), and if it doesn't work on PowerPC,
> PowerPC needs to be fixed.

BenH tells me that this should be able to use iowrite32be() on PowerPC
too without problems, there should be no need to use the older out_be32()
accessors here.  Please can you look into using only iowrite32be() here?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
