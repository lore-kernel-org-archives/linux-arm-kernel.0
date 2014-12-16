From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 10:54:29 +0100
Subject: [PATCH 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <548FFEB0.9080604@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
 <2577563.x0mEZJNVDQ@wuerfel> <548FFEB0.9080604@mm-sol.com>
Message-ID: <4673431.OTm9MABNvH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 11:43:12 Stanimir Varbanov wrote:

> >> +static int __init qcom_pcie_probe(struct platform_device *pdev)
> >> +{
> > 
> > I think it's a bug to mark this function as __init. It breaks
> > deferred probing and detaching/reattaching the device trough sysfs.
> > 
> 
> My bad, I have tried to avoid mismatch section warnings came up from
> dw_pcie_host_init() which is annotated as __init. Do you think we need
> to remove __init from dw_pcie_host_init() declaration and fix the
> drivers accordingly?

Yes, that's probably best. Initially, it was ok because all front-ends
of the dw-pcie driver were using module_platform_probe(), but that
is not the case any more, so now at least keystone, layerscape and
spear13xx are broken, and I think it's safer to change dw_pcie_host_init
than to rely on everyone using module_platform_probe() correctly.

	Arnd
