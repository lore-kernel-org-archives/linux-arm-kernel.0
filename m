From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 09:44:08 -0500
Subject: [PATCH v2 4/7] of: configure the platform device dma parameters
In-Reply-To: <53568641.2020300@ti.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <1397917972-6293-5-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqJJ4Cbh5poMa-KRwy+bp_t3VtRd7bCpcWey+DZ74eYHJQ@mail.gmail.com>
 <53568641.2020300@ti.com>
Message-ID: <CAL_JsqKe_L00P36UT7hizB=zAxCB0S_1kV3XEVGGbJOi27S84A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:09 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> Hi Rob,
>
> On 04/21/2014 05:58 PM, Rob Herring wrote:
>> On Sat, Apr 19, 2014 at 9:32 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>> Retrieve DMA configuration from DT and setup platform device's DMA
>>> parameters. The DMA configuration in DT has to be specified using
>>> "dma-ranges" and "dma-coherent" properties if supported.
>>>
>>> We setup dma_pfn_offset using "dma-ranges" and dma_coherent_ops
>>> using "dma-coherent" device tree properties.
>>>
>>> The set_arch_dma_coherent_ops macro has to be defined by arch if
>>> it supports coherent dma_ops. Otherwise, set_arch_dma_coherent_ops() is
>>> declared as nop.

[...]

>>>
>>> +       ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
>>> +       if (ret < 0) {
>>
>> Perhaps an error is not the right return for the default case. The
>> default should probably be dma_addr and paddr equal to 0 and size 4GB.
>
> The error code is needed here to properly distinguish the case when
> there are no "dma-ranges" defined in DT. Also, I think, that
> of_dma_get_range() shouldn't return any default values - It just
> has to get data from DT. And the caller should decide what to do
> with this data and how to handle error cases.
>
> So, I prefer to keep behavior as is:
> - in case of failure of_dma_get_range() will not touch values of
>   &dma_addr, &paddr, &size.

Fine, but that is not how of_dma_get_range currently behaves:

+       *dma_addr = of_read_number(ranges, naddr);
+       *paddr = of_translate_dma_address(np, ranges);
+       if (*paddr == OF_BAD_ADDR) {
+               pr_err("%s: translation of DMA address(%pad) to CPU
address failed node(%s)\n",
+                      __func__, dma_addr, np->full_name);
+               ret = -EINVAL;
+       }

Rob
