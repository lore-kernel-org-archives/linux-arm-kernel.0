From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Jan 2015 16:35:42 +0100
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <CAFEAcA-=2GGEAdnO9+8EV+8OkwUHj3tRiMYWvS4b-cpy6P6rYg@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqLBCeCc2VKvHAdG5bBJt=2qmX5BnosdGd_2n+Pb9BhuZQ@mail.gmail.com>
 <CAFEAcA-=2GGEAdnO9+8EV+8OkwUHj3tRiMYWvS4b-cpy6P6rYg@mail.gmail.com>
Message-ID: <2544305.Bn9s67VML8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 21:07:25 Peter Maydell wrote:
> On 31 December 2014 at 19:22, Rob Herring <robherring2@gmail.com> wrote:
> > On Wed, Dec 31, 2014 at 10:13 AM, Peter Maydell
> > <peter.maydell@linaro.org> wrote:
> >> Why would you want to get the bootloader to do this for you when
> >> the hardware provides a perfectly good mechanism for probing
> >> for the existence of the hardware? "Ask the hardware" is always
> >> going to be a more reliable and foolproof way to get the answer
> >> if you can do it -- device tree should just be for the cases where
> >> there is no way to probe. In any case the only way for the boot
> >> loader to determine the correct value to put into the device tree
> >> would be to read the register itself.
> >
> > Only that it is nice to hide all the ugly bits in the
> > bootloader/firmware and DT already provides a standard way to enable
> > or disable h/w. This h/w is not probeable in any sort of standard way.
> 
> This is an embedded system, you were expecting some kind of
> standard?

But that is exactly the point: While we try to ask the hardware about
anything that can be reasonably queried through an in-kernel interface
that talks to the hardware, it works less well when that hardware interface
is rather obscure and (like this one) only used on a few special machines.

Similar examples are Marvell's SoC ID register, which you have to read by
powering on the PCI host bridge and reading the Vendor/Device ID registers
for the root bus, or the 'nvram' on Broadcom's wifi router chips that is
in reality a partition on either NOR or NAND flash. Accessing those at
early boot from a random device driver is a real pain, and it would be
much nicer to have the boot loader read them and put the data into the
DT for us if we had the option. Unfortunately we have to deal with legacy
boot loaders that don't change the DTB.

> > From Table 4.4, I came to the conclusion that the write wasn't really necessary:
> >
> > SYS_PCICTL  0x10000044  Read only  -Read returns a HIGH in bit [0] if
> > a PCI board is present in the expansion backplane.
> >
> > I'll add it back.
> 
> The self-contradictory VersatilePB docs strike again, I see.
> Interestingly, in the PB1176 docs this register is documented
> as definitely read/only:
> 
> # [1]Read only: Reserved.
> #
> # Note
> #
> # On the RealView Platform Baseboard for ARM926EJ-S, this bit
> # was PCICONTROLIN signal and indicated that 66MHz mode was
> # enabled. The PB1176JZF-S only supports 33MHz operation.
> #
> # [0]Read only: Status of P_DETECT pin.
> 
> ...and in passing provides some info about the 926 board that
> isn't in the docs for the 926!
> 
> A little digging suggests that it may in fact be the case
> that the 1176 docs are correct and the write to bit 0 does
> nothing. However the safest thing here is to keep doing
> what the old kernel did, I think.

Agreed. This also means that we need a way to access that register
anyway, and any discussion about finding a way to move the read
access for probing the device elsewhere is moot. A syscon device node
would probably be best, but the current approach also works.

	Arnd
