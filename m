From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 09:13:11 -0500
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <243730d3-e7f3-584d-b5dd-491c2700cf11@ti.com>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
 <243730d3-e7f3-584d-b5dd-491c2700cf11@ti.com>
Message-ID: <CAL_JsqJPUaQf01Ahrmba2WBAApMTKq6i6LCXe6PGbq-N5f8shA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 12:55 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 22/05/18 23:01, Rob Herring wrote:
>>
>> On Mon, May 21, 2018 at 09:57:54AM +0300, Tero Kristo wrote:
>>>
>>> On 17/04/18 17:49, Tony Lindgren wrote:
>>>>
>>>> * Tero Kristo <t-kristo@ti.com> [180417 09:36]:
>>>>>
>>>>> In typical setup, you can boot a large number of different configs via:
>>>>>
>>>>> bootm 0x82000000#dra71-evm#nand#lcd-auo-g101evn01.0
>>>>>
>>>>> ... assuming the configs were named like that, and assuming they would
>>>>> be
>>>>> compatible with each other. The am57xx-evm example provided is better,
>>>>> as
>>>>> you can chain the different cameras to the available evm configs.
>>>>
>>>>
>>>> Why not just do it in the bootloader to put together the dtb?
>>>>
>>>> Then for external devices, you could just pass info on the
>>>> kernel cmdline with lcd=foo camera=bar if they cannot be
>>>> detected over I2C.
>>>
>>>
>>> (Added Linux ARM list to CC, this was not part of the original delivery.)
>>>
>>> Ok trying to resurrect this thread a bit. Is there any kind of consensus
>>> how
>>> things like this should be handled? Should we add the DT overlay files to
>>> kernel tree or not?
>>
>>
>> IMO, yes.
>>
>>> Should we add any kind of build infra to kernel tree, and at what level
>>> would this be? Just DT overlay file building support, and drop the FIT
>>> build
>>> support as was proposed in this RFC series or...?
>>
>>
>> I think I mentioned this already, but I expect that this is going to
>> cause a number of conversions of dtsi + dtsi -> dtb into base dts and
>> overlay(s) dts files. In doing so, we still need to be able to build the
>> original, full dtb.
>
>
> So you mean like breaking apart the existing .dts files? Are there any plans
> to get that done (I know the android folks talk about this but I don't like
> their idea.) If we do the split, how are we going to determine which dts +
> overlay files are required to get a specific DTB done? I actually wrote a
> tool for this purpose which parses the FIT image configurations and
> generates plain dtb files out of the info there if needed, but assuming FIT
> is abandoned then what...?

There aren't any plans that I'm aware of. I'm just assuming there are
some cases in the tree. It would just be some additional build rules:

board-kit.dtb: soc-som.dtb expansion-board.dtbo
  fdtoverlay -o $@ -i $^

We'd need to come up with some way to express the input and output
files in a kbuild way. Perhaps similar to how multiple module files
are done.

Even if you are adding new platforms, having the above would still be
good. It captures what base the overlays apply to and tests that
applying actually works (rather than leaving that for the user to do
in the bootloader). FIT images also have or need that information, so
perhaps we can define a format that works as input for both kbuild and
FIT images.

>>> U-boot can obviously parse the base DTB + overlay DTB:s into a single
>>> DTB,
>>> but this is somewhat clumsy approach and is relatively error prone to get
>>> it
>>> right.
>>
>>
>> Why? How is the kernel better?
>
>
> I am mostly speaking about runtime applying of the overlays. If done build
> time, it is obviously on same level. If you apply the base DTS + overlays
> from u-boot prompt, it is not too much fun, and if there are any failures it
> just won't work, but don't really tell you why not.

Runtime, but still at boot time, right?

How is the kernel going to have better error handling? Is libfdt error
handling worse than the kernel's overlay code?

I do think we need to standardize how we tell bootloaders what
overlays to apply. I expect that we'll do that as part of EBBR spec[1]
though that is not part of the immediate focus.

Rob

[1] https://github.com/ARM-software/ebbr
