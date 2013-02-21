From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Feb 2013 17:34:48 -0700
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
Message-ID: <51256BA8.70802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 05:03 PM, Matt Sealey wrote:
> On Wed, Feb 20, 2013 at 12:46 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 02/20/2013 12:08 AM, Shawn Guo wrote:
>>> This turns the imx pin function number defined by binding document
>>> into #define constants in header which can be used in dts and handled
>>> by pre-processor to improve the readability of device tree sources.
>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt
>>
>>> -See below for available PIN_FUNC_ID for imx35:
>>> -0 MX35_PAD_CAPTURE__GPT_CAPIN1
>> ...
>>> -951 MX35_PAD_TEST_MODE__TCU_TEST_MODE
>>> +Refer to arch/arm/boot/dts/imx35-pinfunc.h for all available imx35 PIN_FUNC_ID.
>>
>> So that path is specific to the Linux kernel. The DT binding
>> documentation isn't supposed to be specific to the Linux kernel.
> 
> I have to violently NACK this patchset for this very reason.
> 
> Shawn, we've discussed this before!
> 
> Please try not to use the device tree to "help" Linux drivers somehow
> look up internal Linux data. This means the device tree is not
> portable to other operating systems without copying out data from a
> GPL source to a non-GPL source if this is required, meaning device
> trees ONLY apply to Linux, and as Stephen pointed out, this is bad.

I believe my comment was directed somewhere a little different than
yours are.

My comment was simply that the *pathname* of the header file
imx35-pinfunc.h was Linux-specific. I would advocate replacing it with
e.g. <dt-bindings/pinctrl/imx35-pinfunc.h>. My belief is that the header
file is *part* of the binding, and so there will be a tree (currently
Documentation/devicetree/bindings in the kernel's copy) that contains
the *.txt bindings, and another tree (which I'm proposing storing in
include/dt-bindings as the kernel's copy) which contains the header
files, and which is known as the source of include files reference under
<dt-bindings/>.

Re: the license question: What is the license of the DT bindings
documentation? I don't recall having seen any license header in any of
the files, so I'd have to assume they're all GPLv2 since that's the
license of the kernel. Hence, Shawn having licensed his new headers
under the same license explicitly seems entirely consistent.

> You cannot have ANY entries in the device tree that cannot be
> described outside of the device tree or explained away directly in the
> binding

Sure. But note that I explicitly consider the header files as part of
the binding; it's just that for tabular/constant data, it's more
convenient to represent it in a header file than a more free-form table
in the DT binding document itself.

> (i.e. you can get around this by making a PDF of the binding
> and pasting that include data in there, but that is obtuse). Having a
> binding that maps an arbitrary string (and these strings ARE arbitrary
> since "pin" 951 maps to nowhere but a big array).
> 
> Please also do not use the device tree to "help" people "read" the
> device tree. A device tree is not meant to be human-readable, it's
> meant to be machine-parseable.

Just because something is machine parseable doesn't mean it shouldn't
also be human readable. Your argument could be applied to any piece of C
code too; it's meant for consumption by the compiler, so it doesn't
matter if people can read or maintain it?

> It has the same fundamental concept as
> XML - if you read an XML file and are pulling information out of it
> with your eyes and brain you are Doing It Wrong. You're supposed to
> use an XML parser. However, that does not stop people with the
> appropriate talents writing XML files in a text editor using their
> knowledge of syntax. We are all programmers here - and board
> designers. Nobody else is going to be writing device tree data,
> certainly not a secretary or someone who doesn't understand what 3
> pairs of hexadecimal values does.

Understanding is one thing. Nobody is going to argue against that. The
issue is remembering which bits are which, accidental typos that aren't
obvious, etc.

> XML has comments, and so do device trees. Preprocessing the device
> tree is to convert pin names into values not something anyone who
> designs boards will be doing.

You state that as fact, but I disagree.

> Most board designers don't even use
> Freescale's IOMUX gui tool. Neither will programmers think "pasting in
> a huge arbitrary string" is any easier than "pasting in 6 values from
> an appropriate reference".

That's simply not true. I and Shawn are both programmers, and we would
find using a CPP macro name to set up GPIO IDs, IRQ/GPIO flags, etc.
much easier than referring to a DT binding document, manually or'ing
some bits together, and writing the result into the .dts file. It's
simply error-prone to do this manually, and unreadable after it's done.

> Programmers will also add comments, as
> already existed, if they need to cross-reference which pin this is
> without decoding a number in their heads. These comments get stripped
> when it's compiled. Comments are not enemies.

Comments aren't compiled. So, it's easy to make a typo and get a comment
right but the integer value they comment on wrong. By using
defines/macros, the values *are* comments, just in a human-readable form.

> By simply pasting in the 3 pairs into your target device tree, all the
> values would be directly referenced in the documentation of the
> appropriate processor. They would be internally consistent - i.e. no
> data structures (even macros) referenced that end up living outside
> the device tree itself.
> 
> Here is an idea; write some documentation (in the pin binding if you
> like) that essentially looks like the C header, only without the
> #define part. Put that directly in the binding as *examples*.
> Programmers and board designers doing initial bring-up can use these
> as a quick reference that SUPPLEMENTS the information in the CPU
> manual.
> 
> As examples for developers of device trees it will come in much
> handier than having preprocessing go on. In the event that - in very
> many circumstances - the default pin configuration in the list from
> the binding document is not relevant to your board (if pullups or
> pulldowns or logic inverters are present on the PCB rather than
> derived in pad settings) then you will end up copying some of them as
> reference and pasting it in and modifying the values anyway, so
> 
>         MX51_PIN_X__SD3_DAT4 nnnn
> 
> In my device tree doesn't work. I will have to intersperse
> preprocessor items with real values for the chip making it terrible to
> debug device trees, and defeating the preprocessing step. What your
> patch will do, implicitly, is encourage people to *ADD* pad settings
> as a reference to the binding, which is the mess we got into with the
> old macro solution in the first place (when a pin config doesn't
> match, you have to add pins to the include and give it a new name..) -
> so this ends up in my target board tree as
> 
>         MX51_PIN_X__SD3_DAT1 nnnn
>         MX51_PIN_X__SD3_DAT2 nnnn
>         MX51_PIN_X__SD3_DAT3 nnnn
>         aaa bbb ccc xxx yyy zzz /* MX51_PIN_X_SD3_DAT4 with some mod I did */
>         MX51_PIN_X__SD3_WP nnnn
>         ddd eee fff uuu vvv www /* MX51_PIN_X__SD3_CD logic is on PCB */
>         /* und so weiter */
> 
> How does preprocessing the tree here help? What you end up with after
> preprocessing is 3 pairs of values in any event. Why not just paste
> them into the tree directly and use comments?

Sorry, I'm having a hard time understanding that. The header should
already contain all defined fields/values, so there wouldn't be a need
to add more to it. If something ended up missing through oversight, it'd
be entirely appropriate to add it. I can't see why you'd end up with a
mix of defines and literals.

> Also, since the #define NAME_OF_PIN__FUNCTION is arbitrary (only the
> part of the name before the double underscore exists in docs, and
> sometimes this changes between chip revisions) it helps nobody.

The value is arbitrary.

The concept of selecting a specific pinmux function on a particular pin
is certainly something that exists in HW. It's the very purpose of a
pinmux IP block, and there are explicitly register fields for it.

The fact that the IMX binding has a single integer that represents both
the pin ID and the function muxed onto it, rather than separately
representing the pin ID and the function as separate cells/fields does
admittedly seem rather odd to me. However, that fact already exists now,
before this patch, and so isn't anything to do with this patch.

> Preprocessing device trees is useful to keep redundant or repeatative
> data out of a single device tree (for instance, if a chip has 24 timer
> modules all absolutely identical except the address and an interrupt
> number, but there are 10 other information items that are identical,
> this is a target for preprocessing and expanding a macro). It
> shouldn't be used to allow storing "data" (i.e. arbitrary lists or
> tables) in any other place than the device tree (besides the processor
> documentation shipped by the vendor) as a clever way to "clean up"
> trees to make them more "readable".
> 
> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D

Well, I certainly understand you don't want to use defines instead of
literals, but the simple fact is that many people writing device trees
/do/ very explicitly want that.
