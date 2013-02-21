From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 20 Feb 2013 18:03:39 -0600
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <51251A11.2030300@wwwdotorg.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
Message-ID: <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 12:46 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/20/2013 12:08 AM, Shawn Guo wrote:
>> This turns the imx pin function number defined by binding document
>> into #define constants in header which can be used in dts and handled
>> by pre-processor to improve the readability of device tree sources.
>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt
>
>> -See below for available PIN_FUNC_ID for imx35:
>> -0 MX35_PAD_CAPTURE__GPT_CAPIN1
> ...
>> -951 MX35_PAD_TEST_MODE__TCU_TEST_MODE
>> +Refer to arch/arm/boot/dts/imx35-pinfunc.h for all available imx35 PIN_FUNC_ID.
>
> So that path is specific to the Linux kernel. The DT binding
> documentation isn't supposed to be specific to the Linux kernel.

I have to violently NACK this patchset for this very reason.

Shawn, we've discussed this before!

Please try not to use the device tree to "help" Linux drivers somehow
look up internal Linux data. This means the device tree is not
portable to other operating systems without copying out data from a
GPL source to a non-GPL source if this is required, meaning device
trees ONLY apply to Linux, and as Stephen pointed out, this is bad.
You cannot have ANY entries in the device tree that cannot be
described outside of the device tree or explained away directly in the
binding (i.e. you can get around this by making a PDF of the binding
and pasting that include data in there, but that is obtuse). Having a
binding that maps an arbitrary string (and these strings ARE arbitrary
since "pin" 951 maps to nowhere but a big array).

Please also do not use the device tree to "help" people "read" the
device tree. A device tree is not meant to be human-readable, it's
meant to be machine-parseable. It has the same fundamental concept as
XML - if you read an XML file and are pulling information out of it
with your eyes and brain you are Doing It Wrong. You're supposed to
use an XML parser. However, that does not stop people with the
appropriate talents writing XML files in a text editor using their
knowledge of syntax. We are all programmers here - and board
designers. Nobody else is going to be writing device tree data,
certainly not a secretary or someone who doesn't understand what 3
pairs of hexadecimal values does.

XML has comments, and so do device trees. Preprocessing the device
tree is to convert pin names into values not something anyone who
designs boards will be doing. Most board designers don't even use
Freescale's IOMUX gui tool. Neither will programmers think "pasting in
a huge arbitrary string" is any easier than "pasting in 6 values from
an appropriate reference". Programmers will also add comments, as
already existed, if they need to cross-reference which pin this is
without decoding a number in their heads. These comments get stripped
when it's compiled. Comments are not enemies.

By simply pasting in the 3 pairs into your target device tree, all the
values would be directly referenced in the documentation of the
appropriate processor. They would be internally consistent - i.e. no
data structures (even macros) referenced that end up living outside
the device tree itself.

Here is an idea; write some documentation (in the pin binding if you
like) that essentially looks like the C header, only without the
#define part. Put that directly in the binding as *examples*.
Programmers and board designers doing initial bring-up can use these
as a quick reference that SUPPLEMENTS the information in the CPU
manual.

As examples for developers of device trees it will come in much
handier than having preprocessing go on. In the event that - in very
many circumstances - the default pin configuration in the list from
the binding document is not relevant to your board (if pullups or
pulldowns or logic inverters are present on the PCB rather than
derived in pad settings) then you will end up copying some of them as
reference and pasting it in and modifying the values anyway, so

        MX51_PIN_X__SD3_DAT4 nnnn

In my device tree doesn't work. I will have to intersperse
preprocessor items with real values for the chip making it terrible to
debug device trees, and defeating the preprocessing step. What your
patch will do, implicitly, is encourage people to *ADD* pad settings
as a reference to the binding, which is the mess we got into with the
old macro solution in the first place (when a pin config doesn't
match, you have to add pins to the include and give it a new name..) -
so this ends up in my target board tree as

        MX51_PIN_X__SD3_DAT1 nnnn
        MX51_PIN_X__SD3_DAT2 nnnn
        MX51_PIN_X__SD3_DAT3 nnnn
        aaa bbb ccc xxx yyy zzz /* MX51_PIN_X_SD3_DAT4 with some mod I did */
        MX51_PIN_X__SD3_WP nnnn
        ddd eee fff uuu vvv www /* MX51_PIN_X__SD3_CD logic is on PCB */
        /* und so weiter */

How does preprocessing the tree here help? What you end up with after
preprocessing is 3 pairs of values in any event. Why not just paste
them into the tree directly and use comments?

Also, since the #define NAME_OF_PIN__FUNCTION is arbitrary (only the
part of the name before the double underscore exists in docs, and
sometimes this changes between chip revisions) it helps nobody.

Also, since the pad config value is STILL using the silly SION bit
information, that would have to go away too (please, please, do not
put a magic SION bit in the PAD configuration value. It doesn't go
into this register and means the driver has to mask out the value and
do special work...)

Preprocessing device trees is useful to keep redundant or repeatative
data out of a single device tree (for instance, if a chip has 24 timer
modules all absolutely identical except the address and an interrupt
number, but there are 10 other information items that are identical,
this is a target for preprocessing and expanding a macro). It
shouldn't be used to allow storing "data" (i.e. arbitrary lists or
tables) in any other place than the device tree (besides the processor
documentation shipped by the vendor) as a clever way to "clean up"
trees to make them more "readable".

I am not sure I am getting this point across, but.. damn it.. nack nack nack :D

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
