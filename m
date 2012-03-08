From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 8 Mar 2012 19:37:31 +0100
Subject: [PATCH 06/11] PCI: Keep pci_fixup_irqs() around after init
In-Reply-To: <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
Message-ID: <20120308183731.GA25254@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bjorn Helgaas wrote:
> Hmm, your patch looks OK as far as it goes, but the implementation of
> pci_fixup_irqs() as a call-once-at-boot-time thing with a loop through
> all the PCI devices we've found so far looks completely broken with
> regard to hotplug.
> 
> Who does the swizzle for devices hot-added after boot?

Perhaps I should have mentioned this in the commit message, but the patch
isn't actually used in a hotplug scenario. In fact, the code is still run
once at boot time, only very late. Grant's deferred probing allows the
PCIe controller driver to postpone initialization until all the devices
that it depends on (regulators) have been probed. This has the side-effect
that the probing actually takes place *after* code and data annotated with
__init have already been freed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/e3caaac8/attachment.sig>
