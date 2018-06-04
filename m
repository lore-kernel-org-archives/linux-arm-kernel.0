From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 4 Jun 2018 17:22:52 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: condor: specify EtherAVB PHY IRQ
In-Reply-To: <20180604103302.f5kx5fqhbl3ohfpi@verge.net.au>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
 <21578b79-7ba0-b3a6-ae45-7e9ffbb7c8db@cogentembedded.com>
 <20180604103302.f5kx5fqhbl3ohfpi@verge.net.au>
Message-ID: <049a712d-7381-c771-c352-6badc2978175@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2018 01:33 PM, Simon Horman wrote:

>> Specify EtherAVB PHY IRQ in the Condor board's device tree, now that
>> we have the GPIO support (previously phylib had to resort to polling).
>>
>> Based on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> ===================================================================
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> @@ -59,6 +59,8 @@
>>  	phy0: ethernet-phy at 0 {
>>  		rxc-skew-ps = <1500>;
>>  		reg = <0>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> 
> I don't see this documented. Perhaps I'm missing something obvious.

   Have you looked into the V3H PFC section for where in the GPSRs AVB_PHY_INT
is mapped?
   The Condor schematics doesn't explicitly list the GPIO for AVB_PHY_INT
because that signal is meant to be routed thru the MAC. Unfortunately, the
sh_eth/ravb drivers don't support the PHY interrupt (the phylib function,
phy_mac_interrupt() reporting the PHY interrupts routed thru MAC is clearly
inadequate as it wants the link state as an argument), so we have to resort
to the GPIO interrupts...

> Or you have some extra information or newer documentation?

   No.

> Also, given Olof Johansson's recent comments in ("Re: [GIT PULL] Renesas
> ARM64 Based SoC DT Updates for v4.18") please consider squashing this patch
> and the following one.

   Hm... note that the different Ether cores are involved in these 2 PHY IRQ
patches. If that's OK, I can merge the patches...

[...]

MBR< Sergei
