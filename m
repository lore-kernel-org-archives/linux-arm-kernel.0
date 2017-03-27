From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 27 Mar 2017 15:45:05 +0100
Subject: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
In-Reply-To: <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
 <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
 <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
Message-ID: <3aec823d-d3c7-03d3-68f7-963d3649c184@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 27/03/17 15:34, Rob Herring wrote:
> On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>> it jumps to the parent node without examining the child node.
>> also with that, it throws "no dma-ranges found for node"
>> for pci dma-ranges.
>>
>> this patch fixes device node traversing for dma-ranges.
> 
> What's the DT look like that doesn't work?

The problem is the bodge in pci_dma_configure() where we don't have an
OF node for the actual device itself, so pass in the host bridge's OF
node instead. This happens to work well enough for dma-coherent, but I
don't think dma-ranges was even considered at the time.

As it happens I'm currently halfway through writing an experiment
wherein pci_dma_configure() creates a temporary child node for the
of_dma_configure() call if no other suitable alternative (e.g. some
intermediate bridge node) exists. How hard are you likely to NAK that
approach? ;)

> dma-ranges is supposed to be a bus property, not a device's property.
> So looking at the parent is correct behavior generally.

Indeed, this patch as-is will break currently correct DTs (because we
won't find dma-ranges on the device, so will bail before even looking at
the parent as we should).

Robin.

> 
> Rob
> 
