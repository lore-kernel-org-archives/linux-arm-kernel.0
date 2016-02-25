From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Feb 2016 12:20:35 +0000
Subject: [PATCH 2/2] PCI: generic: add description of property
 "interrupt-skip-mask"
In-Reply-To: <1456401208-10136-2-git-send-email-thunder.leizhen@huawei.com>
References: <1456401208-10136-1-git-send-email-thunder.leizhen@huawei.com>
 <1456401208-10136-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160225122035.GB10593@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In future, please send the binding document first in a series, per point
3 of Documentation/devicetree/bindings/submitting-patches.txt. It makes
review easier/faster.

On Thu, Feb 25, 2016 at 07:53:28PM +0800, Zhen Lei wrote:
> Interrupt Pin register is read-only and optional. Some pci devices may use
> msi/msix but leave the value of Interrupt Pin non-zero.

Is that permitted by the spec? Surely 'optional' means it must be zero
if not implemented?

> In this case, the driver will print information as below: pci
> 0000:40:00.0: of_irq_parse_pci() failed with rc=-22
> 
> It's easily lead to misinterpret.

If this is limited to a subset of devices which we know are broken in
this regard, can we not handle these cases explicitly?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index 3f1d3fc..0f10978 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -70,6 +70,8 @@ Practice: Interrupt Mapping' and requires the following properties:
> 
>  - interrupt-map-mask : <see aforementioned specification>
> 
> +- interrupt-skip-mask: Explicitly declare which pci devices only use msi/msix
> +but leave the value of Interrupt Pin non-zero.

Unlike the rest of the interrupt mapping properties, this is not
described in  `Open Firmware Recommended Practice: Interrupt Mapping'.

This needs a far more complete description.

This also doesn't strike me as th right approach. The interrupt-map-mask
property describe as relationship between the host-controller-provided
interrupt lines and endpoints, while this seems to be a bug completely
contained within an endpoint.

Thanks,
Mark.

> 
>  Example:
> 
> --
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
