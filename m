From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 27 Feb 2013 00:51:56 -0600
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <20130222055203.GB27371@S2101-09.ap.freescale.net>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 11:52 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Feb 21, 2013 at 11:36:36AM -0600, Matt Sealey wrote:
>> On Wed, Feb 20, 2013 at 11:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > On Wed, Feb 20, 2013 at 06:03:39PM -0600, Matt Sealey wrote:
>> >> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D
>> >>
>> > Do you see any downgrade side that the series introduces over the
>> > existing implementation?
>>
>> Because it replaces the horribly stupid existing implementation with
>> something that doesn't solve the fundamental logical problems caused
>> by the existing implementation.
>
> When did I say that the series is targeting to solve those "fundamental
> logical problems" in *your* view?
>
> ...

Why would you submit a series that doesn't solve such problems? :)

To replace an illogical, ridiculous system of arbitrary pin numbering
with an illogical mapping of registers to arbitrary names is..
illogical.

>> What you've fixed it to do, as I read this patch, is this;
>>
>> <arbitrary_pin_name pad_mode>
>>
> No, it's not arbitrary_pin_name.  It's pin function name which comes
> from hardware manual.  It may not exactly match the public reference
> manual, but they are obvious to be identified.  For imx6q pad SD2_DAT1
> example, the manual says:
>
> Select 1 of 6 iomux modes to be used for pad: SD2_DAT1.
>   000 ALT0 ? Select signal SD2_DATA1.
>   001 ALT1 ? Select signal ECSPI5_SS0.
>   010 ALT2 ? Select signal EIM_CS2.
>   011 ALT3 ? Select signal AUD4_TXFS.
>   100 ALT4 ? Select signal KEY_COL7.
>   101 ALT5 ? Select signal GPIO1_IO14.
>
> And imx6q-pinfunc.h gives:
>
>   MX6Q_PAD_SD2_DAT1__USDHC2_DAT1
>   MX6Q_PAD_SD2_DAT1__ECSPI5_SS0
>   MX6Q_PAD_SD2_DAT1__WEIM_WEIM_CS_2
>   MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS
>   MX6Q_PAD_SD2_DAT1__KPP_COL_7
>   MX6Q_PAD_SD2_DAT1__GPIO_1_14

So, SD2_DAT1 with function SD2_DAT1 in the manual is SD2_DAT1__USDHC2_DAT1 ?

KEY_COL7 -> KPP_COL_7?
EIM_CS2 -> WEIM_WEIM_CS_2?
AUD4_TXFS -> AUDMUX_AUD4_TXFS?
GPIO1_IO14 -> GPIO_1_14?

This is what I call arbitrary.

Since the documented NAMING of pins changes between SoC revisions
(where pins change definition or group), manual revisions (where
people fix definitions), and even existing source code, it makes no
sense whatsoever to give things like this a name. Especially as it is
possible to break out the pin definitions and see that your "use a
macro to encode 5 values at once and leave the most-often changing
value to the device tree" method misses one thing: it is not easy to
set the SION bit in the ALT register for each of these without
replacing the macro. Sometimes SION is important for debugging,
sometimes it is not... some pins need SION *forever* and other times..
not. On i.MX6 using RMII ethernet, you need SION to loopback the clock
input to the MAC.. but it's possible you'd want to temporarily disable
this in a build. The only way here is to replace the pin definition
macro part with the actual register values, set your SION bit, and
rebuild the device tree.

The only canonical thing you can guarantee is that in general the
registers fit within certain ranges (although on i.MX51 the ranges did
change between revisions, this is another problem), and accept certain
values.

The only reasonable thing we can be doing with pre-processing IOMUX
data is make sure it fits those ranges (within reason) and possibly
use the preprocessing to ensure that invalid values never make it into
a device tree (i.e. there are bits in the pad settings which are
never, ever set on a particular SoC, and masking and bailing out using
#error or pitching a #warning would be much more useful than allowing
random bits to go into register areas that are "reserved".

I half-agree with Sascha. I am responsible for porting the i.MX51
iomux-v3.h stuff to U-Boot because using the naming scheme worked so
much better there than mxc_request_iomux clutter since most boards
came with almost exactly the same settings on exactly the same buses
because it was a limited choice on i.MX51. This MOSTLY works but there
are several - if not a ridiculous number - of entries which needed to
be modified for any particular board. And the remit came from the
U-Boot guys simply that we should not commit into the tree any pins
which no board makes use of.

Here, we have potential for a huge file full of macros of which a good
deal of them will end up with NOBODY using, and therefore just clutter
the file. If we go with the U-Boot model, we only add macros to define
a pin configuration set if at least ONE board requires that
definition. This will keep it nice and clean and make sure nobody
commits huge swaths of macros which nobody is testing.

Since I did that work, I've changed my mind; actually naming the pins
by their intended function simply doesn't ADD anything to the device
tree functionality, nor does it really help Sascha out any more than
simply having a *really good reference* would help him out.

For example, please explain to me why;

MX51_PIN_EIM_23__GPIO1_2 0x6528

is clearer than;

0x174 0x5 0x3d8 0x7 0x654 0x7633, /* EIM_23 GPIO1_2 and some pullup
settings or so comment comment comment */

In the processed device tree all you're going to see is the numbers.
No pin naming at all. No comments. They certainly don't appear in the
blob. Looking at the device tree in /proc/device-tree or processed
output before compiling, the magic macro information is COMPLETELY
lost, which means all it does is add an arbitrary binding of a name to
a set of values in the raw, unprocessed source - just to "explain"
what that pin does.

How does a comment not do this already in the raw, unprocessed source?

How does giving it a macro name help people looking at trees that have
gone through processing?

Answer: it doesn't. We're adding work (preprocessing) for no
significant benefit except to stop a raw, source code device tree from
being a clutter of numbers. Since it ends up as a clutter of numbers
anyway at runtime, adding cross-referencing and potential for
typographical errors at all stages plus any possible automation
errors..

>> 2) copy pasting a line of 5 values from an example document and adding
>> your pad mode bits to the end is no more time consuming or
>> space-consuming than copying a 38-character macro name.
>
> DTB is meant to be machine-parseable, but DTS is meant to be
> human-readable because it's edited by human-being, and macro name
> is obviously more friendly here.

Last I checked, I can read numbers just fine, I can even convert hex
to decimal in my head; when I feel sleepy and not quite up to it, I
have a calculator. I can also paste the numbers directly into my PDF
reader to find the exact register definition within the IOMUX chapter
- instant lookup. Looking at the DT, then looking at the macro header,
then searching for the PDF is an extra step. To me, it is not obvious
that this is "more friendly," simply because it is adding a level of
indirection.

>> 3) macros can be wrong and they will inherit into every device tree,
>> breaking every board that uses them.
>
> The macros should eventually come from some tool/program and design
> database.  It should stand little chance to be wrong.  Even there is
> something wrong with the macros, it should be noticed from the very
> beginning, exactly because it will get any board device tree using
> the macros wrong.

Your examples seem to have mismatching database revisions, then?

> With the help of macros, patch #3 changes the PIN_FUNC_ID from an
> integer to a tuple of integers without touching any DTS files at all.

Understood, but I don't see the benefit of converting "98" to
"MX51_PIN_EIM_23__GPIO_1_2" when eventually it gets converted into a
string of 5 numbers which are in the manual. At least how the benefit
outweighs a comment in the DTS if there really needs to be some
explanation of the fields (these already exist in the current trees to
explain what the numbers mean in the first place).

Especially as nobody can agree what the canonical pin naming should be
despite several (I count 6) implementations of naming the pins, and
that in several cases the values returned by the macros may not be
EXACTLY what you wanted (SION bit is the biggest example), it still
maps an arbitrary value (number in the old version, string literal
macro name in the series you sent).

If someone gets the macro wrong - a typo or missed pin - or needs to
continually add new macros for new boards - this is going to create an
inordinate amount of churn in the macro file and therefore in a
binding. God forbid if the binding has to change. Please don't submit
a file with every pin you THINK is in the i.MX5/6 and think it is
done, because we know already from the patch Sascha referenced..
people miss things and get things wrong.

If the binding is simply "an array of 6 values per pin configuration,
please see the manual for the register offsets and bit definitions"
then the ONLY error can be in the authorship of the device tree source
code and the onus is on.. that guy. Not the "Linux source code being
wrong" or "the binding being out of date". You cannot by any means
introduce automation errors or mistakes in a binding this way.
Bindings - and any preprocessor macros which they depend on - should
be fixed. Not constantly fluctuating at the time someone finds a
mistake, or on the assumption that someone will be cross-checking
every single value in a huge list of pins in a binding where it is
possible it cannot be tested on a real board.

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
