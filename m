From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 26 Apr 2014 10:38:07 +0100
Subject: [PATCH 0/3] arm64: Default to non-coherent DMA ops
In-Reply-To: <CAL_JsqLbZDq36kfayBnnXw3UYwu_02WNCS2bqKS8iEzrG_CJeg@mail.gmail.com>
References: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
 <CAL_JsqLbZDq36kfayBnnXw3UYwu_02WNCS2bqKS8iEzrG_CJeg@mail.gmail.com>
Message-ID: <5FB9595D-1647-45FE-A68C-F4E6DA7FB77A@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 Apr 2014, at 19:19, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Apr 25, 2014 at 12:34 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> Following recent discussions and patch from Ritesh, I'm planning to
>> align the default DMA ops with 32-bit arm and make them non-coherent. In
>> addition, we need to make sure that devices marked explicitly as
>> coherent use the correct dma ops. Until Santosh's DMA patches get
>> reviewed/merged, the temporary solution is bus notifiers which check the
>> "dma-coherent" property and set the right dma ops.
> 
> Is this for 3.15? If not, don't you think Santosh's patches will be
> ready for 3.16.

I initially only wanted to push the default non-coherent patch in 3.15
(first in this series) before more people assume the DMA is coherent.
But since the xgene sata driver is already merged and expects coherent
DMA, I came up with this workaround (inspired by highbank ;)). It?s
not that the first patch breaks its functionality, it just makes it
slower.

> I need to take another look, but I'm pretty much happy
> with them. My only issue really is whether we want to spread the use
> of dma-coherent. Will did call my cute little property a hack, but I
> have yet to see anything better.

I agree, it?s the best we have so far. Maybe at some point we get
proper system topology description and we can treat ?dma-coherent?
as legacy property (but still support it). For arm64 we?ll soon need
to also describe whether iommu ops are needed and that?s no longer a
simple property.

Catalin
