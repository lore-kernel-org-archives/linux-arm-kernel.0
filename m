From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Thu, 19 Feb 2015 16:29:46 +0200
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <20150218173115.GG29429@leverpostej>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
Message-ID: <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> On Feb 18, 2015, at 19:31 , Mark Rutland <mark.rutland@arm.com> wrote:
> 
>>>> +While this may in theory work, in practice it is very cumbersome
>>>> +for the following reasons:
>>>> +
>>>> +1. The act of selecting a different boot device tree blob requires
>>>> +a reasonably advanced bootloader with some kind of configuration or
>>>> +scripting capabilities. Sadly this is not the case many times, the
>>>> +bootloader is extremely dumb and can only use a single dt blob.
>>> 
>>> You can have several bootloader builds, or even a single build with
>>> something like appended DTB to get an appropriate DTB if the same binary
>>> will otherwise work across all variants of a board.
>>> 
>> 
>> No, the same DTB will not work across all the variants of a board.
> 
> I wasn't on about the DTB. I was on about the loader binary, in the case
> the FW/bootloader could be common even if the DTB couldn't.
> 
> To some extent there must be a DTB that will work across all variants
> (albeit with limited utility) or the quirk approach wouldn't work?
> 

That?s not correct; the only part of the DTB that needs to be common
is the model property that would allow the quirk detection logic to fire.

So, there is a base DTB that will work on all variants, but that only means
that it will work only up to the point that the quirk detector method
can work. So while in recommended practice there are common subsets
of the DTB that might work, they might be unsafe.

For instance on the beaglebone the regulator configuration is different
between white and black, it is imperative you get them right otherwise
you risk board damage.

>>> So it's not necessarily true that you need a complex bootloader.
>>> 
>> 
>>>> +2. On many instances boot time is extremely critical; in some cases
>>>> +there are hard requirements like having working video feeds in under
>>>> +2 seconds from power-up. This leaves an extremely small time budget for
>>>> +boot-up, as low as 500ms to kernel entry. The sanest way to get there
>>>> +is by removing the standard bootloader from the normal boot sequence
>>>> +altogether by having a very small boot shim that loads the kernel and
>>>> +immediately jumps to kernel, like falcon-boot mode in u-boot does.
>>> 
>>> Given my previous comments above I don't see why this is relevant.
>>> You're already passing _some_ DTB here, so if you can organise for the
>>> board to statically provide a sane DTB that's fine, or you can resort to
>>> appended DTB if it's not possible to update the board configuration.
>>> 
>> 
>> You?re missing the point. I can?t use the same DTB for each revision of the
>> board. Each board is similar but it?s not identical.
> 
> I think you've misunderstood my point. If you program the board with the
> relevant DTB, or use appended DTB, then you will pass the correct DTB to
> the kernel without need for quirks.
> 
> I understand that each variant is somewhat incompatible (and hence needs
> its own DTB).

In theory it might work, in practice this does not. Ludovic mentioned that they
have 27 different DTBs in use at the moment. At a relatively common 60k per DTB
that?s 27x60k = 1.6MB of DTBs, that need to be installed.

> 
>>>> +3. Having different DTBs/DTSs for different board revisions easily leads to
>>>> +drift between versions. Since no developer is expected to have every single
>>>> +board revision at hand, things are easy to get out of sync, with board versions
>>>> +failing to boot even though the kernel is up to date.
>>> 
>>> I'm not sure I follow. Surely if you don't have every board revision at
>>> hand you can't test quirks exhaustively either?
>>> 
>> 
>> It?s one less thing to worry about. For example in the current mainline kernel
>> already there is a drift between the beaglebone white and the beaglebone black.
> 
> What's currently out of sync?
> 
>> Having the same DTS is just easier to keep things in sync.
> 
> We have dtsi files to keep this common stuff in sync currently. It
> sounds like we need to factor something out to bring beaglebone black
> and beaglebone white back in sync.
> 

Yes, they need to. Unfortunately it is very easy for DTBs to get out of sync
as it appears in practice.

>>> Additionally you face the problem that two boards of the same variant
>>> could have different base DTBs that you would need to test that each
>>> board's quirks worked for a range of base DTBs.
>>> 
>> 
>> This is not a valid case. This patch is about boards that have the same base DTB.
> 
> Hmm. I mangled my words here.
> 
> Say you have a DTB for some set of boards, relying on quirks. A new
> board comes out requiring both updates to the DT and the quirk detection
> mechanism. Now you need to test that the new detection code works with
> the old boards with the old DTB, in addition to all the boards with the
> new DTB.
> 
> If anything is updated, testing can't be avoided, regardless of this
> quirks mechanism.
> 

Obviously testing is needed everytime something is updated. In practice
the way the boards are identified tend to be similar; on am33xx boards it?s
a standard formatted EEPROM at a known address on a specific i2c bus.

On ATMEL boards it?s the same, but the EEPROM is 1wire, and so on.

>>>> +4. One final problem is the static way that device tree works.
>>>> +For example it might be desirable for various boards to have a way to
>>>> +selectively configure the boot device tree, possibly by the use of command
>>>> +line options.  For instance a device might be disabled if a given command line
>>>> +option is present, different configuration to various devices for debugging
>>>> +purposes can be selected and so on. Currently the only way to do so is by
>>>> +recompiling the DTS and installing, which is an chore for developers and
>>>> +a completely unreasonable expectation from end-users.
>>> 
>>> I'm not sure I follow here.
>>> 
>>> Which devices do you envisage this being the case for?
>>> 
>>> Outside of debug scenarios when would you envisage we do this?
>>> 
>> 
>> We already have to do this on the beaglebone black. The onboard EMMC and HDMI
>> devices conflict with any capes that use the same pins. So you have to
>> have a way to disable them so that the attached cape will work.
> 
> Surely the boot-time quirks are independent of the cape/overlay cases?
> 
> If you pass a sane DTB to begin with for the board then things should
> work, and if you override with an overlay then that should work
> regardless of whatever the boot-time configuration was, no?
> 

No. There is no such thing as a ?sane? DTB that will work under every case.

Let me expand on the specific HDMI case for the beaglebone black.

The black has an on board HDMI framer that?s connected to the LCDC interface.
However the LCDC pins are brought out to the dual connectors and a add-on
LCD cape can be attached.

For it to work, the LCDC driver must be disabled in the boot DTB so that
the overlay that enables the LCD cape can work.

But since the image drop for both case is the same you have to be able to
disable the HDMI using a command line option, instead of installing a different
DTB.

>>> For the debug case it seems reasonable to have command line parameters
>>> to get the kernel to do what we want. Just because there's a device in
>>> the DTB that's useful in a debug scenario doesn't mean we have to use it
>>> by default.
>> 
>> I don?t follow. Users need this functionality to work. I.e. pass a command
>> line option to use different OPPs etc. Real world usage is messy.
> 
> This was all about the debug case; for anything that's required for
> normal operation I agree that a command line argument doesn't work.
> 
>>>> +Device Tree quirks solve all those problems by having an in-kernel interface
>>>> +which per-board/platform method can use to selectively modify the device tree
>>>> +right after unflattening.
>>>> +
>>>> +A DT quirk is a subtree of the boot DT that can be applied to
>>>> +a target in the base DT resulting in a modification of the live
>>>> +tree. The format of the quirk nodes is that of a device tree overlay.
>>>> +
>>>> +As an example the following DTS contains a quirk.
>>>> +
>>>> +/ {
>>>> +       foo: foo-node {
>>>> +               bar = <10>;
>>>> +       };
>>>> +
>>>> +       select-quirk = <&quirk>;
>>>> +
>>>> +       quirk: quirk {
>>>> +               fragment at 0 {
>>>> +                       target = <&foo>;
>>>> +                       __overlay {
>>>> +                               bar = <0xf00>;
>>>> +                               baz = <11>;
>>>> +                       };
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>> +The quirk when applied would result at the following tree:
>>>> +
>>>> +/ {
>>>> +       foo: foo-node {
>>>> +               bar = <0xf00>;
>>>> +               baz = <11>;
>>>> +       };
>>>> +
>>>> +       select-quirk = <&quirk>;
>>>> +
>>>> +       quirk: quirk {
>>>> +               fragment at 0 {
>>>> +                       target = <&foo>;
>>>> +                       __overlay {
>>>> +                               bar = <0xf00>;
>>>> +                               baz = <11>;
>>>> +                       };
>>>> +               };
>>>> +       };
>>>> +
>>>> +};
>>>> +
>>>> +The two public method used to accomplish this are of_quirk_apply_by_node()
>>>> +and of_quirk_apply_by_phandle();
>>>> +
>>>> +To apply the quirk, a per-platform method can retrieve the phandle from the
>>>> +select-quirk property and pass it to the of_quirk_apply_by_phandle() node.
>>>> +
>>>> +The method which the per-platform method is using to select the quirk to apply
>>>> +is out of the scope of the DT quirk definition, but possible methods include
>>>> +and are not limited to: revision encoding in a GPIO input range, board id
>>>> +located in external or internal EEPROM or flash, DMI board ids, etc.
>>> 
>>> It seems rather unfortunate that to get a useful device tree we have to
>>> resort to board-specific mechanisms. That means yet more platform code,
>>> which is rather unfortunate. This would also require any other DT users
>>> to understand and potentially have to sanitize any quirks (e.g. in the
>>> case of Xen).
>> 
>> The original internal version of the patches used early platform devices and
>> a generic firmware quirk mechanism, but I was directed to the per-platform
>> method instead. It is perfectly doable to go back at the original implementation
>> but I need to get the ball rolling with a discussion about the internals.
> 
> Either way my concern is the same; some platform-specific code (be it in
> arch/arm or drivers/) is potentially required in order to get a usable
> DTB of any level of functionality.
> 

Yes, platform specific code is required, but that?s a given for any platform no?

> Thanks,
> Mark.

Regards

? Pantelis
