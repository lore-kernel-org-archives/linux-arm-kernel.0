From: jim2101024@gmail.com (Jim Quinlan)
Date: Fri, 26 Jan 2018 12:46:44 -0500
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
In-Reply-To: <20180126075343.GB2356@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
 <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de>
 <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
 <20180123132033.GA21438@lst.de>
 <f746f9d5-b12d-9ffc-83e3-3851b4de6e52@gmail.com>
 <20180126075343.GB2356@lst.de>
Message-ID: <CANCKTBszKRp7gYKE=S3fA0=MoOVFFkO6PgmR476t3HAJ9US2gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 2:53 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jan 24, 2018 at 12:04:58PM -0800, Florian Fainelli wrote:
>> This looks nicer than the current shape, but this still requires to
>> register a PCI fixup to override phys_to_dma() and dma_to_phys(), and it
>> would appear that you have dodged my question about how this is supposed
>> to fit with an entirely modular PCIe root complex driver? Are you
>> suggesting that we split the module into a built-in part and a modular part?
>
> I don't think entirely modular PCI root bridges should be a focal point
> for the design.  If we happen to support them by other design choices:
> fine, but they should not be a priority.

I disagree.  If there is one common thing our customers request  it is
the ability to remove (or control the insmod of after boot)  the pcie
RC driver.  I didn't add this in as a "nice-to-have".

>
> That being said if we have core dma mapping or PCIe code that has
> a list of offsets and the root complex only populates them it should
> work just fine.

I'm looking at arch/arm/include/asm/dma-mapping.h.  In addition to
overriding dma_to_phsy() and phys_to_dma(), it looks like I may have
to define __arch_pfn_to_dma(), __arch_dma_to_pfn(),
__arch_dma_to_virt(), __arch_virt_to_dma().  Do  you agree or is this
not necessary?  If it is, this seems more intrusive than our
pcie-brcmstb-dma.c solution which  doesn't require tentacles into
major include files and Kconfigs.

Another issue is that our function wrappers -- depending upon whether
we are dealing with a pci device or not -- will have to possibly call
the actual ARM and ARM64 definitions of these functions, which have
been of course #ifdef'd out.  This means that our code must contain
identical copies of these functions' code and that the code must
somehow be kept in sync.  Do you see a solution to this?

Jim
