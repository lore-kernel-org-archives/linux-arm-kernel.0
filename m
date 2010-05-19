From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 May 2010 05:57:55 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005172341200.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
Message-ID: <AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 10:34 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 18 May 2010, Jeremy Kerr wrote:
>> Some notes about this scheme:
>>
>> ?- This would break compatibility with the existing boot interface:
>> bootloaders that expect a DT kernel will not be able to boot a non-DT kernel.
>> However, does this matter? Once the machine support (ie, bootloader and
>> kernel) is done, we don't expect to have to enable both methods.
>
> I think that, for the moment, it is best if the bootloader on already
> existing subarchitectures where DT is introduced still preserve the
> already existing ability to boot using ATAGs. ?This allows for the
> testing and validation of the DT concept against the legacy ATAG method
> more easily.

I think we've got an agreement!  :-)

>
> On new subarchitectures, it might make sense to go with DT from the
> start instead of creating setup code for every single machine. ?In that
> case the bootloader for those machines would only need to care about DT
> and forget about ATAGs.
>
>> ?+ A simpler boot interface, so less to do (and get wrong) in the bootloader
>>
>> ?+ We don't have two potential sources of boot information
>
> Those last two are IMHO the biggest reasons for not having both ATAGs
> and DT at the same time. ?Otherwise the confusion about which one is
> authoritative, which one has precedence over the other, and/or whether
> the information should be obtained from one structure if it is missing
> from the other will simply bite us eventually for sure, as bootloader
> writers will get sloppy/lazy and have it wrong. ?I strongly suggest that
> we should specify that the kernel must consider either ATAGs _or_ a
> device tree, and that the bootloader must pass only one of them.

I still disagree on this point.  I think it will cause less confusion
to only have a single method for passing the dtb, but that is a debate
that we don't need to solve immediately since we've got a way forward
on passing the dtb now.

> [ I also insist on the ability for the DT info to be extractable and
> ?updatable at the bootloader level, and not hardcoded into the
> ?bootloader itself. But that's another topic for discussion. ]

Yet an important one.  I fully support you on this.

>> Although I have been using the atag for a while, I have not pushed it to an
>> upstream (either qemu or the kernel), as I would like to get a firm decision
>> on the best method before making any commitment.
>>
>> Comments and questions most welcome.
>
> My suggestion is to have the DT support to be considered just as another
> machine _within_ each subarchitecture. ?This means that a machine ID
> could be registered for DT on PXA, another for DT on OMAP, another for
> DT on Dove, etc. ?This way, the DT support can be developed in parallel
> to the existing machine support code. ?So if for example you want to
> test DT for Kirkwood then you may boot the kernel passing the ID for DT
> on Kirkwood into r1 and provide the DT corresponding to, say, a
> SheevaPlug. ?Or you may decide to boot the same kernel binary and use
> the legacy SheevaPlug machine ID instead. ?In theory both methods should
> be equivalent, baring any bugs.
>
> Why one DT machine ID per subarchitecture? ?Simply because a significant
> part of the DT handling code will have to be subarchitecture specific
> anyway. ?The timer hardware, the GPIO configuration and muxing, SOC
> specific platform data handling, power management config, and many other
> things are simply too different from one SOC family to another and
> trying to have a single global DT support code to rule them all is
> insane. ?At least with the concept of a "virtual" machine definition for
> DT per subarchitecture, the problem can easily be split and just fits
> naturally into the existing model on ARM.
>
> This means that, over time, the machine ID registration would simply
> transition from a per machine thing to a per subarchitecture / SOC
> family thing. ?And once the DT support is introduced for a given SOC
> family, then new machines using that SOC should be able to reuse
> the existing kernel binary for that SOC simply by providing a new DT
> data for the existing kernel to consume.

I think this sounds sane.  Per-subarchitecture ids are far more
scalable that per-machine ids.

side question: Do recent ARM SoCs provide any facility to reliably
detected the silicon at run time?  ie. like the processor (unique to
core) and system (unique to SoC) id registers on PowerPC.

> [ There is also the issue of being able to support multiple SOC families
> ?within the same kernel binary, but that's something that could be done
> ?with or without the device tree, and has issues of its own that the DT
> ?cannot solve. Hence this is orthogonal to DT and a topic for yet another
> ?discussion. ]

agreed.

g.
