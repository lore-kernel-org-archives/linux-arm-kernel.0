From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 16 May 2018 19:28:45 +0200
Subject: [PATCH 00/27] Add multi-channel and overheat IRQ support to
 Armada thermal driver
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Sat, 21 Apr 2018 17:12:28 +0200")
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <871seb33xu.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The only capability of the Armada thermal driver is currently just to
> read one sensor (the default one) per AP and one per CP.
>
> Actually, there is one sensor per core in the AP806 plus one sensor in
> the thermal IP itself. The CP110 just features one thermal sensor in its
> own thermal IP.
>
> Also, there is no need for the thermal core to poll the temperature of
> each sensor by software as this IP (at least for AP806 and CP110
> compatibles) features an hardware overheat interrupt.
>
> This series first improves the readability of this driver, then adds
> support for multi-channel thermal IPs, and finally adds support for the
> hardware overheat interrupt. The bindings and the device-trees are
> updated accordingly.
>
> Please note that the thermal IP raises SEI interrupts, from which the
> support as just been contributed and not merged yet. Applying the last
> DT patches referring to the 'sei' and 'icu_sei' nodes will require this
> feature [1] to have been accepted first.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/572852.html
>
> Thank you,
> Miqu?l
>
>
> Miquel Raynal (27):
>   thermal: armada: add a function that sanitizes the thermal zone name
>   thermal: armada: remove useless register accesses
>   thermal: armada: remove misleading comments
>   thermal: armada: rename the initialization routine
>   thermal: armada: dissociate a380 and cp110 ->init() hooks
>   thermal: armada: average over samples to avoid glitches
>   thermal: armada: convert driver to syscon register accesses
>   thermal: armada: use the resource managed registration helper
>     alternative
>   thermal: armada: add multi-channel sensors support
>   thermal: armada: remove sensors validity from the IP initialization
>   thermal: armada: move validity check out of the read function
>   thermal: armada: get rid of the ->is_valid() pointer
>   thermal: armada: add overheat interrupt support
>   dt-bindings: cp110: rename cp110 syscon file
>   dt-bindings: ap806: prepare the syscon file to list other syscons
>     nodes
>   dt-bindings: cp110: prepare the syscon file to list other syscons
>     nodes
>   dt-bindings: ap806: add the thermal node in the syscon file
>   dt-bindings: cp110: update documentation since DT de-duplication
>   dt-bindings: cp110: add the thermal node in the syscon file
>   dt-bindings: thermal: armada: add reference to new bindings
>   arm64: dts: marvell: rename ap806 syscon node
>   arm64: dts: marvell: move AP806/CP110 thermal nodes into a new syscon
>   arm64: dts: marvell: add thermal-zone node in ap806 DTSI file
>   arm64: dts: marvell: add macro to make distinction between node names
>   arm64: dts: marvell: add thermal-zone node in cp110 DTSI file
>   arm64: dts: marvell: add interrupt support to ap806 thermal node
>   arm64: dts: marvell: add interrupt support to cp110 thermal node
>
>  .../arm/marvell/ap806-system-controller.txt        |  55 +-
>  ...controller0.txt => cp110-system-controller.txt} |  66 +-
>  .../devicetree/bindings/thermal/armada-thermal.txt |   5 +
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  85 +-
>  arch/arm64/boot/dts/marvell/armada-common.dtsi     |   1 +
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  45 +-
>  drivers/thermal/armada_thermal.c                   | 875 ++++++++++++++++++---
>  7 files changed, 976 insertions(+), 156 deletions(-)
>  rename Documentation/devicetree/bindings/arm/marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} (83%)

What is the status of this series?
I am especially interested in the dt part.
Do you expect sending a new series modifying them?

Gregory

>
> -- 
> 2.14.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
