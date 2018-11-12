From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Mon, 12 Nov 2018 21:26:02 +0100
Subject: PCIe support in APQ8098-based board
In-Reply-To: <44260aa9-d01a-f9a5-a2e6-31f06de48d34@free.fr>
References: <44260aa9-d01a-f9a5-a2e6-31f06de48d34@free.fr>
Message-ID: <20181112202602.GA7649@centauri.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2018 at 11:26:29PM +0100, Marc Gonzalez wrote:
> Hello,

Hello Marc

> 
> I'm playing with an APQ8098-based board, which I got to boot an upstream
> v4.20-rc1 kernel to the command line, by reusing the msm8998-mtp.dts
> (IIUC apq8098 is the msm8998's "little brother", in that they are
> almost the same SoC, with some HW blocks missing in the apq8098).

That is correct.

> 
> I'm trying to get PCIe working on my eval board. I'm wondering if
> someone from qcom, codeaurora, or linaro has perhaps already done
> this work, and it's just not upstream yet?

Linaro will most likely look at this at some undefined time in the future.

Here are some hints in case you need this urgently:

msm8998 uses QCOM PCIe v2.3.3, which is supported by
drivers/pci/controller/dwc/pcie-qcom.c

I suggest that you look at:
arch/arm64/boot/dts/qcom/ipq8074.dtsi

However, note that the PCI ranges are different for this SoC compared to
ipq8074.

The correct ranges can be found here:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998.dtsi?h=msm-4.4#n2538

It also appears that drivers/clk/qcom/gcc-msm8998.c is missing some PCIe
resets.
The correct addresses for these clocks can be found here:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/clk/msm/clock-gcc-8998.c?h=msm-4.4

Note that the qcom_pcie_get_resources_2_3_3() will have to be modified
slightly for msm8998, since msm8998 only has 3 PCIe resets.


Kind regards,
Niklas

> 
> There seem to be proper drivers for the RC and the PHY, but some
> low-level stuff are missing (clocks, regulator, power domain).
> 
> drivers/pci/controller/dwc/pcie-qcom.c
> drivers/phy/qualcomm/phy-qcom-qmp.c
> 
> Regards.
