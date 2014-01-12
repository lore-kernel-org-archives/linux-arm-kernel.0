From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jan 2014 10:37:57 +0000
Subject: [PATCH v2 26/28] drm/i2c: tda998x: code optimization
In-Reply-To: <20140112111420.6258799a@armhf>
References: <20140109120725.0b0f3e55@armhf>
 <20140111185509.GL15937@n2100.arm.linux.org.uk>
 <20140112092201.764fb09c@armhf>
 <20140112094533.GP15937@n2100.arm.linux.org.uk>
 <20140112111420.6258799a@armhf>
Message-ID: <20140112103756.GQ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 11:14:20AM +0100, Jean-Francois Moine wrote:
> On Sun, 12 Jan 2014 09:45:33 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Sun, Jan 12, 2014 at 09:22:01AM +0100, Jean-Francois Moine wrote:
> > > On Sat, 11 Jan 2014 18:55:09 +0000
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > 
> > > > On Thu, Jan 09, 2014 at 12:07:25PM +0100, Jean-Francois Moine wrote:
> > > > > This patch reduces the number of I2C exchanges by setting many bits in
> > > > > one write and removing a useless write.
> > > > > 
> > > > > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > > > > ---
> > > > >  drivers/gpu/drm/i2c/tda998x_drv.c   | 10 ++++------
> > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> > > > > index 6b4f6d2..d3b3f3a 100644
> > > > > --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > > > > +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > > > > @@ -751,10 +751,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
> > > > >  	}
> > > > >  
> > > > >  	reg_write(priv, REG_AIP_CLKSEL, clksel_aip);
> > > > > -	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT);
> > > > > +	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
> > > > 
> > > > This patch clearly hasn't even been build tested, so I doubt there's
> > > > much point reviewing this or the following patches.  From a quick scan
> > > > of the following patches, this never got fixed so the following patches
> > > > can't have been build tested either.
> > > 
> > > I don't see what can be the problem with this patch. It does not change
> > > anything in the logic. About testing, it is applied to my Cubox kernel
> > > for more than 4 months and everything works correctly.
> > > 
> > > I will move the following comment a bit upwards. Maybe the code will be
> > > clearer.
> > 
> > You're replacing ");" with "|" here, which is not legal C.  Parenthesis
> > must be balanced and statements must be terminated.
> 
> !? they are:
> 
> -	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT);
> +	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
>  
>  	/* Enable automatic CTS generation */
> -	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_ACR_MAN);
> +					AIP_CNTRL_0_ACR_MAN);
> 
> gives:
> 
> 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
> 
> 	/* Enable automatic CTS generation */
> 					AIP_CNTRL_0_ACR_MAN);

Yuck, that's absolutely horrid.  No wonder I mis-read it.  NAK for bad
and confusing style.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
