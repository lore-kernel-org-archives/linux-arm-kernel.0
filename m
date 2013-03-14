From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 14 Mar 2013 15:05:34 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
References: <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
 <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130314210534.GA18505@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 09:38:58PM +0100, Thierry Reding wrote:
> >                pci at 1,0 {
> >                         device_type = "pci";
> >                         assigned-addresses = <0x82000000 0 0x80000000  0 0x1000>;

Sorry, I missed this. The b,d,f bits should be set:

                        assigned-addresses = <0x82000800 0 0x80000000  0 0x1000>;


> >                         reg = <0x000800 0 0 0 0>;
> >                }
> >                pci at 2,0 {
> >                         device_type = "pci";
> >                         assigned-addresses = <0x82000000 0 0x80001000  0 0x1000>;

                         assigned-addresses = <0x82001000 0 0x80001000  0 0x1000>;


The 'ranges' stays the same, the PCI 3/2 parse will ignore the b,d,f
bits when comparing against ranges.

The use of r == 0 for assigned-addresses should be enough to
disambiguate this case from any future use of assigned-addresses - the
normal case has r == offset of the associated BAR != 0.

Cheers,
Jason
