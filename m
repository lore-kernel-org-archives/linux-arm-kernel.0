From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Jun 2016 11:03:05 +0100
Subject: [PATCH] PCI: layerscape: Add 'dma-coherent' property
In-Reply-To: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
References: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <57569BD9.2060701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 07:55, Liu Gang wrote:
> Add 'dma-coherent' description for PCI nodes.
>
> The 'dma-coherent' indicates that the hardware IP block can ensure
> the coherency of the data transferred from/to the IP block. This
> can avoid the software cache flush/invalid actions, and improve
> the performance significantly.

Note that depending on the exact details it may actually be *necessary* 
for correctness - if the properties of the system are such that 
cacheable writes from the root complex might allocate directly into some 
level of cache without going to RAM, then having the CPU think the 
device is non-coherent and thus invalidate the cache before reading back 
from the buffer will result in data loss. But yeah, the performance is 
the most visible aspect ;)

Robin.

> The PCI IP block of ls1043a has this capability, so adding
> this feature to improve the PCI performance.
>
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
> ---
>   Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index ef683b2..41e9f55 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -24,6 +24,9 @@ Required properties:
>     The first entry must be a link to the SCFG device node
>     The second entry must be '0' or '1' based on physical PCIe controller index.
>     This is used to get SCFG PEXN registers
> +- dma-coherent: Indicates that the hardware IP block can ensure the coherency
> +  of the data transferred from/to the IP block. This can avoid the software
> +  cache flush/invalid actions, and improve the performance significantly.
>
>   Example:
>
> @@ -38,6 +41,7 @@ Example:
>   		#address-cells = <3>;
>   		#size-cells = <2>;
>   		device_type = "pci";
> +		dma-coherent;
>   		num-lanes = <4>;
>   		bus-range = <0x0 0xff>;
>   		ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
>
