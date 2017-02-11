From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sat, 11 Feb 2017 05:33:09 +0200
Subject: [linux-sunxi] [PATCH] Add Master Sample Data Mode for SPI
In-Reply-To: <CAEz5UgEGO+3CZ6DGhUgXqHpvXc7PBpsujER7LrVi2sfY7Vmvsw@mail.gmail.com>
References: <20170210220247.8478-1-viniciusfre@gmail.com>
 <20170211045316.12d939ae@i7>
 <CAEz5UgEGO+3CZ6DGhUgXqHpvXc7PBpsujER7LrVi2sfY7Vmvsw@mail.gmail.com>
Message-ID: <20170211053309.2759af28@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Feb 2017 00:05:42 -0300
Vinicius Maciel <viniciusfre@gmail.com> wrote:

> Em 10 de fev de 2017 23:53, "Siarhei Siamashka" <siarhei.siamashka@gmail.com>
> escreveu:
> 
> > On Fri, 10 Feb 2017 19:02:47 -0300
> > Vinicius Maciel <viniciusfre@gmail.com> wrote:
> >  
> > > In order to work appropriately, the max11043 ADC chip and probably
> > > others, needs SPI master samples the data at the correct edge. From
> > > max11043 datasheet: "The data at DIN is latched on the rising edge
> > > of SCLK". Same to DOUT.
> > >
> > > This patch add Master Sample Data Mode bit in normal sample mode.
> > >
> > > Signed-off-by: Vinicius Maciel <viniciusfre@gmail.com>
> > > ---
> > >  drivers/spi/spi-sun4i.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> > > index c5cd635c28f3..6325be2ce8d9 100644
> > > --- a/drivers/spi/spi-sun4i.c
> > > +++ b/drivers/spi/spi-sun4i.c
> > > @@ -44,6 +44,7 @@
> > >  #define SUN4I_CTL_CS_MANUAL                  BIT(16)
> > >  #define SUN4I_CTL_CS_LEVEL                   BIT(17)
> > >  #define SUN4I_CTL_TP                         BIT(18)
> > > +#define SUN4I_CTL_SDM                                BIT(20)
> > >
> > >  #define SUN4I_INT_CTL_REG            0x0c
> > >  #define SUN4I_INT_CTL_RF_F34                 BIT(4)
> > > @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device  
> > *dev)  
> > >       }
> > >
> > >       sun4i_spi_write(sspi, SUN4I_CTL_REG,
> > > -                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER |  
> > SUN4I_CTL_TP);  
> > > +                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP  
> > |  
> > > +                     SUN4I_CTL_SDM);
> > >
> > >       return 0;
> > >  
> >
> > Thanks! That's a good catch. This particular bit is actually set in the
> > reset default register value, according to the Allwinner A20 manual.
> > But on Allwinner A10 and Allwinner A13 it is documented as unused and
> > can't be changed (it remains zero even if we try to modify it).
> >
> > So looks like only A20 is affected, because the kernel currently sets a
> > non-standard mode, deviating from both Allwinner's default and normal
> > SPI behaviour.
> >
> > You still need to update the summary line to add all the necessary
> > sunxi and spi specific prefixes (see similar commits). Also a similar
> > fix most likely needs to be applied to the spi-sun6i.c file too (due
> > to the copy-paste curse and code duplication), but I'm not sure if it
> > needs to be a part of this patch or a separate one.
> >
> > Reviewed-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

> Hi Siarhei,
> 
> I was really aiming only A20 in this patch.

Well, regardless of whether you like it or not, A10 and A13 are also
currently using the same code path. So they are potentially affected.

Yes, we may try to introduce a separate compatible property to describe
this particular new A20-specific feature, which did not exist in the
older A10/A13 SoCs and then set this bit only for A20 in the SPI
driver. But since A20 is backwards compatible with A10/A13 (as long
as we don't override the default values of the reserved bits in hardware
registers) and enabling this particular feature is apparently undesired
(it breaks your max11043 ADC use case), it does not seem to be necessary
to me right now. Maxime and others may have a different opinion though.

As for the spi-sun6i.c file, somebody else might encounter the same
problem on A23/A33/H3/H5/A83T/A64 later and waste time debugging
something that had been already resolved by you now. Also having the
spi-sun4i.c and spi-sun6i.c files diverge even more than they are now
is not nice.

-- 
Best regards,
Siarhei Siamashka
