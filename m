From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Aug 2012 07:44:36 +0200
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
Message-ID: <20120815054436.GK2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(Cc += devicetree-discuss at lists.ozlabs.org)

On Wed, Aug 15, 2012 at 11:59:18AM +0800, Dong Aisheng wrote:
> On 15 August 2012 03:37, Matt Sealey <matt@genesi-usa.com> wrote:
> > On Tue, Aug 14, 2012 at 2:20 AM, Dong Aisheng <dong.aisheng@linaro.org> wrote:
> >> On 13 August 2012 23:12, Matt Sealey <matt@genesi-usa.com> wrote:
> >>> I have a minor nit; while renumbering the pinctrl definitions is
> >>> laudable and device trees can match, there are 16 other pin controls
> >>> below EIM_D16 - this makes the start of the IOMUXC pin definitions
> >>> actually be the value calculated by (iomuxc_base + 0x300 + (4*16) +
> >>> (pin_id*4)).
> >>
> >> What do you mean of this value calculated?
> >
> > Well, it just seems the datasheet has been read from the point of view
> > of the SW_CTRL settings (pad pullups, drive strength etc.) to define
> > the enums; every pin setting in order from IOMUXC_BASE + 0x3f0 (sorry
> > I mistyped) has been entered as an enum into this list. Then a table
> > has been generated using these enums to supply a pin id. Then this pin
> > id is not relevant anymore; it actually gets referenced by it's
> > *offset into the table*.
> >
> Not exactly, probably.
> Basically we follow the mux reigster offset to define pin id, however,
> there're also some pads may not have mux function but only config
> which also has a pin id
> and vice versa.
> Those pins are not ordered by it's mux regsiter offset.
> 
> Actually I did not manually search all those pins, instead, i just
> using the exist ones:
> arch/arm/plat-mxc/include/mach/iomux-mx51.h
> Since this exist headfile already covers this case.
> 
> > In this case, basically the code misses a few pins which have ALT
> > settings but perhaps not always the ability to change pad control -
> > EIM_DA5 to 15 are a good example.
> >
> As i said, we already defined those pin ids.
> 
> > Probably better would be to define the binding almost exactly as it
> > was done in the old method; iomux_v3_cfg_t took into account the three
> > register offsets possible for the pin (SW_MUX_CTL, SW_PAD_CTL and IPP)
> > and the three values to be put into those registers.
> >
> > This has been reduced down in pinctrl to what I find quite strange,
> > which is a completely arbitrary pin "id" mapping, which indirectly
> > references an entry in a table by index which is why pin 1 as a start
> > looks odd.
> >
> Start with pin 1 is a bug which caused by my mistake during the early
> data conversion.
> 
> > If the binding is entirely i.MX-specific or even i.MX51-specific then
> > why not define the pins in the device tree the "old" iomux_v3_cfg_t
> > way, which is the way they are in the table of imx_pin_regs;
> >
> >       IMX_PIN_REG(MX51_PAD_EIM_D16, 0x3f0, 0x05c, 5, 0x000, 0), /*
> > MX51_PAD_EIM_D16__AUD4_RXFS */
> >
> > 0x3f0 is the SW_PAD_CTL, 0x05c is the SW_MUX_CTL, 5 is the ALT mode,
> > 0x000 is the IPP reg, and 0 the IPP value.
> >
> > So fsl,iomux-pins = <0x3f0 0x85 0x05c 5 0 0 ... > (PAD, settings, MUX,
> > mode/sion, IPP, select - in that order) would be a valid pin
> > definition and require no table. Sure, the offsets are device specific
> > but then the arbitrary numbering is too.
> > This way old iomux controls
> > can be re-derived for people who use the old method in old kernels, or
> > use U-Boot with iomux-v3.h taken from Linux (MX6 got ported, I am
> > porting the Efika to it on MX5 for U-Boot right now). Also that huge
> > table goes away - it can be built at runtime, along with the
> > PAD_NAME__ALT_MODE_NAME description.
> >
> I can't agree this is better than the exist one now.
> It's hard to use in device tree.
> And how would you parse the pin id from this data array?
I admit I didn't follow completely the calculation suggestion by Matt,
but I think in general he has a point. This is more or less what I
thought when I built the imx35 pinctrl driver.

With the current approach (i.e. put the pinfuncs in some order that
seems sensible today and then referencing them by index according to
that ordering) you really get into troubles if you have to add a new
function. You have to add it to the end to not break existing device
trees and so the ordering is broken.

Also "11" has no obvious relation to MX35_PAD_COMPARE__SDMA_EXTDMA_2
other than a match if you grep over the binding docs (or the driver).
While "0x32c, 0x008, 7, 0x0, 0" is longer and looks more ugly the
mapping is obvious and so IMHO preferable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
