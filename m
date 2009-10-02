From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 2 Oct 2009 21:11:11 +0200
Subject: 2.6.32-rc1/2, arm and usb
In-Reply-To: <19138.34019.987851.150679@pilspetsen.it.uu.se>
References: <87ws3i40id.fsf@lechat.rtp-net.org>
	<19138.34019.987851.150679@pilspetsen.it.uu.se>
Message-ID: <19142.20559.308071.297716@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > Arnaud Patard (Rtp) writes:
 >  > I wanted yesterday to check that my iop sanmina support was still fine on
 >  > latest -rc kernel and found out that it was not booting anymore and last
 >  > thing printed on the serial console is "done. Booting the kernel". After
 >  > bisecting, the culprit is commit
 >  > db8be50c4307dac2b37305fc59c8dc0f978d09ea (in linus tree). Reverting it
 >  > allows to boot so this confirms the git bisect result.
 >  > 
 >  > The commit does this in drivers/usb/host/pci-quirks.c :
 >  > -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
 >  > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
 >  > 
 >  > Now, before collecting informations to report the problem to usb folks
 >  > and trying to debug further, I'm wondering if anyone else got this bug
 >  > or if I'm just unlucky and has a hardware-specific issue. Also, if
 >  > someone has an idea of what the problem may be or in which direction I
 >  > should look at, please share.
 > 
 > My iop n2100 shows the exact same problem with 2.6.32-rc1,
 > and reverting the commit mentioned above fixes it.
 > 
 > None of my other machines (including two non-iop arms, x86,
 > and ultrasparc) have this problem even though they all have
 > PCI usb controllers. So the problem looks iop-specific.

I wasn't able to make any of the console=uart8250 or earlycon=
stuff work, so I added a platform-specific n2100_puts() to my
kernel and added tracing output in init/main.c.

What happens on my IOP n2100 with 2.6.32-rc1 is the following:

start_kernel() -> rest_init() -> kernel_init() -> do_basic_setup() -> do_initcalls().
The 29th initcall is n2100_pci_init() which calls the ARM pci_common_init(),
which calls pcibios_init_hw(), which eventually calls quirk_usb_early_handoff(),
which calls uhci_check_and_reset_hc(), which calls uhci_reset_hc() which what
looks like a totally bogus I/O base address in unmapped space. The first outw()
in uhci_reset_hc() fails with a DataAbort, and the kernel oopses.

After changing quirk_usb_early_handoff back to a FIXUP_FINAL:

The n2100_pci_init() initcall completes Ok.
The 114th initcall is pci_init(), which calls quirk_usb_early_handoff(),
which calls quirk_usb_handoff_uhci(), which calls uhci_check_and_reset_hc(),
which calls uhci_reset_hc() with the correct I/O base and no DataAbort occurs.

So either ARM's or IOP's PCI init is broken and it needs to set up more
things before invoking generic kernel PCI stuff, including header fixups,
or the upstream commit is wrong in that it causes code to run before the
PCI device resources it accesses are guaranteed to exist.

/Mikael
