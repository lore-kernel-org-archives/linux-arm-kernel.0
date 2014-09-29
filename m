From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Sep 2014 18:46:17 +0200
Subject: ARMADA 370 - Kernel panic during boot
In-Reply-To: <68f0f9805e88b1cc33c3d2f9521cc93f@twien.net>
References: <6241a6200de0d573c982f73f062ed7fa@twien.net>
 <542938A7.8050307@free-electrons.com>
 <d1be3a0a37860f969b99ecc09b4cfcd8@twien.net>
 <20140929155724.579964b5@free-electrons.com>
 <68f0f9805e88b1cc33c3d2f9521cc93f@twien.net>
Message-ID: <20140929184617.0a333b09@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 29 Sep 2014 17:23:59 +0200, post at twien.net wrote:

> Thanks, that made it!

You're welcome.

> Actually to change the Physical base address of the debug UART was 
> actually a shot in the dark, because I got nothing out, and I just 
> decided to give it a try.
> To me this is somewhat confusing: I thought the physical address of 
> those register were 0xd0000000 (according to the hardware specification) 
> and that the U-boot remapped those to the virtual address 0xf1000000. 

0xf1000000 is not a virtual address, it's a physical address. The SoC
has the capability of defining where its internal registers are located
in terms of physical address. Out of reset, they are mapped at
0xd0000000, but by using one register, you can remap them to some other
location. The tradition for most Marvell EBU bootloaders is to remap
them at 0xf1000000. This way, there is less space in the 0x0 ->
0xffffffff space used for registers, and therefore more RAM of the
first 4 GB is actually usable.

> Well, since it worked on another board with 0xd0000000 (ref. mail from 
> Gregory), I assume this is not so simple, and that this may vary 
> depending on how U-boot remaps the registers, or? I'm using the U-boot 
> provided by Marvell.

As said earlier, for most Marvell EBU platforms, the registers are
remapped by the bootloader at 0xf1000000. Except that there was a small
issue in early revisions of the Armada 370 and XP that broke some
features if another value than 0xd0000000 was used. For this
reason, some early Armada 370/XP platforms use old Marvell U-Boot
versions that keep registers at 0xd0000000. But more recent Marvell
U-Boot versions properly do the remapping at 0xf1000000 since the
hardware issue was fixed in the production silicon.

Bottom line is: depending on which bootloader version you're using, it
may be 0xd0000000 or 0xf1000000. From your bootloader, you can do:

	md 0xd0020080
	md 0xf1020080

If one crashes, then it's the other one that will work, and that will
tell you the location of the internal registers.

The trick is that as you can see, the register that configures the
address of the internal registers is itself part of the internal
registers :-)

> I have to debug further though, because it stopped with the message 
> bootconsole [...] disabled. I guess the problem is that the switch chip 
> (88E6532) is not detected (in the U-boot OK though, as egiga0), and this 
> is my only way out.... (SGMII->PHY)

Seems weird. If you have an UART plugged in, a switch chip should
definitely not cause the kernel to hang in its boot process. Do you
have the correct console=ttySx,115200 parameter passed in the kernel
command line? It seems like after switching from the early console to
the real console, you stop having messages, which might indicate a
wrong console= value.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
