From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 21 Dec 2017 21:15:47 -0600
Subject: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
In-Reply-To: <1513904194.25872.23.camel@mhfsdcap03>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
 <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
 <1513838476.23174.3.camel@mhfsdcap03>
 <1513839672.25872.13.camel@mhfsdcap03>
 <20171222002712.GE30595@bhelgaas-glaptop.roam.corp.google.com>
 <1513904194.25872.23.camel@mhfsdcap03>
Message-ID: <20171222031546.GF30595@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 08:56:34AM +0800, Honghui Zhang wrote:
> There's an internal control register that control the Vendor ID and
> device ID values, our designer leave the default value un-touched. I
> will set these values in that way for the next version of fix.

Then there's no problem.  The mtk_pcie driver is a platform driver
that claims the host controller based on an of_device_id from a device
tree.

Apparently the bridge is also materialized in PCI config space, which
is typical for x86 host bridges, and makes the bridge appear in
"lspci".  But drivers generally don't claim bridges that way.

You can just program the Vendor and Device IDs by writing the internal
control registers somewhere in the mtk_pci_probe() path.

Then you can set the class code the same way, using an internal
control register (if that's possible), or using a quirk with the
correct Mediatek Vendor ID (if there is no internal writable
register).

Bjorn
