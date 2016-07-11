From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 11 Jul 2016 18:38:10 +0200
Subject: [PATCH 2/2] soc: samsung: Add support for Exynos7 PMU
In-Reply-To: <CAM4voanpvkQJ5GcKeXoLcpmTMXkh7f8aznQHDS-0O5YeaVpeuw@mail.gmail.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-3-git-send-email-a.kesavan@samsung.com>
 <CAJKOXPc=RZEe_zQvnmxXRttppJfGJwyjmkF0XxAnV0YnGxvcyA@mail.gmail.com>
 <CAM4voanpvkQJ5GcKeXoLcpmTMXkh7f8aznQHDS-0O5YeaVpeuw@mail.gmail.com>
Message-ID: <5783CB72.6030501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 04:44 PM, Abhilash Kesavan wrote:
>>> +       /*
>>> >> +        * Set clock freeze cycle count to 0 before and after arm clamp or
>>> >> +        * reset signal transition
>>> >> +        */
>>> >> +       node = of_find_compatible_node(NULL, NULL,
>>> >> +                               "samsung,exynos7-clock-atlas");
>>> >> +       if (node) {
>>> >> +               atlas_cmu_base = of_iomap(node, 0);
>>> >> +               if (!atlas_cmu_base)
>>> >> +                       return;
>>> >> +
>>> >> +               __raw_writel(0x0,
>>> >> +                               atlas_cmu_base + EXYNOS7_CORE_ARMCLK_STOPCTRL);
>>> >> +               iounmap(atlas_cmu_base);
>> >
>> > Missing:
>> > of_node_put(node);
>> >
>> > ...but I think this creates unnecessary dependency on different
>> > compatible. I understand that disabling the EXTENDED_CLKSTOP is needed
>> > after configuring the PMU so this code belongs here. However
>> > everything you need is just a mapping of CMU address. The PMU driver
>> > should receive in bindings everything it needs to do its work. Either
>> > it is a phandle to something or an address for iomap. In this case the
>> > PMU should probably get two addresses: PMU and optionally CMU (part of
>> > CMU for example). Of course bindings would have to be updated.
>
> I will add an optional CMU phandle to the PMU bindings.

We could additionally split the CMU_ATLAS region into 2 regions in DT
(derived from exynos7420 documentation):

reg = <0x11800000 0xF08>, // offsets 0x0000...0x0F04
      <0x11801000 0x8C>,  // offsets 0x1000...0x1088

so that the first can be mapped by the clk driver and the second by 
the PMU driver? It seems the first region is strictly clock functionality
related, while the second contains power control related and other 
registers.

However I'm not sure it is a good idea, for consistency this would need 
to be done also for CMU_APOLLO, CMU_MIF{0...3}.  All these CMUs don't have 
DT bindings defined yet though and there is no corresponding dts entries.

-- 
Thanks,
Sylwester
