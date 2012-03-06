From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 10:21:40 -0700
Subject: obtaining a regulator from a phandle
In-Reply-To: <20120306113947.GA22769@avionic-0098.mockup.avionic-design.de>
References: <20120305152157.GA12927@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861C09@HQMAIL01.nvidia.com>
 <20120305165514.GA21298@avionic-0098.adnet.avionic-design.de>
 <20120306113947.GA22769@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F5647A4.2060205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 04:39 AM, Thierry Reding wrote:
...
> And this is precisely where things get ugly. Now there is a dependency
> problem between the fixed regulator and the PMU which provides the GPIO. Both
> the PMU and the fixed regulator are setup via subsys_initcall(), and the
> regulator beats the PMU, resulting in the fixed regulator being unable to get
> the GPIO because it hasn't been setup yet. So I remembered Grant's deferred
> probing patch from yesterday and thought I'd try it out. This worked great,
> and the fixed regulator was properly set up after all other devices had been
> probed.

It's great that worked out.

> The PCIe driver now also needs deferred probing until the fixed regulator is
> present, which also works as expected. But then the problems start. Since now
> we're so far into the boot process that all __init{,data} is gone, therefore
> pci_common_init() is no longer present, resulting in an ugly crash.
> 
> So the only way I see out of this is patch up everything so that PCI
> initialization can actually be done after init memory is freed. This would
> have the added benefit that the driver could actually be built as a module.
> 
> Does anyone see another (easier) way out of this?

To me, that sounds like exactly how to solve it. You can probably mark
the code __devinit rather than just removing all the decorations
completely. You probably want to run this by the core ARM maintainers
though; I CC'd Russell and the ARM mailing list for comment.
