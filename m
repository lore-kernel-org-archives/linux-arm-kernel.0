From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 29 Aug 2013 21:20:42 +0200
Subject: [PATCHv3 1/4] arm: dts: Add clock entries for timers in SOCFPGA
In-Reply-To: <1377791718.26261.16.camel@linux-builds1>
References: <1377118427-20644-1-git-send-email-dinguyen@altera.com>
 <20130828153127.GA17806@pengutronix.de>
 <1377791718.26261.16.camel@linux-builds1>
Message-ID: <20130829192042.GC10398@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Thu, Aug 29, 2013 at 10:55:18AM -0500, Dinh Nguyen wrote:
> Hi Steffen,
> > > @@ -486,28 +482,32 @@
> > >  			interrupts = <1 13 0xf04>;
> > >  		};
> > >  
> > > -		timer0: timer0 at ffc08000 {
> > > +		timer at ffc08000 {
> > 
> > No. Why? Than I can not write something like
> > 
> > &timer0 {
> > 	clock-frequency = <100000000>;
> > };
> > 
> > and would have to reference the whole tree ala
> > 
> > / {
> > 	soc {
> > 		timer at ffc08000 {
> > 			clock-frequency = <100000000>;
> > 		};
> > 	};
> > };
> > 
> > in a boardspecific or SoC specific file (see below).
> 
> Agreed. Will adjust accordingly.
> 

Good.

> > 
> > > diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
> > > index 698dde9..c1af01c 100644
> > > --- a/arch/arm/boot/dts/socfpga_cyclone5.dts
> > > +++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
> > >  
> > > diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> > > index 6f23121..72ff14c 100644
> > > --- a/arch/arm/boot/dts/socfpga_vt.dts
> > > +++ b/arch/arm/boot/dts/socfpga_vt.dts
> > 
> > Leads me to a question about terminology: Is the cyclone5 an actual board?
> > AFAIK it is. And the Cyclone 5 FPGA is also called socfpga? Is that correct?
> > But then, seeing that, in an other patch, you add two different sysmgr addresses to
> > the socfpga_vt and socfpga_cyclone5, there are different socfpgas?
> 
> Yes, sofpga_cyclone5.dts is the devkit that is manufactured by Altera.
> socfpga_vt.dts is a virtual platform for SOCFPGA. You can get the
> virtual platform from Synopsis. It mimics everything except the FPGA. 
> 

Uh, nice. I will check out the vt.

> socfpga is the base SOC with a Cyclone 5 FPGA on it. I'll be upstreaming
> socfpga_arria5 soon, which has the SOCFPGA + Arria 5 FPGA.
> 

Hm, okay. That might lead to confusion then...

> > 
> > I want to write a devicetree for the SoCkit. It has a Cyclone 5 on it.
> > So naturally I would now go and include the socfpga_cyclone5.dtsi, with all the
> > cyclone5 stuff and just add my board specific stuff in a socfpga_sockit.dts.
> > But there is no socfpga_cyclone5.dtsi, just the socfpga_cyclone5.dts, which itself
> > seems to be a board...
> 
> socfpga.dtsi is the base DTSI for the platform. In hindsight, I should
> have named it a bit different, but for now socfpga_cyclone5 is for the
> board.
> 

and we should make the socfpga_cyclone5 a dtsi. I can do that.
It's early in development and I see no reason not to fix it now.
We have seen quite a lot of rearrangment with the imx6 for example. No need to
duplicate it, if we know it beforehand.


> > 
> > So, how should we reorder the current dts (as I tested with current mainline, the
> > support is completely broken out of the box, but works fine with your patches that
> > are floating around, there should be no users as of now)?
> 
> Not sure what you mean by broken. I was able to boot 3.11-rc7 just now
> using an initramfs. As you can already tell, I'm doing my best to get
> more support for the platform upstream, but it will take time.
> 

Yeah, broken might have been a bit harsh :-D
But my first experience with the mainline kernel was a scrambled serial console
and hanging system as soon as you use the ethernet/ip=dhcp.
And the SD wasn't working for me, too. But those SD cards are really more problematic
than one might think, so...

But as I said: with your patch series, both is working. Looking forward to your
next versions of those patches.
Now I have a hanging system, when I add the at24 on i2c-0, what ever might be
the reason for that :-D

BTW: you don't happen to have any insight in what crazy things you do with the CRC32
in your prebootloader, do you? Been trying some time to calculate the crc, but never
got to the one the mkpimage generates. It doesn't seem to be what crc32 or chksum
calculate or the datasheet is missing some essential info for me to understand it.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
