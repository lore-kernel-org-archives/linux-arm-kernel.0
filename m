From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 1 Jan 2015 15:52:05 +0000
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <2544305.Bn9s67VML8@wuerfel>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqLBCeCc2VKvHAdG5bBJt=2qmX5BnosdGd_2n+Pb9BhuZQ@mail.gmail.com>
 <CAFEAcA-=2GGEAdnO9+8EV+8OkwUHj3tRiMYWvS4b-cpy6P6rYg@mail.gmail.com>
 <2544305.Bn9s67VML8@wuerfel>
Message-ID: <CAFEAcA8Y9PY1q=oO35jcz+VRXYKDAfkgTL7Tv=Uztr6RpWZy8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 January 2015 at 15:35, Arnd Bergmann <arnd@arndb.de> wrote:
> But that is exactly the point: While we try to ask the hardware about
> anything that can be reasonably queried through an in-kernel interface
> that talks to the hardware, it works less well when that hardware interface
> is rather obscure and (like this one) only used on a few special machines.

"We put this random collection of status bits in to a register somewhere
because it was convenient for the h/w engineers" is pretty common, I think.

> Similar examples are Marvell's SoC ID register, which you have to read by
> powering on the PCI host bridge and reading the Vendor/Device ID registers
> for the root bus, or the 'nvram' on Broadcom's wifi router chips that is
> in reality a partition on either NOR or NAND flash. Accessing those at
> early boot from a random device driver is a real pain, and it would be
> much nicer to have the boot loader read them and put the data into the
> DT for us if we had the option. Unfortunately we have to deal with legacy
> boot loaders that don't change the DTB.

I don't think it's going to be any easier for the boot loader, which
is quite possibly totally uninterested in PCI and would have
no reason to need to prod this location on the versatilepb. I also trust
the kernel much more to get bugfixes and be easily updatable. I appreciate
that it's more work for you if you can't just say "punt this nastiness
to the bootloader", but I think it's also the better (more robust
and self-contained) design.

-- PMM
