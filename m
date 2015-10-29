From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 29 Oct 2015 09:03:31 -0700
Subject: [PATCH v4 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1446126991.25711.23.camel@mhfsdcap03>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-3-git-send-email-bayi.cheng@mediatek.com>
 <20151016073959.GB28158@localhost>
 <1445178035.4832.23.camel@mhfsdcap03>
 <20151029015237.GE13239@google.com>
 <1446089334.25711.10.camel@mhfsdcap03>
 <1446126991.25711.23.camel@mhfsdcap03>
Message-ID: <20151029160331.GA12954@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 09:56:31PM +0800, bayi.cheng wrote:
> On Thu, 2015-10-29 at 11:28 +0800, bayi.cheng wrote:
> > On Wed, 2015-10-28 at 18:52 -0700, Brian Norris wrote:
> > > On Sun, Oct 18, 2015 at 10:20:35PM +0800, bayi.cheng wrote:
> > > > On Fri, 2015-10-16 at 00:39 -0700, Brian Norris wrote:
> > > > > On Tue, Oct 13, 2015 at 05:39:19PM +0800, Bayi Cheng wrote:

> > > > > > +	/* mtk nor controller doesn't supoort SPINOR_OP_RDCR */
> > > > > > +	switch (opcode) {
> > > > > > +	case SPINOR_OP_RDID:
> > > > > > +		/* read JEDEC ID need 4 bytes commands */
> > > > > > +		ret = mt8173_nor_set_cmd(mt8173_nor, 0, 32, SPINOR_OP_RDID);
> > > > > > +		if (ret < 0)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		/* mtk nor flash controller only support 3 bytes IDs */
> > > > > 
> > > > > Are you absolutely sure of this? That would be highly unfortunate, but
> > > > > I also don't believe it's true.
> > > > > 
> > > > Yes, for this issue I have asked our designer of nor flash controller,
> > > > unfortunately, it is true, and I have tried to read more IDs, but our
> > > > controller just accept 3 IDs from nor flash, and our next generation IC
> > > > may solve this problem.
> > > 
> > > How exactly did you try? Did you do what I suggested above? Are the
> > > "shift registers" not all actually functional?
> > > 
> > Hi Brian, For this problem, I have asked our nor controller designer to
> > double confirm again, and he promise to do some simulation testes, On
> > the other hand, I have got some Spansion nor flash which has 5 IDs, and
> > after our designer make sure our controller can support 5 or 6 IDs, then
> > I will rework a special platform with S25FL256SA. If we have any
> > progress, I will inform you immediately!  Thanks!!
> > 
> Hi Brian, Thanks very much for your perseverance!!
> Actually, You idea is correct, and our designer has completed some
> simulation test on spansion nor flash witch has more than 3 IDs, and the
> results has prove that we can support to read 5 IDs. I also double

Awesome!

> confirmed with spansion nor flash. The only pity is that our nor
> controller can't support 6 IDs, we just support 5 IDs.

That's not quite as awesome. But that's still much more workable than
only 3 bytes. Perhaps we'll want a way to communicate that to the
spi-nor layer, so it doesn't think it can match a full 6 bytes?

> I will submit my changes to V6 version. Thanks again!!

OK, but let me take another look at v5 and send you comments on that one
first.

Regards,
Brian
