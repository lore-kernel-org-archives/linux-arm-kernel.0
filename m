From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Apr 2016 09:57:59 +0100
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
In-Reply-To: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
Message-ID: <20160411085759.GA7088@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please Cc the device tree mailing list (devicetree at vger.kernel.org) when
sending device tree patches.

On Sat, Apr 09, 2016 at 11:50:23PM +0200, Rafa? Mi?ecki wrote:
> Some devices (e.g. Northstar ones) may have bridges that forward
> harmless errors to the ARM core. In such case we need an option to
> add a handler ignoring them.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt         |  6 ++++++
>  drivers/pci/host/pcie-iproc-platform.c                  |  2 ++
>  drivers/pci/host/pcie-iproc.c                           | 17 +++++++++++++++++
>  drivers/pci/host/pcie-iproc.h                           |  1 +
>  4 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index 01b88f4..c91b20a 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -22,6 +22,12 @@ Optional properties:
>  
>  - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
>  by the ASIC after power on reset. In this case, SW needs to configure it
> +- brcm,pcie-hook-abort-handler: During PCI bus probing (device enumeration)
> +  there can be errors that are expected and harmless. Unfortunately some bridges
> +  can't be configured to ignore them and they forward them to the ARM core
> +  triggering die().
> +  This property should be set in such case, it will make driver add its own
> +  handler ignoring such errors.

Rather than describing what the kernel should do, this should describe
the property of the hardware (e.g. this should be named something like
brcm,spurious-probing-abort).

Is there absolutely no mechanism to disable this, even if
board-specific?

Are the aborts synchronous or asynchronous?

When specifically do they actually occur?

Thanks,
Mark.
