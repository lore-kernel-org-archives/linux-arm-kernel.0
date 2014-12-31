From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 31 Dec 2014 21:07:25 +0000
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <CAL_JsqLBCeCc2VKvHAdG5bBJt=2qmX5BnosdGd_2n+Pb9BhuZQ@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <13417872.31IhE1RbAx@wuerfel>
 <CAL_Jsq+iVWPsN9LXEMT6DmjS7MGsnmgJLgyb33N3me=OcCet6g@mail.gmail.com>
 <14512076.oz77HnzXre@wuerfel>
 <CAFEAcA9=eoP4-F0Z8J171=DHE5JHVn7ahMnQrHQFz9SHePQHNQ@mail.gmail.com>
 <CAL_JsqLBCeCc2VKvHAdG5bBJt=2qmX5BnosdGd_2n+Pb9BhuZQ@mail.gmail.com>
Message-ID: <CAFEAcA-=2GGEAdnO9+8EV+8OkwUHj3tRiMYWvS4b-cpy6P6rYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 December 2014 at 19:22, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Dec 31, 2014 at 10:13 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> Why would you want to get the bootloader to do this for you when
>> the hardware provides a perfectly good mechanism for probing
>> for the existence of the hardware? "Ask the hardware" is always
>> going to be a more reliable and foolproof way to get the answer
>> if you can do it -- device tree should just be for the cases where
>> there is no way to probe. In any case the only way for the boot
>> loader to determine the correct value to put into the device tree
>> would be to read the register itself.
>
> Only that it is nice to hide all the ugly bits in the
> bootloader/firmware and DT already provides a standard way to enable
> or disable h/w. This h/w is not probeable in any sort of standard way.

This is an embedded system, you were expecting some kind of
standard? :-) I believe that SYS_PCICTL tells you whether
you're going to find the PCI controller or a decode error
at the addresses in the memory map where the PCI controller
usually lives, so robustness suggests it's worth retaining
the check in the kernel. [I'd want to check this on hardware
but my current belief is that if there's no backplane attached
then the register will read zero and the PCI controller register
space will abort with decode errors.]

> From Table 4.4, I came to the conclusion that the write wasn't really necessary:
>
> SYS_PCICTL  0x10000044  Read only  -Read returns a HIGH in bit [0] if
> a PCI board is present in the expansion backplane.
>
> I'll add it back.

The self-contradictory VersatilePB docs strike again, I see.
Interestingly, in the PB1176 docs this register is documented
as definitely read/only:

# [1]Read only: Reserved.
#
# Note
#
# On the RealView Platform Baseboard for ARM926EJ-S, this bit
# was PCICONTROLIN signal and indicated that 66MHz mode was
# enabled. The PB1176JZF-S only supports 33MHz operation.
#
# [0]Read only: Status of P_DETECT pin.

...and in passing provides some info about the 926 board that
isn't in the docs for the 926!

A little digging suggests that it may in fact be the case
that the 1176 docs are correct and the write to bit 0 does
nothing. However the safest thing here is to keep doing
what the old kernel did, I think.

thanks
-- PMM
