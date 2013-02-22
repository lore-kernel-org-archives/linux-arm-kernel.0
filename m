From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Feb 2013 13:52:04 +0800
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
Message-ID: <20130222055203.GB27371@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 11:36:36AM -0600, Matt Sealey wrote:
> On Wed, Feb 20, 2013 at 11:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Wed, Feb 20, 2013 at 06:03:39PM -0600, Matt Sealey wrote:
> >> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D
> >>
> > Do you see any downgrade side that the series introduces over the
> > existing implementation?
> 
> Because it replaces the horribly stupid existing implementation with
> something that doesn't solve the fundamental logical problems caused
> by the existing implementation.

When did I say that the series is targeting to solve those "fundamental
logical problems" in *your* view?

...

> What you've fixed it to do, as I read this patch, is this;
> 
> <arbitrary_pin_name pad_mode>
> 
No, it's not arbitrary_pin_name.  It's pin function name which comes
from hardware manual.  It may not exactly match the public reference
manual, but they are obvious to be identified.  For imx6q pad SD2_DAT1
example, the manual says:

Select 1 of 6 iomux modes to be used for pad: SD2_DAT1.
  000 ALT0 ? Select signal SD2_DATA1.
  001 ALT1 ? Select signal ECSPI5_SS0.
  010 ALT2 ? Select signal EIM_CS2.
  011 ALT3 ? Select signal AUD4_TXFS.
  100 ALT4 ? Select signal KEY_COL7.
  101 ALT5 ? Select signal GPIO1_IO14.

And imx6q-pinfunc.h gives:

  MX6Q_PAD_SD2_DAT1__USDHC2_DAT1
  MX6Q_PAD_SD2_DAT1__ECSPI5_SS0
  MX6Q_PAD_SD2_DAT1__WEIM_WEIM_CS_2
  MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS
  MX6Q_PAD_SD2_DAT1__KPP_COL_7
  MX6Q_PAD_SD2_DAT1__GPIO_1_14

Trust me, no one would manually and arbitrarily write down those huge
number of names.  It comes from Freescale BSP code which is in turn
retrieved from an early design database during BSP pre-coding phase.
It happens all the time that the names in the final document change
than early developing one.

> which the preprocessor expands to;
> 
> <reg_mux mux_mode reg_insel insel_mode reg_pad pad_mode>
> 
> The real problem here is as follows;
> 
> 1) the pin name and function name are still completely arbitrary (in
> so far as the old iomux.h macros way, the newer iomux-v3.h way, the
> current bindings and the new binding you're pushing do not match the
> CPU documentation at all)
> 
No, it's not true, as explained above.

> 2) copy pasting a line of 5 values from an example document and adding
> your pad mode bits to the end is no more time consuming or
> space-consuming than copying a 38-character macro name.

DTB is meant to be machine-parseable, but DTS is meant to be
human-readable because it's edited by human-being, and macro name
is obviously more friendly here.

...

> 3) macros can be wrong and they will inherit into every device tree,
> breaking every board that uses them.

The macros should eventually come from some tool/program and design
database.  It should stand little chance to be wrong.  Even there is
something wrong with the macros, it should be noticed from the very
beginning, exactly because it will get any board device tree using
the macros wrong.

With the help of macros, patch #3 changes the PIN_FUNC_ID from an
integer to a tuple of integers without touching any DTS files at all.

Shawn
