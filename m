From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 09:56:27 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120108125156.GB2203@richard-laptop>
References: <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <20120108125156.GB2203@richard-laptop>
Message-ID: <20120109015625.GE1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 08:51:59PM +0800, Richard Zhao wrote:
...
> > > So, this does appear to be conflating the two things: The definition of
> > > what pins are in a pingroup, and the mux function for a particular
> > > setting of that pingroup. I think you need separate nodes for this.
> > > 
> > At least for imx, we do not have mux function setting for pingroup.
> > Instead, it only applies to individual pin.
> I think it depends on function definition of pinmux driver. For the
> imx example patch, it's one-to-one.

It should depend on particular imx soc pinmux design rather than
pinmux driver.  If it's always one-to-one case, we do not need
pinmux at all.  Aisheng's patch just did not enumerate all the groups
for given function.  Instead, it puts a couple simple examples there
for demonstration.

...

> > > 		uart4func: func at 1 {
> > > 			func-name = "uart4";
> > > 			locations = <&bargrp &bazgrp>;
> > > 			mux-value = <6 3>;
> > > 		};
> > 
> > I prefer to have function node defined in <board>.dtsi, since it's
> > all about defining phandle to the correct pingroup, which should be
> > decided by board design.
> group and function are one-to-one mapped for imx.

Again, it's not the case.

> So if you put function
> in board dts, why not put pin group there too?

If we put pingroup data in <board>.dts, the data will be likely get
duplicated a lot in different board dts files.  For example, if
imx6q-sabrelite chooses the same pingroup for usdhc3 and usdhc4 as
imx6q-arm2, the pingroup data will be duplicated between imx6q-arm2.dts
and imx6q-sabrelite.dts.

On the contrary, putting pingroup data in <soc>.dtsi and having function
node in <board>.dts with phandle pointing to the correct pingroup will
help avoid such data duplication.

-- 
Regards,
Shawn
