From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 22 Mar 2011 15:35:21 +0100
Subject: [PATCH 2/2] ARM: mxs: TX28: Setup MAC addresses for both FEC
	MACs from OTP fuses.
In-Reply-To: <20110322141446.GI28098@S2100-06.ap.freescale.net>
References: <de3ad96f6cc48ee276487b67a413b36fb089379d.1300724245.git.LW@KARO-electronics.de>
	<49cf2dff25189eb7b7a0ff9eaceefab359f08b2e.1300724245.git.LW@KARO-electronics.de>
	<20110322141446.GI28098@S2100-06.ap.freescale.net>
Message-ID: <19848.45993.589141.542159@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Mon, Mar 21, 2011 at 05:48:06PM +0100, Lothar Wa?mann wrote:
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/mach-mxs/module-tx28.c |   39 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 39 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
> > index 7d44936..7a9e7b6 100644
> > --- a/arch/arm/mach-mxs/module-tx28.c
> > +++ b/arch/arm/mach-mxs/module-tx28.c
> > @@ -74,6 +74,43 @@ static struct fec_platform_data tx28_fec1_data = {
> >  	.phy = PHY_INTERFACE_MODE_RMII,
> >  };
> >  
> > +#define HW_OCOTP_CUST0			0x20
> > +#define HW_OCOTP_CUST(n)		(HW_OCOTP_CUST0 + (n) * 0x10)
> > +#define HW_OCOTP_CTRL			0x00
> > +#define HW_OCOTP_CTRL_SET		(HW_OCOTP_CTRL + 4)
> > +#define HW_OCOTP_CTRL_CLR		(HW_OCOTP_CTRL + 8)
> > +
> > +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> > +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> > +
> > +static int __init tx28_set_mac(int id, unsigned char mac[])
> > +{
> > +	int i;
> > +	void __iomem *ocotp_base = ioremap(MX28_OCOTP_BASE_ADDR, SZ_4K);
> > +	u32 reg = 0;
> > +	long timeout = 1000;
> > +
> > +	if (ocotp_base == NULL)
> > +		return -ENOMEM;
> > +
> > +	/* set this bit to open the OTP banks for reading */
> > +	writel(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base + HW_OCOTP_CTRL_SET);
> > +
> > +	while (readl(ocotp_base + HW_OCOTP_CTRL) & BM_OCOTP_CTRL_BUSY) {
> > +		if (timeout-- < 0)
> > +			return -ETIMEDOUT;
> > +		udelay(100);
> > +	}
> > +
> > +	for (i = 0; i < ETH_ALEN; i++) {
> > +		if (i % 4 == 0)
> > +			reg = readl(ocotp_base + HW_OCOTP_CUST(id * 2 + i / 4));
> > +		mac[i] = reg >> (24 - ((i % 4) * 8));
> > +	}
> > +	iounmap(ocotp_base);
> > +	return 0;
> > +}
> > +
> 
> Why don't you use mxs_get_ocotp() to read otp?
> 
Good question... I'll change it.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
