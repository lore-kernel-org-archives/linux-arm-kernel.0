From: ccross@google.com (Colin Cross)
Date: Sat, 26 Mar 2011 15:52:04 -0700
Subject: Updated mach-types update
In-Reply-To: <20110320110322.GC16646@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=0o3y7sPFjcmW0OLyPuZ8+DQNggpH7VRDd9Q-R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 4:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Some may notice that the mach-types update in my tree has been replaced
> by a new update to the file, but with a difference:
>
> ?arch/arm/tools/mach-types | 2406 ++-------------------------------------------
> ?1 files changed, 89 insertions(+), 2317 deletions(-)
>
> It deletes a lot of entries.
>
> For a while now, I've been running a script each day after a pull from
> mainline which updates a flag in the machine database indicating whether
> an entry has existed in mainline at any point in time. ?The database also
> tracks the time which the last change made to any entry.
>
> Coupling these two bits of data together means that we can select entries
> from the machine database which are or have been in mainline, and which
> have been updated within the last twelve months. ?The above file reflects
> that, and reduces the file down to 1090 lines (including header).
>
> What this means is that any platform in the machine database which has not
> been submitted to mainline for 12 months since it was registered will be
> automatically dropped from the file, and the platform maintainer will need
> to either talk to me to get it reinstated before submission, or update the
> entry in some way to 'freshen' it.
>
> This does have the potential to go wrong if people start randomly changing
> the format of how they write the MACHINE_START() macro. ?If it's not found
> by:
>
> grep -rh --exclude=include --include='*.c' MACHINE_START arch/arm |
> ?grep -v '^#' | sed "s@[^(]*(\([^,]*\).*@ ('\1')@;2,\$s@^@,@"
>
> (which generates a subset of SQL) then it won't be kept. ?In other words,
> one line containing _at least_ this is the safest way:
>
> MACHINE_START(NAME,
>
> but this definitely won't work:
>
> MACHINE_START(
> ? ? ? ?NAME,
> ? ? ? ?"Gobovision's Funky Platform")
>

This breaks master with CONFIG_PCI=y:
  CC      arch/arm/kernel/bios32.o
arch/arm/kernel/bios32.c: In function 'pci_fixup_prpmc1100':
arch/arm/kernel/bios32.c:174: error: implicit declaration of function
'machine_is_prpmc1100'

I can't tell what the right fix is.  Deleting pci_fixup_prpmc1100
fixes it.  There is no machine for prpmc1100, but there is
CONFIG_ARCH_PRPMC1100 that enables machine IXCDP1100 in
arch/arm/mach-ixp4xx/ixdp425-setup.c.  Should bios32.c be using
machine_is_ixcdp1100?  The history is all pre-git.

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d86fcd4..e4ee050 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -159,31 +159,6 @@ static void __devinit pci_fixup_dec21285(struct
pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285,
pci_fixup_dec21285);

 /*
- * Same as above. The PrPMC800 carrier board for the PrPMC1100
- * card maps the host-bridge @ 00:01:00 for some reason and it
- * ends up getting scanned. Note that we only want to do this
- * fixup when we find the IXP4xx on a PrPMC system, which is why
- * we check the machine type. We could be running on a board
- * with an IXP4xx target device and we don't want to kill the
- * resources in that case.
- */
-static void __devinit pci_fixup_prpmc1100(struct pci_dev *dev)
-{
-	int i;
-
-	if (machine_is_prpmc1100()) {
-		dev->class &= 0xff;
-		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
-		}
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_IXP4XX, pci_fixup_prpmc1100);
-
-/*
  * PCI IDE controllers use non-standard I/O port decoding, respect it.
  */
 static void __devinit pci_fixup_ide_bases(struct pci_dev *dev)
