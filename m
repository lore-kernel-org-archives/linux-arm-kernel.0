From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 21 Jun 2018 09:21:06 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
In-Reply-To: <20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v@eucas1p1.samsung.com>
References: <20180618174216.24801-1-krzk@kernel.org>
 <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org>
 <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
 <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
 <20180620193407.gk5e5ecolo5bel3c@kozik-lap>
 <20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v@eucas1p1.samsung.com>
Message-ID: <CAJKOXPeCnRCR6q_QPAxxEA7Ej7qPfEm+n-SD6+81okhomj4MuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2018 at 07:59, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 20.06.2018 21:34, Krzysztof Kozlowski wrote:
>> On Tue, Jun 19, 2018 at 09:59:04AM +0200, Krzysztof Kozlowski wrote:
>>> On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
>>>>> The decon, decon_tv and dsi nodes have only one child port so
>>>>> address/size mappings are not necessary.  This fixes DTC warnings like:
>>>>>
>>>>>      Warning (graph_child_address): /soc/decon at 13800000/ports:
>>>>>          graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Works fine with current Exynos DRM Decon/MIC/DSI drivers.
>>>>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Thanks for review and testing!
>> I have second thoughs whether this patch is correct. AFAIU, the drivers
>> get the remote endpoints by reg==0 (for example the
>> of_graph_get_remote_node() in exynos_dsi_parse_dt()). If the port shall
>> be ignored, then reg==-1 should be passed.
>
> All this is about purity, DECON bindings says explicitly that there
> should be a port with reg=0.

The warnings themself are indeed about purity.... but not having
warnings is quite useful. When you have already warnings either in C
code or in DTC, it is quite easy to skip new ones.

We successfully get rid of all DTC warnings from ARM part. It would be
nice to have the same for ARM64... but not with a cost of making bogus
changes.

> So your patch and DTC warnings are incorrect from bindings PoV.

Good point so this patch should come along with changing of bindings
(and maybe the code as well to use -1 as port/reg).

> On the other side graph bindings are too bloated ( so many lines to
> describe one connection ) so I am happy if there are shrinking attempts :)
> Functionally nothing changes, of graph helpers assume reg=0 if it is not
> present in port/endpoint node.
>
> And regarding real issues, DECON could have more ports, possible candidates:
> - GSCALER0/1/2,
> - GSD/DSD - interconnect between GSCALERs and DECONs,
> - SMIES - image enhancer (not implemented),
> - MIC0/1 - image enhancers,
> - DSIM0/1 - DSI encoders,
> - HDMI - HDMI encoder.
>
> But since all these connections can be configured dynamically, and more
> importantly are inside specific SoC I dont think they need of_graphs. In
> fact I think current of graph is also not necessary, but this is
> different story, removal is on my long TODO list :)

I keep my fingers crossed for this :)

Best regards,
Krzysztof
