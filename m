From: bayi.cheng@mediatek.com (bayi.cheng)
Date: Thu, 29 Oct 2015 11:28:54 +0800
Subject: [PATCH v4 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <20151029015237.GE13239@google.com>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-3-git-send-email-bayi.cheng@mediatek.com>
 <20151016073959.GB28158@localhost> <1445178035.4832.23.camel@mhfsdcap03>
 <20151029015237.GE13239@google.com>
Message-ID: <1446089334.25711.10.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 18:52 -0700, Brian Norris wrote:
> Hi Bayi,
> 
> I'm looking over your v5, and I still have a lot of comments. I'll send
> those soon. But I still question one of your responses here:
> 
> On Sun, Oct 18, 2015 at 10:20:35PM +0800, bayi.cheng wrote:
> > On Fri, 2015-10-16 at 00:39 -0700, Brian Norris wrote:
> > > On Tue, Oct 13, 2015 at 05:39:19PM +0800, Bayi Cheng wrote:
> 
> > > > diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> > > > new file mode 100644
> > > > index 0000000..c6ac366
> > > > --- /dev/null
> > > > +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> > > > @@ -0,0 +1,486 @@
> [...]
> > > > +#define MTK_NOR_CMD_REG			0x00
> > > > +#define MTK_NOR_CNT_REG			0x04
> > > > +#define MTK_NOR_RDSR_REG		0x08
> > > > +#define MTK_NOR_RDATA_REG		0x0c
> > > > +#define MTK_NOR_RADR0_REG		0x10
> > > > +#define MTK_NOR_RADR1_REG		0x14
> > > > +#define MTK_NOR_RADR2_REG		0x18
> > > > +#define MTK_NOR_WDATA_REG		0x1c
> > > > +#define MTK_NOR_PRGDATA0_REG		0x20
> > > > +#define MTK_NOR_PRGDATA1_REG		0x24
> > > > +#define MTK_NOR_PRGDATA2_REG		0x28
> > > > +#define MTK_NOR_PRGDATA3_REG		0x2c
> > > > +#define MTK_NOR_PRGDATA4_REG		0x30
> > > > +#define MTK_NOR_PRGDATA5_REG		0x34
> 
> ^^ so you have 6 "TX" registers.
> 
> > > > +#define MTK_NOR_SHREG0_REG		0x38
> > > > +#define MTK_NOR_SHREG1_REG		0x3c
> > > > +#define MTK_NOR_SHREG2_REG		0x40
> > > > +#define MTK_NOR_SHREG3_REG		0x44
> > > > +#define MTK_NOR_SHREG4_REG		0x48
> > > > +#define MTK_NOR_SHREG5_REG		0x4c
> 
> ^^ and you have at least 6 "RX" registers (looking at the mt8173 manual,
> I'm not sure what the SHREG{6..9} are for). So I don't see why you can't
> program MTK_NOR_CNT_REG to 48 (6 bytes * 8 bits/byte) to get 6 bytes
> TX/RX, or IOW, 1 byte of opcode and 5 bytes of either RX or TX data. So
> I'm still not convinced about your claim below.
> 
> I was able to rewrite your driver to do the above, and I can read out 5
> bytes no problem, but unfortunately, the flash device I have has only 3
> bytes of ID, so the last two bytes are zero, which doesn't tell me too
> much if this is working right.
> 
> > > > +#define MTK_NOR_SHREG6_REG		0x50
> > > > +#define MTK_NOR_SHREG7_REG		0x54
> > > > +#define MTK_NOR_SHREG8_REG		0x58
> > > > +#define MTK_NOR_SHREG9_REG		0x5c
> > > > +#define MTK_NOR_CFG1_REG		0x60
> > > > +#define MTK_NOR_CFG2_REG		0x64
> > > > +#define MTK_NOR_CFG3_REG		0x68
> > > > +#define MTK_NOR_STATUS0_REG		0x70
> > > > +#define MTK_NOR_STATUS1_REG		0x74
> > > > +#define MTK_NOR_STATUS2_REG		0x78
> > > > +#define MTK_NOR_STATUS3_REG		0x7c
> > > > +#define MTK_NOR_FLHCFG_REG		0x84
> > > > +#define MTK_NOR_TIME_REG		0x94
> > > > +#define MTK_NOR_PP_DATA_REG		0x98
> > > > +#define MTK_NOR_PREBUF_STUS_REG		0x9c
> > > > +#define MTK_NOR_DELSEL0_REG		0xa0
> > > > +#define MTK_NOR_DELSEL1_REG		0xa4
> > > > +#define MTK_NOR_INTRSTUS_REG		0xa8
> > > > +#define MTK_NOR_INTREN_REG		0xac
> > > > +#define MTK_NOR_CHKSUM_CTL_REG		0xb8
> > > > +#define MTK_NOR_CHKSUM_REG		0xbc
> > > > +#define MTK_NOR_CMD2_REG		0xc0
> > > > +#define MTK_NOR_WRPROT_REG		0xc4
> > > > +#define MTK_NOR_RADR3_REG		0xc8
> > > > +#define MTK_NOR_DUAL_REG		0xcc
> > > > +#define MTK_NOR_DELSEL2_REG		0xd0
> > > > +#define MTK_NOR_DELSEL3_REG		0xd4
> > > > +#define MTK_NOR_DELSEL4_REG		0xd8
> 
> ...
> 
> > > > +static int mt8173_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
> > > > +{
> > > > +	int ret;
> > > > +	struct mt8173_nor *mt8173_nor = nor->priv;
> > > > +
> > > > +	/* mtk nor controller doesn't supoort SPINOR_OP_RDCR */
> > > > +	switch (opcode) {
> > > > +	case SPINOR_OP_RDID:
> > > > +		/* read JEDEC ID need 4 bytes commands */
> > > > +		ret = mt8173_nor_set_cmd(mt8173_nor, 0, 32, SPINOR_OP_RDID);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		/* mtk nor flash controller only support 3 bytes IDs */
> > > 
> > > Are you absolutely sure of this? That would be highly unfortunate, but
> > > I also don't believe it's true.
> > > 
> > Yes, for this issue I have asked our designer of nor flash controller,
> > unfortunately, it is true, and I have tried to read more IDs, but our
> > controller just accept 3 IDs from nor flash, and our next generation IC
> > may solve this problem.
> 
> How exactly did you try? Did you do what I suggested above? Are the
> "shift registers" not all actually functional?
> 
Hi Brian, For this problem, I have asked our nor controller designer to
double confirm again, and he promise to do some simulation testes, On
the other hand, I have got some Spansion nor flash which has 5 IDs, and
after our designer make sure our controller can support 5 or 6 IDs, then
I will rework a special platform with S25FL256SA. If we have any
progress, I will inform you immediately!  Thanks!!

> > > > +		buf[2] = readb(mt8173_nor->base + MTK_NOR_SHREG0_REG);
> > > > +		buf[1] = readb(mt8173_nor->base + MTK_NOR_SHREG1_REG);
> > > > +		buf[0] = readb(mt8173_nor->base + MTK_NOR_SHREG2_REG);
> > > > +		break;
> 
> [...]
> 
> Brian
