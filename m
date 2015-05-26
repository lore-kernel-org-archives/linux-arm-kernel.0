From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Tue, 26 May 2015 10:49:51 +0800
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <5563451B.4050609@st.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com>
 <5562F0C9.4090007@hisilicon.com> <000001d096f1$93dca4e0$bb95eea0$@com>
 <5563451B.4050609@st.com>
Message-ID: <5563DF4F.4080601@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/25 23:51, Fabrice Gasnier wrote:
> Hi Zhou,
> 
> On 05/25/2015 03:48 PM, Jingoo Han wrote:
>>> >so how about we set 0 as default value of pp->root_bus_nr, then use
>>> >pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops, pp, &res);
>>> >to create root bus?
>> I agree with your opinion. However, I still want to wait for other
>> people's opinions. They will give good comments.
>> Thank you.
>>
>> Best regards,
>> Jingoo Han
>>
> I did a quick test with your patch in the context of another driver on arm32.
> Just to confirm I added as well pp->root_bus_nr = 0;
> 
> Then, I needed to add dummy pci_sys_data as suggested by Arnd in the first review :
> http://www.spinics.net/lists/linux-pci/msg40445.html
> 
>  struct pcie_port {
> +#ifdef CONFIG_ARM
> +    /*
> +     * this is a temporary hack to let the driver work on
> +     * both arm32 and arm64. it can be removed after the
> +     * arm32 cleanup is complete and bios32.c has stopped
> +     * referencing host->pci_sys_data.
> +     */
> +    struct pci_sys_data    dummy;
> +#endif
>      struct device        *dev;
> 
> 
> This looks like necessary as bios32 is dereferencing sysdata:
> struct pci_sys_data *sysdata = dev->bus->sysdata;
> 
> Best Regards,
> Fabrice
> 

Hi Fabrice,

Firstly, many thanks for your test :)

I am a little confused that pci_sys_data is still needed as we don't use the code
in bios32. What was the problem you met? Could you share me more information? Then
let's see how to solve the problem.

Thanks again and Best Regards,
Zhou

> .
> 
