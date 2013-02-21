From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 21 Feb 2013 11:36:36 -0600
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <20130221050247.GD17738@S2101-09.ap.freescale.net>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 11:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Feb 20, 2013 at 06:03:39PM -0600, Matt Sealey wrote:
>> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D
>>
> Do you see any downgrade side that the series introduces over the
> existing implementation?

Because it replaces the horribly stupid existing implementation with
something that doesn't solve the fundamental logical problems caused
by the existing implementation. There are three completely obvious
logical inconsistencies with the existing implementation of a pair of
<arbitrary_pin_index pad_mode>;

1) the pin index is completely arbitrary and in any binding every
published for any of these SoC, either broken by design (MX5 and MX6
have duplicated pin data soaking up arbitrary pin ids in the current
binding, or are not defined in SoC register order (i.e. arbitrary
renumbering).

2) the pin index is not internally consistent within the device tree
binding - it is a reference to an array inside source code. Your patch
hopes to solve this, but also hopes to solve other things too. It
fails on the second part.

3) the pad setting value has been hijacked to include bits that
otherwise would not be set in the same register (SION bit and a
special flag to mean, set up everything except the pad settings)

What you've fixed it to do, as I read this patch, is this;

<arbitrary_pin_name pad_mode>

which the preprocessor expands to;

<reg_mux mux_mode reg_insel insel_mode reg_pad pad_mode>

The real problem here is as follows;

1) the pin name and function name are still completely arbitrary (in
so far as the old iomux.h macros way, the newer iomux-v3.h way, the
current bindings and the new binding you're pushing do not match the
CPU documentation at all)

2) copy pasting a line of 5 values from an example document and adding
your pad mode bits to the end is no more time consuming or
space-consuming than copying a 38-character macro name. New board
designs will use data from the FSL IOMUX tool or other sources and not
bother using macro definitions to define pads.

3) macros can be wrong and they will inherit into every device tree,
breaking every board that uses them. That said, so can the examples,
but at least reading the device tree for a board you can cross-check
all the values against, say, the output of many tools provided by
Freescale or existing code or platform support without doing a back
reference or preprocessing the device tree and removing comments).

I am a big fan of a device tree, in and of itself, being internally
consistent (I keep using that phrase, and I mean it). That means not
only does it not try and reference any magic outside data inside some
other code (e.g. table indices in arbitrary packing and format) but it
also does not cause a chain of cross-referencing where values are
hidden behind other values. To confirm device tree pinctrl settings
with this patch I need to preprocess my device tree - and then go over
the output with all my comments stripped out to look at the arrays of
numbers the macros produce. I have therefore five references to look
at: my original device tree (unprocessed, commented), the macro
definitions, the preprocessed output (macros expanded, comments
stripped by preprocessor), and the actual CPU documentation and board
schematics/design data that the values are all derived from.

Why would anyone here need anything more than the device tree as
unprocessed data with comments, and the CPU documentation and board
data defining the function? We cut here 5 down to 3. You cannot do
without these 3 - you cannot magically "guess" that a pad setting will
work just because a macro has the correct name.

In the event a macro does not exist, people will end up either adding
that macro (therefore changing the binding constantly, since the
macros are part of the binding) or putting in the raw values to avoid
the preprocessor. There's a really good reason standards documents
don't change that often; standards need to be frozen and we're not
talking here about freezing standards, but allowing opportunities for
constant, "agile" development of the board boot process and driver
data passing.

I would rather that we go think of a better solution here. We're using
a preprocessor and just using it to expand a name into another value -
why don't we actually use macros to ease the coding of the device tree
entries? That way data isn't moved elsewhere, but the macro can easily
check ranges and report errors in values.. for instance, instead of

MX51_PIN_EIM_23__GPIO1_2 0x6528

<
MUX_REG(0x174) ALT(0x5|SION) INS_REG(0x3d8) INS(0x7) PAD_REG(0x654)
PAD(0x7633|PU_100K), /* MX51_EIM_23 GPIO1_2 */
>;

With the ability to expand the bits required - adding SION ot the ALT
mode, using macros to define the pin bits instead of an opaque value.
Stick a comment after it and it's clear the definition. Copy paste
that into a tree and preprocess it and it becomes the same 6 values,
but in the tree itself it is clear which registers are set (you can
search the docs for these values, where the semi-arbitrary pin naming
scheme in the binding does NOT have a *clearly* searchable part) and
the macro can confirm you didn't put a weird value in there (in this
case, all the registers are in certain ranges and all of them are
32-bit aligned so some extra parsing can be done).

Or even one big macro - IOMUXV3(MX51_EIM_23_GPIO__1_2, 0x174,
0x5|SION, 0x3d8, 0x7, 0x654, 0x7633|PU_100K),

Just discard the first argument, validate the rest against masks etc.
and alignment, and off you go. No information is lost internally to
the tree.

This way we get a little closer back to the original FSL BSP method of
defining iomux and the values above are directly copyable from the
iomux tool, existing source code, bootloaders, other operating systems
(licensing notwithstanding) and hand-written scribbles by the board
designers. There was nothing wrong with this, but there has been some
significant refactoring going on that does not make functionality any
better and has only been done with a view to reduce the precompiled
file size of some arbitrary file - because a descriptive string is
seemingly "better" than the actual values. By reducing the amount of
real data actually contained in the source tree, you make the source
code harder to verify. By increasing the amount of needless
cross-referencing and obfuscation of the real data, you increase the
difficulty of actually creating device trees. This is especially true
since none of the CPU docs or board design data will use any of the
semantics of the "Linux" side of the binding - but they WILL use
register values and ball grids and data from IBIS models.

> Sorry, I do not really understand your nack.

Simple; I've been designing with device trees since before the
arch/ppc->arch/powerpc move, with real OpenFirmware, with a good
understanding of the original specifications and bindings, the intents
and the correct ways of doing things. I figure out board designs,
requirements and then do the software on prototype boards and final
consumer-facing and industrial designs.

Every incremental improvement to the iomux definition model has made
it harder to use; to the point that without keeping track of this list
and then going through and comparing the models it is very, very
difficult to go from older code to new device trees. I've set the task
of porting one board or another to a modern device tree and the
engineers end up asking what the hell is going on with the new method.
That means I have to figure it out myself and train them; and every
time, it gets more and more difficult to explain WHY it's being done
the way it's currently done in lieu of the much easier methods in the
past.

If we go from my point of view - and I take a somewhat "holistic"
approach to product design - what we're doing here is increasing time
to market because I can't use existing tools or existing code to
manage the bring-up of a new design. Unfortunately, in my experience,
there isn't a board engineer on the planet who designs his board from
the firmware binding upwards, and certainly not by "how Linux wants to
do it."

In the "fight" between the best hardware design and bringing up the
software, it pains me to have to add more work to the schedule.

Preprocessing trees is a really nice functional improvement, but this
patch only serves to change nothing (by obfuscating the real data
*behind* a binding) or increase work for programmers taking design
data into a tree. It may look like since there is "less data" in the
tree it is easier to check, but that is not the case and has never
been the case. Also, the data in the binding sometimes does not match
the board design because the current bindings are entirely derived
from existing boards - some of which are not implementing current
design methodologies with the appropriate SoCs or using errata
workarounds for hardware components, which means all these pin
definitions may not apply - do we add a new macro to the binding to
support it or just paste in 6 values for the same effect? How does
that make the device trees look? Ugly? Yes. But they're not meant to
be pretty. Having an aligned list of exactly-the-same-length strings
in a column gains you NOTHING above using the real values and adding a
comment.

It is not the purpose of the device tree concept to "make your driver
code smaller" by encoding information that is easily attainable at
runtime. The tree needs to provide enough information, however, to
make that information easily attainable. That stipulation is also true
of the readability of device trees - just as XML developers do not
read data out by hand, but use parsers, so do we do with device trees.
Just as XML developers hand-code their XML files sometimes, we
sometimes hand-code our device trees. But most XML processing is
machine-driven and translating data from one format to another, to and
from XML. There is always input data, though. That input data must be
clearly defined. The less easy it is to read a device tree entry and
figure out what the crap it was for, the harder it is to verify it's
correctness. Moving values into the preprocessor stage does nothing
except turn an array of seemingly obtuse, uncommented values into a
string literal. I say, use the obtuse values and comment them in your
trees. Use the preprocessor for VALIDATION of those values (or
expansion of offset into absolute address for example), but not for
generation. You are adding too many steps between writing the tree and
the final binary output.

If we do have full C preprocessor support for a device tree now then
we should use the preprocessor to it's fullest, rather than using it
as an overcomplicated replacement for "sed" or "awk".

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
