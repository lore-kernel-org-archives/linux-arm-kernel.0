From: monstr@monstr.eu (Michal Simek)
Date: Wed, 12 Mar 2014 11:18:51 +0100
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <531F1E30.4040203@pengutronix.de>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD2C4.5060109@pengutronix.de>
 <f1e2f08f-05fc-40d3-8437-4c6817d631cb@AM1EHSMHS010.ehs.local>
 <531F0636.4050608@pengutronix.de>
 <a99feda0-7463-4781-bb73-90b99e65b014@CO9EHSMHS028.ehs.local>
 <531F1E30.4040203@pengutronix.de>
Message-ID: <5320348B.7030401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,


On 03/11/2014 03:31 PM, Marc Kleine-Budde wrote:
> On 03/11/2014 03:08 PM, Appana Durga Kedareswara Rao wrote:
> 
>>>>>> +   struct napi_struct napi;
>>>>>> +   u32 (*read_reg)(const struct xcan_priv *priv, enum xcan_reg reg);
>>>>>> +   void (*write_reg)(const struct xcan_priv *priv, enum xcan_reg reg,
>>>>>> +                   u32 val);
>>>>>> +   struct net_device *dev;
>>>>>> +   void __iomem *reg_base;
>>>>>> +   unsigned long irq_flags;
>>>>>> +   struct clk *aperclk;
>>>>>> +   struct clk *devclk;
>>>>>
>>>>> Please rename the clock variables to match the names in the DT.
>>>>>
>>>> The clock names are different for axi CAN and CANPS case.
>>>> So will make them as busclk and devclk Are you ok with this?
>>>
>>> Why not "ref_clk" and "aper_clk" as used in the DT?
>>>
>> One of the comments I got from the Soren(sorenb at xilinx.com)
>> Is the  clock-names must match the data sheet.
>> If I Modify the clock names then it is different names for AXI CAN
>> and CANPS case.
> 
> Sorry, my faul, I thought the names are already these from the
> datasheet. As S?ren pointed out please use 's_axi_aclk' and
> 'can_clk' for the DT and for the the variable names in the private
> struct, too.
> 
> The 'official' name of the ip core seems to be axi_can, should we rename
> the driver? I suspect, that Michal wants to keep xilinx in the name for
> marketing reasons :P

I hope that I am not moving to marketing position.  :-)

opb_can, plb_can, axi_can, amba_can are all valid options for this IP.

Maybe in future Xilinx will decide to use different bus and then will just move
all current soft IPs to new bus and drivers will be compatible.
This is exactly what happened when Xilinx moved from OPB to PLB and then
from PLB to AXI.
That's why I think in general having bus name in name doesn't fit for our case.

The same is for clock name which has bus name in it.
For PLB it was called SPLB_Clk and I don't have OPB version but
at least standalone driver points to OPB version where I believe
SPLB_Clk name was not used.

That's why if you want to reflect that clock is coming from bus
you should use any generic name. At least for these soft IPs
and this one is special because it is one which also went to silicon.
Next example is XADC.

That's why I just don't think we can find out better name than
xilinx_can.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/87c9427e/attachment-0001.sig>
