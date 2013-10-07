From: matthew_minter@xyratex.com (Matthew Minter)
Date: Mon, 7 Oct 2013 10:30:37 +0100
Subject: Arm PCIe hotplugging
In-Reply-To: <20131004165323.GB10315@obsidianresearch.com>
References: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
 <20131004165323.GB10315@obsidianresearch.com>
Message-ID: <CAFJTrDtw4v51_2XvOfNKnMaeVu5g_cT1KLuJNVufWQx50PiSsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the help with this. Looking at the design of the board
being worked on it seems that rescan should be enough hopefully (the
pci bus is powered from a separate supply than the SOC so it should be
possible to shut it down during changes.)

However I might also look into the controls provided by PLX to see if
there is anything simple to use to control power per slot.
I shall also look into what the driver support is like fir the PLX
board to see how much work it will be. I am still a novice as far as
PCIe registers go and reading through some specifications so will do
some study and see what I find.

Thank you very much for the advice and help with this. I will
hopefully reply again later if I find or make anything of use for
hotplugging.

On 4 October 2013 17:53, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Oct 04, 2013 at 02:14:34PM +0100, Matthew Minter wrote:
>
>> I have been doing some work with an Armada XP board (DB-MV784MP-GP)
>> with PCIe support, along with using a PEX 8614 (AA) PCIe switch. The
>> switch in question is said to have hot plug support with the PCIe
>> downstream slots.
>
> PCI-E hot plug has several layers.
>
> The first is the PCI-E serial negotiation and bring up. This is just
> supported out of the box, and works fine with any compliant
> device. You don't need drivers, /sys/bus/pci/rescan is enough. This is
> what I'm doing on kirkwood.
>
> The next is actual *physical* card removal/insertion. For in-box card
> edge connectors this requires power management. You must remove all
> power to the slot before removing/inserting a card. AFAIK, this is
> what the PCI hot plug items in the kernel are all doing, and they do
> this with help from firmware (eg ACPI on x86).
>
> If you have a mechanical system that has staged power connectors (and
> possibly inrush current limiters on the cards) then you don't really
> need to worry much at this point, just rely on the serial hot plug.
>
> PLX (AFIAK) has some 'GPIOs' on their switches dedicated to hot plug
> functions so if the board is properly wired they can control slot
> power/etc through their internal registers. I suspect it shouldn't be
> too hard to get this sort of system to work.. The DT can be augmented
> with slot chassis name properties so you have stable labels work with.
>
> If you have board-specific controls, then you need to start augmenting
> the DT with things like phandles to power regulators and other stuff.
>
>> Looking closer it seems that in the ARM kernel the PCI hotplug code is
>> all disabled. Am I just out of luck and should wait until there is a
>
> I doubt you'll see anything like this emerge in the near future. Fancy
> ARM64 servers with hot plug PCI might motivate the work, but they
> might also do it with ACPI...
>
> BTW,

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
