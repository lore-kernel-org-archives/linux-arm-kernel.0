From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Jun 2017 13:51:53 +0300
Subject: [PATCH] ARM: imx6ull: Make suspend/resume work like on 6ul
In-Reply-To: <20170605053722.GI4094@dragon>
References: <c63fd9031493cefed47d59c9918c0ecb76ffaf85.1496160320.git.leonard.crestez@nxp.com>
 <20170605053722.GI4094@dragon>
Message-ID: <1496746313.28352.19.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-05 at 13:37 +0800, Shawn Guo wrote:
> On Tue, May 30, 2017 at 07:11:19PM +0300, Leonard Crestez wrote:
> > 
> > Suspend and resume on imx6ull is currenty not working because of some
> > missed checks where behavior should match imx6ul.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > ---
> > ?arch/arm/mach-imx/mxc.h?????| 6 ++++++
> > ?arch/arm/mach-imx/pm-imx6.c | 6 ++++--
> > ?2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> > index 34f2ff6..e00d626 100644
> > --- a/arch/arm/mach-imx/mxc.h
> > +++ b/arch/arm/mach-imx/mxc.h
> > @@ -39,6 +39,7 @@
> > ?#define MXC_CPU_IMX6SX		0x62
> > ?#define MXC_CPU_IMX6Q		0x63
> > ?#define MXC_CPU_IMX6UL		0x64
> > +#define MXC_CPU_IMX6ULL		0x65
> Since you are adding a new CPU type, you should probably patch
> imx_soc_device_init() for it as well.

Ok, I will resend as a 2-patch series.

BTW, it actually seems to me that setting BM_CLPCR_BYP_MMDC_CH0_LPM_HS
on imx6sl/sx/ul/ull is not actually needed. That bit (19) is documented
as "reserved" in the Reference Manual and likely ignored by hardware.

As far as I understand the MMDC on imx6qdl has two channels and unless
2-channel mode is enabled (not currently supported) the handshake with
CH1 needs to be disabled. Other reduced chips only have one MMDC
channel and that is CH1 (CH0 was removed) and nothing needs to be done
from them. The only important thing is to avoid setting
BM_CLPCR_BYP_MMDC_CH1_LPM_HS.

However perhaps what I am saying is wrong for some early chip versions?
Because this behavior of setting BM_CLPCR_BYP_MMDC_CH0_LPM_HS has been
in the kernel for a long time.

--
Regards,
Leonard
