From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Fri, 26 Oct 2018 07:42:11 +0000
Subject: [PATCH 3/6] PCI: layerscape: Add the EP mode support
In-Reply-To: <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com> <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
Message-ID: <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: arndbergmann@gmail.com <arndbergmann@gmail.com> On Behalf Of Arnd Bergmann
Sent: 2018?10?26? 15:01
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Cc: Rob Herring <robh@kernel.org>; bhelgaas at google.com; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li <leoyang.li@nxp.com>; kishon at ti.com; lorenzo.pieralisi at arm.com; gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com; pombredanne at nexb.com; shawn.lin at rock-chips.com; niklas.cassel at axis.com; linux-pci at vger.kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support

On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> From: Rob Herring <robh@kernel.org>
>> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
>>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>>>          "fsl,ls2088a-pcie"
>>>          "fsl,ls1088a-pcie"
>>>          "fsl,ls1046a-pcie"
>>>          "fsl,ls1012a-pcie
>>> +  EP mode:
>>> +        "fsl,ls-pcie-ep"
>>
> > You need SoC specific compatibles for the same reasons as the RC.
>
> [Xiaowei Bao] I want to contains all layerscape platform use one 
> compatible if the PCIe controller work in EP mode.

Do you mean only one of the SoCs that support RC mode has EP mode?
I think you still need a SoC specific compatible as Rob explained, in case there will be a second one in the future.

If you want to ensure that you don't have to update the device driver for each new chip that comes in when the EP mode is compatible, the way this is handled is to list multiple values in the compatible property, listing the first SoC that introduced the specific version of that IP block as the most generic type, e.g.

  copatible = "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pcie-ep";

For consistency, it probably is best to match each RC mode value with the corresponding EP mode string for each device that can support both (if there is more than one).

      Arnd
[Xiaowei Bao] My mean is that the ls-pcie-ep compatibles will contain all layerscape SOCs of NXP, e.g: ls1046a-pcie-ep, fsl,ls2088a-pcie-ep, ls2088a-pcie-ep and so on, other layerscape SOCs have not test except the ls1046a, I think it is compatible if the new chip or other SOCs use the DW core, OK, I will discuss this issue internally, and reply to you later.
