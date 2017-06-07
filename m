From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 7 Jun 2017 03:38:50 +0000
Subject: [PATCH] ARM: imx6ull: Make suspend/resume work like on 6ul
In-Reply-To: <20170607032124.GA31070@dragon>
References: <c63fd9031493cefed47d59c9918c0ecb76ffaf85.1496160320.git.leonard.crestez@nxp.com>
 <20170605053722.GI4094@dragon> <1496746313.28352.19.camel@nxp.com>
 <20170607032124.GA31070@dragon>
Message-ID: <DB5PR04MB1320775AD16A92EDA884BA32F5C80@DB5PR04MB1320.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2017-06-07 11:21 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>; Peter Chen
> <peter.chen@nxp.com>; linux-kernel at vger.kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; linux-arm-kernel at lists.infradead.org; Lucas Stach
> <l.stach@pengutronix.de>
> Subject: Re: [PATCH] ARM: imx6ull: Make suspend/resume work like on 6ul
> 
> On Tue, Jun 06, 2017 at 01:51:53PM +0300, Leonard Crestez wrote:
> > On Mon, 2017-06-05 at 13:37 +0800, Shawn Guo wrote:
> > > On Tue, May 30, 2017 at 07:11:19PM +0300, Leonard Crestez wrote:
> > > >
> > > > Suspend and resume on imx6ull is currenty not working because of
> > > > some missed checks where behavior should match imx6ul.
> > > >
> > > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > > ---
> > > > ?arch/arm/mach-imx/mxc.h?????| 6 ++++++
> > > > ?arch/arm/mach-imx/pm-imx6.c | 6 ++++--
> > > > ?2 files changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> > > > index 34f2ff6..e00d626 100644
> > > > --- a/arch/arm/mach-imx/mxc.h
> > > > +++ b/arch/arm/mach-imx/mxc.h
> > > > @@ -39,6 +39,7 @@
> > > > ?#define MXC_CPU_IMX6SX		0x62
> > > > ?#define MXC_CPU_IMX6Q		0x63
> > > > ?#define MXC_CPU_IMX6UL		0x64
> > > > +#define MXC_CPU_IMX6ULL		0x65
> > > Since you are adding a new CPU type, you should probably patch
> > > imx_soc_device_init() for it as well.
> >
> > Ok, I will resend as a 2-patch series.
> >
> > BTW, it actually seems to me that setting
> BM_CLPCR_BYP_MMDC_CH0_LPM_HS
> > on imx6sl/sx/ul/ull is not actually needed. That bit (19) is
> > documented as "reserved" in the Reference Manual and likely ignored by
> hardware.
> >
> > As far as I understand the MMDC on imx6qdl has two channels and unless
> > 2-channel mode is enabled (not currently supported) the handshake with
> > CH1 needs to be disabled. Other reduced chips only have one MMDC
> > channel and that is CH1 (CH0 was removed) and nothing needs to be done
> > from them. The only important thing is to avoid setting
> > BM_CLPCR_BYP_MMDC_CH1_LPM_HS.
> >
> > However perhaps what I am saying is wrong for some early chip versions?
> > Because this behavior of setting BM_CLPCR_BYP_MMDC_CH0_LPM_HS has
> been
> > in the kernel for a long time.

As far as I know, since i.MX6SX, we only use MMDC_CH1, but MMDC_CH0 is still
there and we need to bypass its handshake when entering low power mode.

The bit 19 in DOC is incorrect, I remembered I ever tried it and discuss with design
time, they request DOC team to update DOC,
but I think doc team forgot to do it. You can try removing this bit 19 setting
and see if standby/mem suspend can still work? And try to modify this bit 19 value
to see if it can be modified.

Anson.


> 
> @Anson, you might be the right person to comment here?
> 
> Shawn
