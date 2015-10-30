From: bayi.cheng@mediatek.com (bayi.cheng)
Date: Fri, 30 Oct 2015 10:12:39 +0800
Subject: [PATCH v4 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <20151029160331.GA12954@localhost>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-3-git-send-email-bayi.cheng@mediatek.com>
 <20151016073959.GB28158@localhost> <1445178035.4832.23.camel@mhfsdcap03>
 <20151029015237.GE13239@google.com> <1446089334.25711.10.camel@mhfsdcap03>
 <1446126991.25711.23.camel@mhfsdcap03> <20151029160331.GA12954@localhost>
Message-ID: <1446171159.25711.36.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-29 at 09:03 -0700, Brian Norris wrote:
> On Thu, Oct 29, 2015 at 09:56:31PM +0800, bayi.cheng wrote:
> > On Thu, 2015-10-29 at 11:28 +0800, bayi.cheng wrote:
> > > On Wed, 2015-10-28 at 18:52 -0700, Brian Norris wrote:
> > > > On Sun, Oct 18, 2015 at 10:20:35PM +0800, bayi.cheng wrote:
> > > > > On Fri, 2015-10-16 at 00:39 -0700, Brian Norris wrote:
> > > > > > On Tue, Oct 13, 2015 at 05:39:19PM +0800, Bayi Cheng wrote:
> 
> > > > > > > +	/* mtk nor controller doesn't supoort SPINOR_OP_RDCR */
> > > > > > > +	switch (opcode) {
> > > > > > > +	case SPINOR_OP_RDID:
> > > > > > > +		/* read JEDEC ID need 4 bytes commands */
> > > > > > > +		ret = mt8173_nor_set_cmd(mt8173_nor, 0, 32, SPINOR_OP_RDID);
> > > > > > > +		if (ret < 0)
> > > > > > > +			return ret;
> > > > > > > +
> > > > > > > +		/* mtk nor flash controller only support 3 bytes IDs */
> > > > > > 
> > > > > > Are you absolutely sure of this? That would be highly unfortunate, but
> > > > > > I also don't believe it's true.
> > > > > > 
> > > > > Yes, for this issue I have asked our designer of nor flash controller,
> > > > > unfortunately, it is true, and I have tried to read more IDs, but our
> > > > > controller just accept 3 IDs from nor flash, and our next generation IC
> > > > > may solve this problem.
> > > > 
> > > > How exactly did you try? Did you do what I suggested above? Are the
> > > > "shift registers" not all actually functional?
> > > > 
> > > Hi Brian, For this problem, I have asked our nor controller designer to
> > > double confirm again, and he promise to do some simulation testes, On
> > > the other hand, I have got some Spansion nor flash which has 5 IDs, and
> > > after our designer make sure our controller can support 5 or 6 IDs, then
> > > I will rework a special platform with S25FL256SA. If we have any
> > > progress, I will inform you immediately!  Thanks!!
> > > 
> > Hi Brian, Thanks very much for your perseverance!!
> > Actually, You idea is correct, and our designer has completed some
> > simulation test on spansion nor flash witch has more than 3 IDs, and the
> > results has prove that we can support to read 5 IDs. I also double
> 
> Awesome!
> 
> > confirmed with spansion nor flash. The only pity is that our nor
> > controller can't support 6 IDs, we just support 5 IDs.
> 
> That's not quite as awesome. But that's still much more workable than
> only 3 bytes. Perhaps we'll want a way to communicate that to the
> spi-nor layer, so it doesn't think it can match a full 6 bytes?
> 
Hi Brian,  The current station is as follows.

1: put 0x9F to MTK_NOR_PRGDATA5_REG, and five 0x0 to
MTK_NOR_PRGDATA4_REG ~ MTK_NOR_PRGDATA0_REG, then set (1 + 5) * 8 
to MTK_NOR_CNT_REG, for this way, we can read five IDs.

2: put 0x9F to MTK_NOR_PRGDATA5_REG, and five 0x0 to
MTK_NOR_PRGDATA4_REG ~ MTK_NOR_PRGDATA0_REG, then set (1 + 5 + 1) * 8
to MTK_NOR_CNT_REG, for this way, we can read six IDs.
In this case, nor flash IDs can be read from MTK_NOR_SHREG5_REG to
MTK_NOR_SHREG0_REG . Thanks!

> > I will submit my changes to V6 version. Thanks again!!
> 
> OK, but let me take another look at v5 and send you comments on that one
> first.
> 
> Regards,
> Brian
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
