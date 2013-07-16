From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 16 Jul 2013 20:51:37 +0200
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <20130716125531.GD2317@localhost>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51E5145A.90404@keymile.com> <20130716125531.GD2317@localhost>
Message-ID: <51E59639.3000207@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 07/16/2013 02:56 PM, Ezequiel Garcia wrote:
> Hi Gerlando,
>
> On Tue, Jul 16, 2013 at 11:37:30AM +0200, Gerlando Falauto wrote:
>>
>> apologies in advance for commenting on an already-merged patch.
>
> Sure, no problem.
>
>>
>> On 06/18/2013 05:31 PM, Ezequiel Garcia wrote:
>>> Although the internal register window size is 1 MiB, the previous
>>> ranges translation for the internal register space had a size of
>>> 0x4000000. This was done to allow the crypto and nand node to access
>>> the corresponding 'sram' and 'nand' decoding windows.
>>>
>>> In order to describe the hardware more accurately, we declare the
>>> real 1 MiB internal register space in the ranges, and add a translation
>>> entry for the nand node to access the 'nand' window.
>>>
>>> This commit will make future improvements on the MBus DT binding easier.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> ---
>>> Tested on Plathome Openblocks A6 board.
>>>
>>>    arch/arm/boot/dts/kirkwood.dtsi | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
>>> index 8a1e3bb..910fabc 100644
>>> --- a/arch/arm/boot/dts/kirkwood.dtsi
>>> +++ b/arch/arm/boot/dts/kirkwood.dtsi
>>> @@ -38,7 +38,8 @@
>>>
>>>    	ocp at f1000000 {
>>>    		compatible = "simple-bus";
>>> -		ranges = <0x00000000 0xf1000000 0x4000000
>>> +		ranges = <0x00000000 0xf1000000 0x0100000
>>> +		          0xf4000000 0xf4000000 0x0000400
>>>    		          0xf5000000 0xf5000000 0x0000400>;
>>
>> Apart from "consistency" with the following range (0xf5000000) used by
>> the crypto node, is there any reason why you did not do something like
>> this instead (which Valentin suggested, but I will take the blame for):
>>
>
> I'm not sure the reason is "consistency with the crypto node".
> There's an MBus window at 0xf4000000 for NAND, and that is what is described
> in the snippet above; and this is a better reason.
>
> That said, technically speaking, you can have any translation scheme you want,
> as long as it ends up in 0xf4000000.
>
>> -		ranges = <0x00000000 0xf1000000 0x4000000
>> +		ranges = <0x00000000 0xf1000000 0x0100000
>> +		          0x03000000 0xf4000000 0x0000400
>>     		          0xf5000000 0xf5000000 0x0000400>;
>>
>> This would keep a consistent addressing within the child device bus, and
>
> Could you explain how this "keeps a consistent addressing"?
> Frankly, I don't understand why you choose 0x3000000 ... am I missing something?

Actually, the only one missing something here is myself, as I do not 
quite have the full picture :-)
Mine was a bit of a "reverse allocation" -- we know we must end up at 
0xf4000000. Since all the addresses are shifted by 0xf1000000, here 
comes 0x03000000... But please see my last question further down.

>
> Also, speaking of "device bus" this nand node should be behind a devicebus node.
>
> 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000   /* internal-regs */
> 			  MBUS_ID(0x01, 0x2f) 0 0 0xf4000000 0x400>;
>
> 		devbus {
> 			status = "okay";
> 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x400>;
>
> 			/* nand */
> 			nand {
> 				compatible = "marvell,orion-nand";
> 				reg = <0 0x400>;
> 			};
> 		};

I believe that makes a lot more sense this way... I guess this feature 
(device bus) requires your latest set of patches, right? (either v7 as 
you posted yesterday or your tree at 
git://github.com/MISL-EBU-System-SW/mainline-public.git/marvell-mvebu-mbus-v7)

> (notice this will allow you to relocate the base address of the NAND windows
> easily if it conflicts with your PCIe needs).

I sort of had the impression I could do already do that somehow, though 
I am not quite sure anymore...

>> avoid a later incosistency between the "unit-address" and the first
>> "reg" address:
>>
>>>    		#address-cells = <1>;
>>>    		#size-cells = <1>;
>>> @@ -171,7 +172,7 @@
>>   >   		nand at 3000000 {
>> 		     ^^^^^^^
>
> Oh, this should be fixed. I just missed it, and nobody noticed either.
>

So, in the end, you think it's OK to have a set of nodes with "relative" 
addresses (gpio at 10140, serial at 12000 etc...) and some with "absolute" 
addresses (nand at 0xf4000000, where the ranges property does a 0-offset 
translation)?
Even though I understand this is just some transitional state, and it 
will all be fixed like your example above, once we get the rest of the 
rework merged (mbus/devbus).

Thanks a lot for your patience!
Gerlando
