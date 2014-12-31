From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 31 Dec 2014 16:13:14 +0000
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <14512076.oz77HnzXre@wuerfel>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <13417872.31IhE1RbAx@wuerfel>
 <CAL_Jsq+iVWPsN9LXEMT6DmjS7MGsnmgJLgyb33N3me=OcCet6g@mail.gmail.com>
 <14512076.oz77HnzXre@wuerfel>
Message-ID: <CAFEAcA9=eoP4-F0Z8J171=DHE5JHVn7ahMnQrHQFz9SHePQHNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 December 2014 at 15:23, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 30 December 2014 17:05:16 Rob Herring wrote:
>> Because the register to check is not part of the PCI controller, but
>> part of the system registers. There was no infrastructure for the
>> system registers when I originally wrote this, but there's some syscon
>> support now for VExpress that may be able to be used. I think it is
>> cleaner if we can avoid syscon dependencies in drivers in general, but
>> it is pretty much zero chance the Versatile PCI driver will ever be
>> used on another platform.
>
> Ok, I see. I guess ideally we would get a correct DTB file from the boot
> loader, but that is of course completely unrealistic on versatile, both
> on hardware and qemu.

Why would you want to get the bootloader to do this for you when
the hardware provides a perfectly good mechanism for probing
for the existence of the hardware? "Ask the hardware" is always
going to be a more reliable and foolproof way to get the answer
if you can do it -- device tree should just be for the cases where
there is no way to probe. In any case the only way for the boot
loader to determine the correct value to put into the device tree
would be to read the register itself.

> I suspect that either the existing behavior is completely bogus because
> the driver always reads what it write before, and then you can skip
> the logic completely, or your new driver is broken because reading
> the register without writing it first will result in undefined behavior
> on real hardware.

The documentation describes this register as:

# The SYS_PCICTL register at 0x10000044 enables the bridge to the PCI bus:
#
# * Setting bit 0 HIGH enables PCI bus accesses.
# * Read returns a HIGH in bit 0 if a PCI board is present
#   in the expansion backplane.

ie the read and write behaviour is independent. So I suspect
that this new driver's failure to write 1 means that it
will break PCI on real hardware. (QEMU doesn't attempt to
model this behaviour: SYS_PCICTL will always read-as-one,
writes-ignored.)

thanks
-- PMM
