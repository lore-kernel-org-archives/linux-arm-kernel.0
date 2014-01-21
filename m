From: b32955@freescale.com (Huang Shijie)
Date: Tue, 21 Jan 2014 10:29:26 +0800
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <CAD6G_RTwMJ5DgkCB7wcYw+2p---DqU4KCVJ3CUnHFfCJ0ui_Jw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
 <20140117065401.GA6140@shlinux2.ap.freescale.net>
 <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
 <52DB3864.2040606@gmail.com>
 <CAD6G_RTwMJ5DgkCB7wcYw+2p---DqU4KCVJ3CUnHFfCJ0ui_Jw@mail.gmail.com>
Message-ID: <20140121022925.GA18529@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 03:39:34PM +0530, Jagan Teki wrote:
> > Just think about that how do you code your driver for SPI NOR _without_ this
> > framework:
> > do your driver need to call the m25p80.c? if you do call the m25p80.c, you
> > actually write your so-called "two drivers" :)
> 
> I'm still not convinced here, sorry!
> Let me explain more with example, Just take your (q)spi controller as an example
> B_FSL1 designed with - serial flash
> B_FSL2 designed with - touch screen
> 
> With this design If we follow current we just need one controller
> driver (drivers/spi/spi-fsl.c)
> to serve touch screen and serial flash from upper layers.
> 
> MTD core                Input core
> -------------           -------------------------------
> m25p80.c             spi  touchscreen driver  (drivers/input/touchscreen)
> ----------------------------------------------------
>                           SPI core
> ----------------------------------------------------
>       controller driver (drivers/spi/spi-fsl.)
> ----------------------------------------------------
> 
> But with your new SPI-NOR
> 
> MTD core
> ------------
> SPI-NOR              Input core
> -----------           ------------------
> fsl-quadspi.c     spi  touchscreen driver  (drivers/input/touchscreen)
> ----------------      ------------------------------
>                          SPI Core
>                          -----------------------------
>                          controller driver (drivers/spi/spi-fsl.c)
>                          -----------------------------------------
> 
There is no relationship with the fsl-quadspi.c. 

It should be like this:
 MTD core
 ------------
 SPI-NOR  framework                       Input core
 -----------                              ------------------
 m25p80.c                                 spi  touchscreen driver  (drivers/input/touchscreen)
 ----------------                         ------------------------------
 SPI Core                                 SPI Core
 -----------------------                  -----------------------------
 drivers/spi/spi-fsl.c                    controller driver (drivers/spi/spi-fsl.c)
 --------------------------               -----------------------------------------
 

> Here see we have two separate drivers for the same controller as it offers two
> functionalities. and also it never talk to Linux SPI subsystem which is not a
> good for me as intern hw is SPI-based it must talk to subsystem to make use of
> Linux SPI API's.
> 
> And also you mentioned SPI-NOR controller is not a SPI controller what does that
> means because it's a NOR flash which is of SPI protocol based.

The SPI controller (or spi bus controller) only handles the _byte_ streams;
while the spi-nor controller, such as fsl-quadspi.c, can has to __known__
the exact SPI NOR command to find the proper LUT.

Please read the thread i ever posted in the previous email.

> 
> I understand that your framework doing good things in matured manner, but
> seems like it's confuse to me to follow common standards - Just my
> opinion, may be I'm incorrect.
> 
> One more thing question - I have 1-wire spi controller which I was
> used for flash in
> one board and keyboard in another board, so if I follow your framework
> I need to write
> a driver in drivers/mtd/spi-nor/foo-spi.c and one more in
> drivers/spi/spi-foo.c - correct?

Please read the device tree node of your controller, find the code like

...................................................
	flash: m25p80 at 0 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "st,m25p32";
		spi-max-frequency = <20000000>;
		reg = <0>;
	};
...................................................

if you call the m25p80,  you do not need to change anything. 

thanks
Huang Shijie
