From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 13 Jan 2012 10:16:36 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120113034558.GA12184@S2101-09.ap.freescale.net>
References: <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A6E5@HQMAIL01.nvidia.com>
 <20120112033941.GH20968@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DCC@HQMAIL01.nvidia.com>
 <20120113034558.GA12184@S2101-09.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D1F9D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Thursday, January 12, 2012 8:46 PM:
> On Thu, Jan 12, 2012 at 12:46:52PM -0800, Stephen Warren wrote:
> > Shawn Guo wrote at Wednesday, January 11, 2012 8:40 PM:
> > > On Wed, Jan 11, 2012 at 10:17:40AM -0800, Stephen Warren wrote:
> > ...
> > > > So, my position is that:
> > > >
> > > > * Something (either the pinctrl driver, or the SoC .dtsi file) should
> > > > enumerate all available muxable entities that exist in the SoC (pins for
> > > > IMX, groups for Tegra).
> > >
> > > Yes, we enumerate all available pins in pinctrl driver for imx.
> > >
> > > > * Something (either the pinctrl driver, or the SoC .dtsi file) should
> > > > enumerate all the available functions that can be assigned to a muxable
> > > > entity.
> > >
> > > In theory, yes.  But I hope you would agree we do not need to
> > > necessarily do this for case like imx.
> >
> > Discussing just the Linux driver internals right now; ignoring device
> > tree:
> >
> > Pinctrl won't let you use a function on a pin/group if that function
> > isn't enumerated and doesn't list that pin/group as a valid location
> > for that function. Given that, I'm not sure how you can avoid enumerating
> > all functions and their legal locations?
>
> I agree with you that we should enumerate all available functions in
> pinctrl driver, if we want to stick to the original pinctrl subsystem
> design.  But as you can see, this enumeration for case like imx is
> going to be huge data.  We would rather have both pingroup and function
> defined in respective board file as needed.  I know doing so actually
> violates the original idea of pinctrl subsystem, and will have data
> duplication among different board files.  But that's a compromise.
> And even Linus.W agreed on this compromise in the thread below.
> 
> http://thread.gmane.org/gmane.linux.kernel/1223968/focus=1224470
> 
> All above is about non-dt case.  For dt case, we will have both pingroup
> and function describe in dts, and that's way we are purchasing.

For reference, that message is:

Linusw wrote:
> On Mon, Dec 5, 2011 at 3:43 AM, Dong Aisheng <dongas86 <at> gmail.com> wrote:
> > My current plan is to define all (might be frequently) used functoin
> > and groups for the exist upstreamed board like 53 Loco and etc, is
> > that ok?
>
> Yes, but do it in respective board file, so if we say, one day
> stops to support a certain board we can just delete that board
> file and be done with it.
>
> Plus this gives us a nice separation as we move toward
> device trees. (I think.)

My interpretation of what Dong wrote there is "I'm only going to define
the functions and groups that are actually in use by upstream boards,
not everything the SoC supports". However, your (Shawn's) references to
the email, it sounds like you're interpreting what Dong wrong as "I'm
going to define some virtual groups that don't exist in HW but represent
common use-cases of the HW".

Admittedly, the wording of Linusw's actually seems to agree more with how
you're interpreting what Dong said, but in that case, I don't think his
reply makes sense - the whole purpose of the mux mapping table is to
represent the board-specific configuration. If we're going to circumvent
it, we should completely remove it from the pinctrl subsystem, rather than
having some boards avoid using it by creating virtual pin groups instead.

> > > For imx6q example, we have 193 pins as the muxable entities, and for
> > > each of those pin, there are 8 alternative functions.  Let's see what
> > > we will have if we enumerate all the available functions for each pin.
...
> > > We simply do not want to over bloat imx6q pinctrl driver with such
> > > enumeration.
> >
> > Yes, I see you'd end up with a huge number of function definitions here.
> >
> > You may be able to avoid this by changing the way you name/number the
> > functions though.
> >
> > The example above has a unique function name for every individual signal.
> > instead, can you name functions based on the controller they connect to?
> >
> > So, instead of having:
> >
> > IMX6Q_PAD_SD2_DAT1__USDHC2_DAT1
> > IMX6Q_PAD_SD2_DAT2__USDHC2_DAT2
> > IMX6Q_PAD_SD2_DAT3__USDHC2_DAT3
> > IMX6Q_PAD_SD2_DAT4__USDHC2_DAT4
> >
> > Can you replace this with a single:
> >
> > IMX_FUNC_USDHC2
>
> So all 'enum imx6q_pad_*' goes away, and instead, we define macros
> IMX_FUNC_* at controller basis, correct?

Yes, something like that. The best set to choose probably differs based
on the SoC and its mux capabilities. But thinking more, if you're going
along this kind of route, I'd prefer to just define the "func0", "func1",
... "func7" functions that represent the raw HW selection instead.

-- 
nvpublic
