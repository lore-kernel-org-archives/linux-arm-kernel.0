From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Thu, 15 Dec 2011 11:13:02 +0000
Subject: [PATCH v5 10/11] davinci: dm644x: add support for v4l2 video
 display
In-Reply-To: <4EE87F08.6080309@mvista.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
 <1323775415-24504-11-git-send-email-manjunath.hadli@ti.com>
 <4EE87F08.6080309@mvista.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F750167B5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,
On Wed, Dec 14, 2011 at 16:18:40, Sergei Shtylyov wrote:
> Hello.
> 
> On 13-12-2011 15:23, Manjunath Hadli wrote:
> 
> > Create platform devices for various video modules like venc,osd, vpbe 
> > and v4l2 driver for dm644x. Change the dm644x_init_video to make room 
> > for display config, and register the vpfe or vpbe devices based on the 
> > config pointer validity to make sure boards without vpfe or vpbe can 
> > be built with minimal changes.
> 
> > Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
> [...]
> 
> > diff --git a/arch/arm/mach-davinci/dm644x.c 
> > b/arch/arm/mach-davinci/dm644x.c index 6c034fd..2e408d8 100644
> > --- a/arch/arm/mach-davinci/dm644x.c
> > +++ b/arch/arm/mach-davinci/dm644x.c
> [...]
> > @@ -654,7 +654,127 @@ static struct platform_device dm644x_vpfe_dev = 
> > {
> [...]
> > +#define DM644X_OSD_REG_BASE		0x01c72600
> [...]
> > +#define DM644X_VENC_REG_BASE		0x01c72400
> 
>     Why not without _REG, like all the other #define's?
Ok.
> 
> > +static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
> > +				   unsigned int mode)
> > +{
> > +	int ret = 0;
> > +	void __iomem *vpss_clkctl_reg;
> > +
> > +	vpss_clkctl_reg = DAVINCI_SYSMODULE_VIRT(0x44);
> 
>     Why not in the initializer?
Because it is used only for clock control. I think it is fine here.
> 
> > +	switch (type) {
> > +	case VPBE_ENC_STD:
> > +		writel(0x18, vpss_clkctl_reg);
> > +		break;
> > +	case VPBE_ENC_DV_PRESET:
> > +		switch ((unsigned int)mode) {
> 
>     'mode' is already 'unsigned int'.
Ok.
Thx,
-Manju
> 
> WBR, Sergei
> 
> 
