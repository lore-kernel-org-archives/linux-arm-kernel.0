From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Jul 2012 16:50:24 +0200
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <500D5A45.9070404@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <5005A8A4.6040608@gmail.com>
 <20120721143122.GA26790@mudshark.cambridge.arm.com>
 <201207212156.43941.arnd@arndb.de>
 <CAL_JsqJmN3+1Gb5dF+9eL5c742_-mzg61VcvYhEQpabh5VE=kg@mail.gmail.com>
 <20120722150811.GA29535@mudshark.cambridge.arm.com>
 <CAL_JsqJsepaArV_otTXvt+inK+UtWVabZLkoDkgcVXOH=e58pA@mail.gmail.com>
 <20120723121920.GE31521@mudshark.cambridge.arm.com>
 <500D5A45.9070404@gmail.com>
Message-ID: <CACRpkdb0GuGfcPKD5MQLTDjGun0bAnSRXnHk7AXBxCO=4W31VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 4:05 PM, Rob Herring <robherring2@gmail.com> wrote:

> Now that I have looked at the code. I think it is simply vgacon is
> postcore_init and pci setup of the i/o mapping is in subsys_init.

Makes perfect sense.

> It curious that you don't get an abort and backtrace though.

I never get that either, it just locks up. Probably some other oddity
in these old boards.

> vgacon is only enabled for footbridge and integrator. I guess the only
> way this worked before is if the bootloader has already setup the bus.

Yes that is the case with most of the "V3 PCI" code, without some
bootloader or "BIOS" (boot monitor) poking, nothing works. Some of
the V3 registers are only just poked once, from the boot monitor or
boot loader.

> So I can add back an early mapping function that these 2 platforms can
> call from .map_io. Something like this:
>
> static inline void __init pci_map_io_early(unsigned long pfn)
> {
>         struct map_desc pci_io_desc = {
>                 .virtual        = PCI_IO_VIRT_BASE,
>                 .type           = MT_DEVICE,
>                 .length         = SZ_64K,
>         };
>
>         pci_io_desc.pfn = pfn;
>         create_mapping(&pci_io_desc);
> }

Wouldn't the same kind of thing be necessary for all x86 systems,
and for any other ARM system that wants to use a VGA console?
How do these system handle it?

BTW: in the integrator_defconfig the VGA console is disabled,
for the very reason that it tends to lock things up if ther is no
graphics card in the machine.

Yours,
Linus Walleij
