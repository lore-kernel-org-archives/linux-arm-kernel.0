From: david@lechnology.com (David Lechner)
Date: Mon, 8 Jan 2018 10:29:08 -0600
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
Message-ID: <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2018 08:00 AM, Sekhar Nori wrote:
> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>> This adds a new binding for the PLL IP blocks in the mach-davinci family
>> of processors. Currently, only the SYSCLKn and AUXCLK outputs are needed,
>> but in the future additional child nodes could be added for OBSCLK and
>> BPDIV.
>>
>> Note: Although these PLL controllers are very similar to the TI Keystone
>> SoCs, we are not re-using those bindings. The Keystone bindings use a
>> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
> 
> Not sure what is meant by "legacy one-node-per-clock binding"

It's a term I picked up from of_clk_detect_critical()

  * Do not use this function. It exists only for legacy Device Tree
  * bindings, such as the one-clock-per-node style that are outdated.
  * Those bindings typically put all clock data into .dts and the Linux
  * driver has no clock data, thus making it impossible to set this flag
  * correctly from the driver. Only those drivers may call
  * of_clk_detect_critical from their setup functions.

> 
>> have a slightly different PLL register layout and a number of quirks that
>> can't be handled by the existing bindings, so the keystone bindings could
>> not be used as-is anyway.
> 
> Right, I think different register layout between the processors is the
> main reason for a new driver. This should be sufficient reason IMO.
> 
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   .../devicetree/bindings/clock/ti/davinci/pll.txt   | 47 ++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>> new file mode 100644
>> index 0000000..99bf5da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>> @@ -0,0 +1,47 @@
>> +Binding for TI DaVinci PLL Controllers
>> +
>> +The PLL provides clocks to most of the components on the SoC. In addition
>> +to the PLL itself, this controller also contains bypasses, gates, dividers,
>> +an multiplexers for various clock signals.
>> +
>> +Required properties:
>> +- compatible: shall be one of:
>> +	- "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
>> +	- "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
> 
> These PLLs are same IP so they should use the same compatible. You can
> initialize both PLLs for DA850 based on the same compatible.
> 

But they are not exactly the same. For example, PLL0 has 7 PLLDIV clocks while
PLL1 only has 3. PLL0 has PREDIV while PLL1 does not. PLL0 has certain SYSCLKs
that are fixed-ratio but PLL1 does not have any of these. There are even more
differences, but these are the ones we are actually using.

So, if we use the same compatible, we either have to come up with device tree
bindings to describe all of this (yuck) or I suppose we can look at the REVID
register to electronically determine exactly what we have. I went with the
simpler option of just creating two different compatible strings.
