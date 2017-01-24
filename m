From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jan 2017 14:15:05 +0000
Subject: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon erratum
 161010801
In-Reply-To: <58875B0D.4080303@huawei.com>
References: <5886262C.6070108@huawei.com>
 <58875B0D.4080303@huawei.com>
Message-ID: <20170124141505.GD7572@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 01:47:57PM +0000, Shameerali Kolothum Thodi wrote:
> The HiSilicon erratum 161010801 describes the limitation of certain
> HiSilicon platforms to support the SMMU mappings for MSI transactions.
> 
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the
> MSI payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.

Do you mean that the PCIe root controller looking at the (virtual)
addresses of DMA and comparing these against the (physical) address of
the ITS in order to determine if a write is an MSI?

I can't see anything in this patch specifically enabling bypass for
MSIs. Do writes to the ITS (physical) address always bypass the SMMU,
and go straight to the ITS? Regardless of translation applied to other
DMA?

It sounds like this will have severe implications for virtualization.

> Also these platforms doesn't have a proper IIDR
> register to use the existing IIDR based quirk mechanism.

What exactly is wrong with the IIDR on these platforms? That sounds like
an erratum as of itself.

What precise value do reads of the IIDR return? Or do reads result in
other erroneous behaviour?

Thanks,
Mark.
