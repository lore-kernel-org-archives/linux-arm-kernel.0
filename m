From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Jun 2016 20:54:09 -0500
Subject: [PATCH v2 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1464755400-6825-2-git-send-email-wenyou.yang@atmel.com>
References: <1464755400-6825-1-git-send-email-wenyou.yang@atmel.com>
 <1464755400-6825-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160603015409.GA18051@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 12:29:59PM +0800, Wenyou Yang wrote:
> In order to the save power consumption, as a workaround, suspend
> forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> 
> This suspend operation must be done before the USB clock is disabled,
> resume after the USB clock is enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - Add compatible to support forcibly suspend the ports.
>  - Add soc/at91/at91_sfr.h to accommodate the defines.
>  - Add error checking for .sfr_regmap.
>  - Remove unnecessary regmap_read() statement.
> 
>  .../devicetree/bindings/usb/atmel-usb.txt          |  5 +-
>  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
>  include/soc/at91/at91_sfr.h                        | 29 ++++++++
>  3 files changed, 111 insertions(+), 3 deletions(-)
>  create mode 100644 include/soc/at91/at91_sfr.h
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 5883b73..3e3e58a 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -3,8 +3,9 @@ Atmel SOC USB controllers
>  OHCI
>  
>  Required properties:
> - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> -   used in host mode.
> + - compatible: Should be one of the following
> +	       "atmel,at91rm9200-ohci" for USB controllers used in host mode.
> +	       "atmel,sama5d2-ohci" for SAMA5D2 which can force to suspend.

That may be why you need this now, but that is irrelevant to having a 
chip specific compatible string.

Rob
