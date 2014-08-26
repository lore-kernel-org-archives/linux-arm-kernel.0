From: ipaton0@gmail.com (Iain Paton)
Date: Tue, 26 Aug 2014 13:08:09 +0100
Subject: [PATCH 1/6] ARM: dts: microsom-ar8035: MDIO pad must be set open
 drain
In-Reply-To: <20140824095854.GR30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk> <53F9B416.5030907@gmail.com>
 <20140824095854.GR30401@n2100.arm.linux.org.uk>
Message-ID: <53FC78A9.2020907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/14 10:58, Russell King - ARM Linux wrote:
> On Sun, Aug 24, 2014 at 10:44:54AM +0100, Iain Paton wrote:
>> On 23/08/14 10:11, Russell King wrote:
>>> From: Rabeeh Khoury <rabeeh@solid-run.com>
>>> To: Shawn Guo <shawn.guo@freescale.com>
>>>
>>> MDIO pad must be set open drain.
>>>
>>> Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>> ---
>>>  arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
>>> index d16066608e21..db9f45b2c573 100644
>>> --- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
>>> @@ -17,7 +17,7 @@
>>>  	enet {
>>>  		pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
>>>  			fsl,pins = <
>>> -				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
>>> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
>>>  				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
>>>  				/* AR8035 reset */
>>>  				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
>>>
>>
>> Can you elaborate some more on the reasons for this?  
>>
>> I'd like to understand if it's something specific to the hardware on that 
>> board, or if other i.MX6 boards using the ar8035 are doing it wrong as well.
>>
>> The datasheet strongly suggests this is the correct thing to do as MDIO 
>> should electrically be open drain. However that suggests many more instances 
>> of this incorrect configuration exist which also need changed, and not just 
>> for ar8035.
>>
>> While I'm reluctant to attribute something like this to the fec/interrupt 
>> problems some people are seeing, I'd also like to be able to rule it out.
> 
> I'm merely passing the patch along; I've forwarded your question to
> Rabeeh via IRC, and may have an answer soon.
> 
> FYI, I've run for a long time (close to a year now) on various iMX6
> SolidRun platforms without the above patch and haven't seen a problem.
> I've now also running with it on Solo and Quad and haven't seen any
> ill effects there, despite the machines running root-NFS, doing
> regular compiles and git activity.

I've not seen any problems either.  Digging through IEEE 802.3 clause 22
only provides references to MDIO being implemented using a tri-state 
driver. Then in Clause 45 (10gig) there's a one liner saying it 'may' be 
implemented using open drain.

The i.MX6 manual specifically states support for Clause 22.

However, as 802.3 requires the pull-up be present, it seems unlikely there 
will be any practical difference between an implementation using open drain 
and tri-state signalling. Indeed, open drain would seem to be the logical
way to implement it electrically.

The AR8035 datasheet specifically marks MDIO and INT as being open drain,
however the KSZ9021 (as used on sabre-lite) datasheet doesn't, instead it 
marks them as Ipu/O (for Input with internal pull-up/Output).

I'd suggest that this is a question of correctness more than a practical 
problem and I have no objection to the patch being applied. 
