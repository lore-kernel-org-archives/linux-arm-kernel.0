From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 17 Jul 2013 08:35:38 +0200
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <20130716125531.GD2317@localhost>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51E5145A.90404@keymile.com> <20130716125531.GD2317@localhost>
Message-ID: <51E63B3A.2010807@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 07/16/2013 02:56 PM, Ezequiel Garcia wrote:
[...]
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
>
> (notice this will allow you to relocate the base address of the NAND windows
> easily if it conflicts with your PCIe needs).

I am MAYBE slowly starting to understand this whole mbus rework.
Just one remark though: don't you think it would make sense to add 
something like:

#define MBUS_ID_INTERNAL_REGS	MBUS_ID(0xf0, 0x01)
#define MBUS_ID_NAND		MBUS_ID(0x01, 0x2f)

I personally have a hard time reading numeric values for 
GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH.

Thanks,
Gerlando

>
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
