From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2018 09:01:19 +0200
Subject: [PATCH 3/6] PCI: layerscape: Add the EP mode support
In-Reply-To: <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com>
 <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
Message-ID: <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> From: Rob Herring <robh@kernel.org>
>> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
>>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>>>          "fsl,ls2088a-pcie"
>>>          "fsl,ls1088a-pcie"
>>>          "fsl,ls1046a-pcie"
>>>          "fsl,ls1012a-pcie"
>>> +  EP mode:
>>> +        "fsl,ls-pcie-ep"
>>
> > You need SoC specific compatibles for the same reasons as the RC.
>
> [Xiaowei Bao] I want to contains all layerscape platform use one compatible
> if the PCIe controller work in EP mode.

Do you mean only one of the SoCs that support RC mode has EP mode?
I think you still need a SoC specific compatible as Rob explained, in case
there will be a second one in the future.

If you want to ensure that you don't have to update the device driver
for each new chip that comes in when the EP mode is compatible,
the way this is handled is to list multiple values in the compatible
property, listing the first SoC that introduced the specific version of
that IP block as the most generic type, e.g.

  copatible = "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pcie-ep";

For consistency, it probably is best to match each RC mode value with
the corresponding EP mode string for each device that can support both
(if there is more than one).

      Arnd
