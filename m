From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 18 Jan 2014 22:49:17 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140117205432.GB5618@xanatos> (Sarah Sharp's message of "Fri,
 17 Jan 2014 12:54:32 -0800")
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos>
Message-ID: <87vbxhrmea.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have added Thomas in the recipients, because I guess he may be of some
help debugging the issue further. Thomas, the beginning of the thread is
here: http://thread.gmane.org/gmane.linux.usb.general/101531

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:

>> >>> I am slowly starting to see a bisect session coming ;-)
>> >>
>> >> Try reverting commit 60e102ac73cd40069d077014c93c86dc7205cb68.
>> >
>> > AFAICT, this commit does not exist in master (Linus tree), i.e. it is
>> > not in 3.13.0-rc8.
>> 
>> That commit is a stable backport of 9df89d85b407690afa46ddfbccc80bec6869971d 
>> which is in v3.13-rc8:
>> 
>> bjorn at nemi:/usr/local/src/git/linux$ git tag --contains 9df89d85b407690afa46ddfbccc80bec6869971d
>> usb-3.13-rc1
>> usb-3.13-rc3
>> usb-3.13-rc5
>> v3.13-rc1
>> v3.13-rc2
>> v3.13-rc3
>> v3.13-rc4
>> v3.13-rc5
>> v3.13-rc6
>> v3.13-rc7
>> v3.13-rc8
>
> Sorry for using the stable commit ID.  Arnaud, please try reverting
> commit 9df89d85b407690afa46ddfbccc80bec6869971d "usbcore: set
> lpm_capable field for LPM capable root hubs" and see if it fixes your
> issues.

Nope, 9df89d85b407690 does not fix the issue but I guess I found the
reason: I think the regression is not directly due to some usb/XHCI
related change. More below.

I started a git bisect session but I had to stop between the two
following commits, because the last ones I tested after those were just
not bootable.

 bad : f9efbce6334844c7f8b9b9459f6d7a6fbc2928e0 (merge commit)
 good: aac59e3efce3dca787b11e34726001603ce3d161 (merge commit)

At that point, I decided to switch to a manual review of the changes
introduced *between* those commits:

$ git log -p aac59e3efce3..f9efbce63348 | grep -c ^commit
524

I looked at which files where touched (387 in total) and dropped those
that are not use on my platform or cannot be suspected fo the bug. I
ended up w/:

  drivers/irqchip/irq-armada-370-xp.c
  drivers/pci/host/pci-mvebu.c

Which are modified by those commits:

  commit f5072dfbac05: PCI: mvebu: make local functions static
  commit 032b4c0cc321: PCI: mvebu: add I/O access wrappers
  commit 9f352f0e6c0f: PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
  commit cc54ccd9a696: PCI: mvebu: add support for Marvell Dove SoCs
  commit 52ba992e201f: PCI: mvebu: add support for reset on GPIO
  commit e5615c30c1c9: PCI: mvebu: remove subsys_initcall
  commit bf09b6ae588f: PCI: mvebu: increment nports only for registered ports
  commit b42285f66f87: PCI: mvebu: move clock enable before register access
  commit 5b4deb6526bd: PCI: mvebu: add support for MSI
  commit 31f614edb726: irqchip: armada-370-xp: implement MSI support
  commit 627dfcc249e2: irqchip: armada-370-xp: properly request resources
  
I started suspecting the introduction of MSI support in Marvell PCIe
host controller driver (FL1009 is on the PCIe bus) and compiled a
a 3.13.0-rc8 w/ CONFIG_PCI_MSI disabled (it was enabled in all my
previous tests): I did not manage to reproduce the issue with this
kernel. As a side note, commits 5b4deb6526bd, 31f614edb726 and
627dfcc249e2 are

ATM, I do not know if the problem is related to a bug in introduced MSI
support or some weird incompatibility of that functionality with the
FL1009 which would require some quirk in XHCI stack.

Thomas, I took a look at the changes but I am not familiar w/ how MSI
work. You may have an idea on what is going on here.

Cheers,

a+

ps: Thomas, this is completely unrelated but the code below caught my
eye at the beginning of a hunk in 31f614edb726. When CONFIG_PCI_MSI is
disabled, why is irqnr now compared to 1 instead of 0?

@@ -214,12 +365,39 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
                if (irqnr > 1022)
                        break;
 
-               if (irqnr > 0) {
+               if (irqnr > 1) {
                        irqnr = irq_find_mapping(armada_370_xp_mpic_domain,
                                        irqnr);
                        handle_IRQ(irqnr, regs);
                        continue;
                }
+
+#ifdef CONFIG_PCI_MSI
+               /* MSI handling */
+               if (irqnr == 1) {

The comparisonWhen CONFIG_PCI_MSI
