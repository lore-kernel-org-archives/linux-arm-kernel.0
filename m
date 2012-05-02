From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 May 2012 11:07:45 -0700
Subject: [PATCH 3/7] mmc: dw_mmc: add device tree support
In-Reply-To: <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 1, 2012 at 10:07 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> Add device tree based discovery support.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> ?.../devicetree/bindings/mmc/synposis-dw-mshc.txt ? | ? 85 +++++++++
> ?drivers/mmc/host/dw_mmc-pltfm.c ? ? ? ? ? ? ? ? ? ?| ? 24 +++
> ?drivers/mmc/host/dw_mmc.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ?181 +++++++++++++++++++-
> ?drivers/mmc/host/dw_mmc.h ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 10 +
> ?include/linux/mmc/dw_mmc.h ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?5 files changed, 296 insertions(+), 6 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> new file mode 100644
> index 0000000..c1ed70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> @@ -0,0 +1,85 @@
> +* Synopsis Designware Mobile Storage Host Controller
> +
> +The Synopsis designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following
> + ? ? ? - synopsis,dw-mshc: for controllers compliant with synopsis dw-mshc.
> +
> +* reg: physical base address of the dw-mshc controller and size of its memory
> + ?region.
> +
> +* interrupts: interrupt specifier for the controller. The format and value of
> + ?the interrupt specifier depends on the interrupt parent for the controller.
> +
> +# Slots: The slot specific information are contained within child-nodes with
> + ?each child-node representing a supported slot. There should be atleast one
> + ?child node representing a card slot. The name of the slot child node should
> + ?be 'slot{n}' where n is the unique number of the slot connnected to the
> + ?controller. The following are optional properties which can be included in
> + ?the slot child node.

Since we're talking slots / cards on a bus, I think the addressing
model would be useful here. So in the main controller node:
    #address-cells = <1>;
    #size-cells = <0>;

And then each slot would need a reg property and possibly unit address:

   slot {
        reg = <0>;
        ...
   };

(unit addresses on the slots are only needed if they can't be
disambiguated by name, so not needed if you only have one slot).


-Olof
