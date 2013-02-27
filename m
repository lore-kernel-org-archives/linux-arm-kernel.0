From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 27 Feb 2013 12:16:20 -0600
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <20130227074404.GD1906@pengutronix.de>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
 <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
 <20130227074404.GD1906@pengutronix.de>
Message-ID: <CAKGA1bmqdCiocc_O6hU3ym6uJ-bAjwKMNrt43Qs_dkjEGpX-KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 1:44 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Feb 27, 2013 at 12:51:56AM -0600, Matt Sealey wrote:
>> For example, please explain to me why;
>>
>> MX51_PIN_EIM_23__GPIO1_2 0x6528
>>
>> is clearer than;
>>
>> 0x174 0x5 0x3d8 0x7 0x654 0x7633, /* EIM_23 GPIO1_2 and some pullup
>> settings or so comment comment comment */
>
> Look what you have to do to get the pin muxing for a single pin from the
> datasheet.
>
> - identify the name, grep for it in the datasheet, find 0x78 for the mux
>   register.
> - identify the mode wanted, it's ALT1 for GPIO1_2
> - Look if it is involved in daisy chain, grep again if it is
> - grep again for EIM_D23, find 0x40c for the PAD_CTL register
>
> That's exactly the steps that are annoying, error prone and you can get
> rid of by having a macro like we currently have. If you found a bug in
> the macro, fix it and everyone benefits.

And everyone ends up with broken device trees until someone notices.
In my experience, nobody usually notices until a very, very long time
has passed. At least if the register values you're picking doing board
support for your boards will only affect your board if they're wrong
and not be global.

> Also you should notice that with the new patches Shawn has posted nobody
> is forced to use these macros. If you don't like them, go and dump the
> raw hex numbers into your devicetrees.

I do notice that, what I'm a little perturbed by is that it doesn't
seem to improve the situation (the amount of work required to use and
VERIFY the values in each macro - on the assumption that any of them
could be wrong and cross-check them with the schematics, the board
designer if necessary, and then put them in a device tree as known
working. Not all of the data files used in PCB design packages
actually match the docs anyway so there are some cross-checks against
yet another Freescale design database. If I asked someone here to go
find the pin settings for USDHC2 on a board we have, they would first
have to figure out which pad this was coming out of, go to the manual,
find the signals that exit on that pad, look at the IOMUX, cross check
it with some example code and the FSL IOMUX tool... pre-processing and
using macros doesn't make that any easier until we have a single,
fixed, totally verified and unchangeable set of macros which will
cover all the usual cases. If the intent is that we just glob in 2500
pin definitions at the start and "hope" that someone "eventually"
notices any errors.. this is not normal in embedded design.

I think that in the grand scheme of things it will just serve to hide
errors behind a macro..

Shawn, I might be much happier about the patch if I knew for sure that it

a) followed some Freescale design database export of pins vs. alt
modes and default mux settings (this must exist because the manuals
and IOMUX tool data are generated from some XML files) and that
b) that data was available to generate the macros used in the binding.

Assuming the manual is correct is not a bad way to go - sometimes it
is definitely NOT, but the information we're using right now is
derived from there anyway.. it should still follow the names listed
there (i.e. SD2_DAT4__SD2_DAT4 and not SD2_DAT4__USDHC2_DATA4 if the
first one is what can be derived from the manual)

I would also be MUCH happier if macros were also present to support
cross-checking the ranges of iomux registers being defined such that
they can be cross-checked at pre-processing time for those people who
do not want to use the macros verbatim. This way immediate errors
(accidental typo putting a wrong register in a field which is out of
range for the valid addresses for that register block) will be caught
in using the macros.

I guess I will have to capitulate on it since I've got absolutely no
power to lock Shawn in a room until it's done right, but I loathe
automation for automation's sake. There always has to be a human
present and the amount of work he has to do is not "annoying" when it
is looking something up in the manual and coding something to suit.
That's what we all do for a living, for crying out loud. And when a
human is doing some amount of work, making it easier to make a mistake
and creating an assumption that there is an easy way out via
preprocessor macros is counter-productive (someone still has to write
every macro, and someone still has to verify every single one of them
at some point).

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
