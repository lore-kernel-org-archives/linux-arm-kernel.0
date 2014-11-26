From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 26 Nov 2014 17:15:13 +1300
Subject: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
In-Reply-To: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-10-git-send-email-cernekee@gmail.com>
Message-ID: <547553D1.3070908@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26/11/14 13:49, Kevin Cernekee wrote:
> This handles the existing "big-endian" case, and in addition, it also does
> the right thing when "native-endian" is specified.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>   Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
>   Documentation/devicetree/bindings/usb/usb-ohci.txt | 2 ++
>   drivers/usb/host/ehci-platform.c                   | 2 +-
>   drivers/usb/host/ohci-platform.c                   | 2 +-
>   4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 43c1a4e..9505c31 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -12,6 +12,8 @@ Optional properties:
>    - big-endian-regs : boolean, set this for hcds with big-endian registers
>    - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>    - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> +   iff the kernel was compiled for big endian
s/iff/if
>    - clocks : a list of phandle + clock specifier pairs
>    - phys : phandle + phy specifier pair
>    - phy-names : "usb"
> diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> index 19233b7..3bb9673 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> @@ -9,6 +9,8 @@ Optional properties:
>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> +- native-endian : boolean, enables big-endian-regs + big-endian-desc
> +  iff the kernel was compiled for big endian
s/iff/if
>   - no-big-frame-no : boolean, set if frame_no lives in bits [15:0] of HCCA
>   - num-ports : u32, to override the detected port count
>   - clocks : a list of phandle + clock specifier pairs
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2f5b9ce..0da9d70 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -187,7 +187,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>   		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
>   			ehci->big_endian_desc = 1;
>   
> -		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
> +		if (of_device_is_big_endian(dev->dev.of_node))
>   			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
>   
>   		priv->phy = devm_phy_get(&dev->dev, "usb");
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 7793c3c..029a606 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -157,7 +157,7 @@ static int ohci_platform_probe(struct platform_device *dev)
>   		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
>   			ohci->flags |= OHCI_QUIRK_BE_DESC;
>   
> -		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
> +		if (of_device_is_big_endian(dev->dev.of_node))
>   			ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
>   
>   		if (of_property_read_bool(dev->dev.of_node, "no-big-frame-no"))
