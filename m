From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:42 +0100
Subject: [RFC v3 00/13] ahci: add sunxi driver and cleanup imx driver
Message-ID: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v3 of my patchset for adding ahci-sunxi support. It has grown quite
a bit since I've been going for a more generic approach this time and I've
also cleaned up the ahci-imx driver to use the same generic approach.

History:

v1, by Olliver Schinagl:
This was using the approach of having a platform device which probe method
creates a new child platform device which gets driven by ahci_platform.c,
as done by ahci_imx.c .

v2, by Hans de Goede:
Stand-alone platform driver based on Olliver's work

v3, by Hans de Goede:
patch-series, with 4 different parts
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) New ahci-sunxi code only populating ahci_platform_data, passed to
   ahci_platform.c to of_device_id matching.
c) Refactor ahci-imx code to work the same as the new ahci-sunxi code, this
   is the reason why v3 is an RFC, I'm waiting for the wandboard I ordered to
   arrive so that I can actually test this.
d) dts bindings for the sunxi ahci parts

Parts a-c are intended for merging through the ata tree, the dts bindings
will be merged to Maxime Ripard's sunxi-dts tree.

I hope people like the new approach for dealing with of drivers which need
to provide ahci_platform_data. An alternate approach would be to export
ahci_probe (renamed to ahci_platform_probe) from ahci_platform.c, then
ahci_sunxi.c could have a probe function like this:

int ahci_sunxi_probe(struct platform_device *pdev) {
    pdev->dev.platform_data = &ahci_sunxi_pdata;
    return ahci_platform_probe(pdev);
}

And then each of ahci_platform, ahci_sunxi and ahci_imx could be its own
module (if build as module) rather then all of them being build into one
module.

Regards,

Hans
