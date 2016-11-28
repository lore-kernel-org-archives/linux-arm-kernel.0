From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 28 Nov 2016 12:20:42 +0100
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
Message-ID: <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,

On 28/11/16 11:30, Adrian Hunter wrote:
> On 28/11/16 09:32, Michal Simek wrote:
>> +Sai for Xilinx perspective.
>>
>> On 25.11.2016 16:24, Sebastian Frias wrote:
>>> Hi,
>>>
>>> When using the Arasan SDHCI HW IP, there is a set of parameters called
>>> "Hardware initialized registers"
>>>
>>> (Table 7, Section "Pin Signals", page 56 of Arasan "SD3.0/SDIO3.0/eMMC4.4
>>> AHB Host Controller", revision 6.0 document)
>>>
>>> In some platforms those signals are connected to registers that need to
>>> be programmed at some point for proper driver/HW initialisation.
>>>
>>> I found that the 'struct sdhci_ops' contains a '.platform_init' callback
>>> that is called from within 'sdhci_pltfm_init', and that seems a good
>>> candidate for a place to program those registers (*).
>>>
>>> Do you agree?
> 
> We already killed .platform_init

I just saw that, yet it was the perfect place for the HW initialisation I'm
talking about.
Any way we can restore it?

> 
> What is wrong with sdhci_arasan_probe()?

Well, in 4.7 sdhci_arasan_probe() did not call of_match_device(), so I had
put a call to it just before sdhci_pltfm_init(), something like:

+static const struct of_device_id sdhci_arasan_of_match[] = {
+       {
+               .compatible = "arasan,sdhci-8.9a",
+               .data = &sdhci_arasan_ops,
+       },
+       {
+               .compatible = "arasan,sdhci-5.1",
+               .data = &sdhci_arasan_ops,
+       },
+       {
+               .compatible = "arasan,sdhci-4.9a",
+               .data = &sdhci_arasan_ops,
+       },
+       {
+               .compatible = "sigma,smp8734-sdio",
+               .data = &sdhci_arasan_tango4_ops,
+       },
+       { }
+};
+MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);

...

+       const struct of_device_id *match;
+
+       match = of_match_device(sdhci_arasan_of_match, &pdev->dev);
+       if (match)
+               sdhci_arasan_pdata.ops = match->data;

where 'sdhci_arasan_tango4_ops' contained a pointer to a .platform_init
callback.

However, as I stated earlier, an upstream commit:

commit 3ea4666e8d429223fbb39c1dccee7599ef7657d5
Author: Douglas Anderson <dianders@chromium.org>
Date:   Mon Jun 20 10:56:47 2016 -0700

    mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399

changed struct 'sdhci_arasan_of_match' to convey different data, which
means that instead of having a generic way of accessing such data (such
as 'of_match_device()' and ".data" field), one must also check for
specific "compatible" strings to make sense of the ".data" field, such as
"rockchip,rk3399-sdhci-5.1"

With the current code:
- there's no 'of_match_device()' before 'sdhci_pltfm_init()'
- the sdhci_pltfm_init() call is made with a static 'sdhci_arasan_pdata'
struct (so it cannot be made dependent on the "compatible" string).
- since 'sdhci_arasan_pdata' is the same for all compatible devices, even
for those that require special handling, more "compatible" matching code is
required
- leading to spread "compatible" matching code; IMHO it would be cleaner if
the 'sdhci_arasan_probe()' code was generic, with just a generic "compatible"
matching, which then proceeded with specific initialisation and generic
initialisation.

In a nutshell, IMHO it would be better if adding support for more SoCs only
involved changing just 'sdhci_arasan_of_match' without the need to change
'sdhci_arasan_probe()'.
That would clearly separate the generic and "SoC"-specific code, thus allowing
better maintenance.

Does that makes sense to you guys?

Best regards,

Sebastian

> 
>>>
>>> Best regards,
>>>
>>> Sebastian
>>>
>>>
>>> (*): This has been prototyped on 4.7 as working properly.
>>> However, upstream commit:
>>>
>>> commit 3ea4666e8d429223fbb39c1dccee7599ef7657d5
>>> Author: Douglas Anderson <dianders@chromium.org>
>>> Date:   Mon Jun 20 10:56:47 2016 -0700
>>>
>>>     mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
>>> ...
>>>
>>> could affect this solution because of the way the 'sdhci_arasan_of_match'
>>> struct is used after that commit.
>>>
>>
>>
> 
