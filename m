From: robherring2@gmail.com (Rob Herring)
Date: Mon, 5 Aug 2013 22:29:13 -0500
Subject: [PATCH 3/5] ARM: highbank: enable DMA zone for LPAE
In-Reply-To: <20130806001127.GA23006@n2100.arm.linux.org.uk>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
 <1375743009-28972-3-git-send-email-robherring2@gmail.com>
 <20130806001127.GA23006@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLX_3J5GkGMhsH-XstAsuxa-et7BFLSVLC08x2+3oRagQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 5, 2013 at 7:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 05, 2013 at 05:50:07PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Some devices are restricted to 32-bit DMA. Thus the platform dma_zone_size
>> needs to be set. Otherwise dma-mapping code is complaining, e.g.
>>
>> calxedaxgmac fff50000.ethernet: coherent DMA mask 0xffffffff is smaller
>> than system GFP_DMA mask 0xffffffffffffffff
>
> Note that the patches I posted last week will fix that in a much nicer
> way, as we will only error if we actually have sufficient memory that
> the condition becomes problematical.

But in the Midway case it is problematic as we do have more than 4GB
with some masters being 32-bit. DMA zone is still the right way to
limit allocations to less than 4GB dma address, right?

> The other problem here is that we need to get better separation between
> what's a bus address and what's a physical address.

Right, but for Midway they are actually the same. There is no h/w
translation of 32-bit bus addresses to a >4GB physical address other
than with an IOMMU.

Rob
