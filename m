From: megi@xff.cz (=?UTF-8?Q?Ond=C5=99ej?= Jirman)
Date: Thu, 20 Jul 2017 14:12:09 +0200
Subject: [linux-sunxi] [PATCH v4 4/5] ARM: sunxi: h3/h5: switch
 apb0-related clocks to r_ccu
In-Reply-To: <a934bb1292328400004e58c886ccd693@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
 <20170404095100.18649-5-icenowy@aosc.io> <1500505173.23770.1.camel@xff.cz>
 <a934bb1292328400004e58c886ccd693@aosc.io>
Message-ID: <1500552729.29912.1.camel@xff.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

icenowy at aosc.io p??e v ?t 20. 07. 2017 v 16:21 +0800:
> ? 2017-07-20 06:59?Ond?ej Jirman ???
> > Hi,
> > 
> > Icenowy Zheng p??e v ?t 04. 04. 2017 v 17:50 +0800:
> > > From: Icenowy Zheng <icenowy@aosc.xyz>
> > > 
> > > Now we have driver for the PRCM CCU, switch to use it instead of
> > > old-style clock nodes for apb0-related clocks in sunxi-h3-h5.dtsi .
> > > 
> > > The mux 3 of R_CCU is still the internal oscillator, which is said to 
> > > be
> > > 16MHz plus minus 30%, and get a measured value of 15MHz~16MHz on my 
> > > two
> > > H3 boards and one H5 board.
> > 
> > There's issue with the new r_ccu that breaks r_i2c. (no devices can be
> > found on the bus). Reverting this patch fixes the issue with the I2C
> > controller. (everything else being the same)
> > 
> > Here's the code I'm using: https://github.com/megous/linux/commits/oran
> > ge-pi-4.12
> > 
> > The last commit is the revert.
> > 
> > The issue manifests itself by non-working DVFS, because kernel lacks
> > access to SY8106A regulator, because r_i2c doesn't work with sunxi-ng
> > clock driver (sun8i-r).
> > 
> > Relevant difference in registers between working/non-working state is
> > just this (diff -u):
> > 
> >  0x01f02400 = 0x00000000
> >  0x01f02404 = 0x00000000
> > -0x01f02408 = 0x00000091
> > +0x01f02408 = 0x00000095 DATA register inisde the I2C controller
> >  0x01f0240c = 0x00000044
> >  0x01f02410 = 0x000000f8
> > -0x01f02414 = 0x00000059
> > +0x01f02414 = 0x00000000 CLOCK setup register inside the I2C controller
> >  0x01f02418 = 0x00000000
> >  0x01f0241c = 0x00000000
> >  0x01f02420 = 0x0000003a
> > 
> > It looks like the new sunxi-ng clock driver causes the I2C driver to
> > not correctly configure the CLOCK register. I don't know why and I'm
> > not sure how to deal with this. Any ideas what can I do next?
> 
> Could you apply the patches at [1] and [2] to U-Boot and re-try with
> r_ccu? They switched the CPUs clock of r_ccu to non-secure mode, which
> makes it possible to be accessed from the kernel running in non-secure.

I have verified that r_ccu works correctly with the u-boot patches on
H3 and H5.

Thank you very much for looking into the issue. :)

regards,
  o.

> I think these patches can solve this problem.
> 
> [1] https://patchwork.ozlabs.org/patch/791414/
> [2] https://patchwork.ozlabs.org/patch/791415/
