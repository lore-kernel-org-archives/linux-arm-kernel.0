From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Jun 2015 19:24:01 +0200
Subject: mvebu: Problem booting Armada XP with mainline U-Boot
In-Reply-To: <558A9EBA.9000902@denx.de>
References: <558A9EBA.9000902@denx.de>
Message-ID: <20150624192401.650b0206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stefan Roese,

On Wed, 24 Jun 2015 14:12:42 +0200, Stefan Roese wrote:

> a) Secondary CPU(s) fail to come online:
> 
> ...
> [    0.130692] CPU: Testing write buffer coherency: ok
> [    0.135785] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.141892] Setting up static identity map for 0x82c0 - 0x8318
> [    0.148013] mvebu-soc-id: MVEBU SoC ID=0x7846, Rev=0x2
> [    0.153357] mvebu-pmsu: Initializing Power Management Service Unit
> [    0.160323] Booting CPU 1
> [    1.158867] CPU1: failed to come online
> [    1.162960] Booting CPU 2
> [    2.158866] CPU2: failed to come online
> [    2.162954] Booting CPU 3
> [    3.158865] CPU3: failed to come online
> [    3.162810] Brought up 1 CPUs
> [    3.165870] SMP: Total of 1 processors activated (1594.16 BogoMIPS).
> [    3.172329] CPU: All CPU(s) started in SVC mode.
> ...

This one I don't really have an idea, it needs some investigation.

> b) Booting hangs completely while/after loading some device drivers:
> 
> ...
> [    4.031651] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    4.038209] ehci-pci: EHCI PCI platform driver
> [    4.042694] ehci-orion: EHCI orion driver
> [    4.046784] orion-ehci f1050000.usb: EHCI Host Controller
> [    4.052207] orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
> [    4.059851] orion-ehci f1050000.usb: irq 27, io mem 0xf1050000

Maybe missing USB PHY initialization or SERDES lanes initialization.
These are done by the binary header, so I guess they are missing in the
mainline U-Boot. We are hoping to work on such topics in the kernel in
the near future, though, so that the kernel is taking of PHY and SERDES
lanes initialization, and can also power them up/down for power
management needs.

> Any ideas why those problems might occur with mainline U-Boot?
> Most likely some register setup is missing that is usually done
> in bin_hdr. Where could I check / test for this CPU online
> problem?

Hard to say, probably the easiest is to read the binary header code to
see what they are doing.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
