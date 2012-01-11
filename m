From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 10:28:43 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120108125156.GB2203@richard-laptop>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <20120108125156.GB2203@richard-laptop>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A6EF@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao wrote at Sunday, January 08, 2012 5:52 AM:
> On Sat, Jan 07, 2012 at 09:54:48PM +0800, Shawn Guo wrote:
> > On Fri, Jan 06, 2012 at 10:03:07AM -0800, Stephen Warren wrote:
...
> > > Without separate nodes, there will eventually be a lot of duplication.
> > > A made-up example of the same uart4grp allowing either of two functions
> > > uart3, uart4 to be muxed out onto it:
> > >
> > > aips-bus at 02000000 { /* AIPS1 */
> > > 	iomuxc at 020e0000 {
> > > 		pinctrl_uart4_3: uart4 at option_3 {
> > > 			func-name = "uart3";
> > > 			grp-name = "uart4grp";
> > > 			grp-pins = <107 108>;
> > > 			num-pins = <2>;
> > > 			grp-mux = <3 3>;
> > > 			num-mux = <2>;
> > > 		};
> > > 		pinctrl_uart4_4: uart4 at option_4 {
> > > 			func-name = "uart4";
> > > 			grp-name = "uart4grp";
> > > 			grp-pins = <107 108>;
> > > 			num-pins = <2>;
> > > 			grp-mux = <3 3>;
> > > 			num-mux = <2>;
> > > 		};
> > > 	}
> > > };
> > >
> > > Now I understand that initially you aren't going to type out the complete
> > > list of every available option into imx6q.dtsi because it's probably huge,
> > > but the binding does need to allow you to do so without duplicating a lot
> > > of data, because eventually you'll get boards that use a larger and larger
> > > subset of all the options, so the number you need to represent at once in
> > > imx6q.dtsi will grow.
>
> If we don't want to lose flexibity, the pin group number will be huge
> than you think. For example, 16bit display interface, has two alternatives
> for every pin. The group number will be 2^16.

I originally misunderstood IMX HW; I though the HW muxed at a group-of-
pins level (as Tegra does), but actually it's muxing at a per-pin level,
hence some of what I wrote may have been confusing to people familiar
with how IMX HW really works.

So yes, I definitely agree that representing all possible mux combinations
(combinations of pins in use and the mux function selected for them) could
be extremely large and we don't want to enumerate /that/ list anywhere; in
.dts files or in the pinctrl driver.

So, as a result of that, and as I mentioned in my immediately previous
email, I don't think those two nodes "uart4 at option_3", "uart4 at option_4"
should be in the SoC .dtsi file.

Later you wrote:

> group and function are one-to-one mapped for imx. So if you put function
> in board dts, why not put pin group there too?

I agree, I think: Everything that defines the board-specific usage of
the pinmux should be part of the board's .dtsi file, not the SoC's .dtsi
file.

-- 
nvpublic
