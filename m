From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 4 Jul 2014 11:00:28 -0600
Subject: [PATCH] arm64: PCI(e) arch support
In-Reply-To: <4342569.JSAyWBcJn2@wuerfel>
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
 <53B5F81B.8010801@freescale.com>
 <20140704094440.GC6501@e106497-lin.cambridge.arm.com>
 <4342569.JSAyWBcJn2@wuerfel>
Message-ID: <20140704170028.GB1736@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 12:21:00PM +0200, Arnd Bergmann wrote:

> However, what do we do about PCI hosts that can be used with different
> kinds of systems? Do we assume that they all do PCI resource allocation?
> Can we decide this on a per host driver basis, or do we need to introduce
> an extension to the PCI DT binding to make that decision?

If the firmware sets everything up, and standard ECAM/CAM config space
is provided, then Will's simple generic driver should be selected. The
kernel shouldn't even be using code to manipulate the host
bridge. This is the x86 model.

If it is more embedded focused and firmware doesn't do much, then a
different compatible string and different driver can be used that does
have any special setup code..

The HW needs to be designed to support this, so it actually has to
imeplement configuration access properly, it can't split the config
space for the bridge with config space for the downstream, for
instance. It must implement something sensible for root port bridge
windows, and a few other common sense things.

Things are going to need to work like this anyhow on any HW that
expects to suport ACPI...

It is OK for the kernel to reconfigure the BARs and other things as it
likes, so long as the configuration access mechanism is working
properly according to the spec. IIRC it does a bit of a hybrid on x86
where it tries to leave things alone that are OK, and fix up things
that are not OK.

Jason
