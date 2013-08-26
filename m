From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 Aug 2013 18:35:30 +0800
Subject: [PATCH v2 4/8] mtd: m25p80: add the DDR quad-read support
In-Reply-To: <521AF411.8000107@ti.com>
References: <1377492102-23543-1-git-send-email-b32955@freescale.com>
 <1377492102-23543-5-git-send-email-b32955@freescale.com>
 <521AF411.8000107@ti.com>
Message-ID: <521B2F72.5070203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?26? 14:22, Sourav Poddar ??:
> Hi,
> On Monday 26 August 2013 10:11 AM, Huang Shijie wrote:
>> This patch adds the DDR quad read support by:
>>
>> (1) Add the relative commands:
>> OPCODE_DDRQIOR, OPCODE_4DDRQIOR
>>
>> (2) add the "m25p,ddr-quad-read" property for the m25p80 driver
>> If the dts has the "m25p,ddr-quad-read" property, the kernel will
>> set the Quad bit of the configuration register, and when the
>> setting suceedes, we will set the read opcode with the right
>> spi nor command.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>> Documentation/devicetree/bindings/mtd/m25p80.txt | 5 +++++
>> drivers/mtd/devices/m25p80.c | 21 ++++++++++++++++-----
>> include/linux/mtd/spi-nor.h | 2 ++
>> 3 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt 
>> b/Documentation/devicetree/bindings/mtd/m25p80.txt
>> index b33313f..a01c6b7 100644
>> --- a/Documentation/devicetree/bindings/mtd/m25p80.txt
>> +++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
>> @@ -22,6 +22,11 @@ Optional properties:
>> all chips and support for it can not be detected at runtime.
>> Refer to your chips' datasheet to check if this is supported
>> by your chip.
>> +- m25p,ddr-quad-read : Use the "ddr quad read" opcode to read data 
>> from the chip
>> + instead of the usual "read" opcode. This opcode is not
>> + supported by all chips and support for it can not be detected
>> + at runtime. Refer to your chips' datasheet to check if this
>> + is supported by your chip.
>> Example:
>>
>> flash: m25p80 at 0 {
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 0645c9f..32ccdc7 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -913,7 +913,8 @@ static void m25p80_check_quad_read(struct m25p 
>> *flash, struct device_node *np)
>> int ret;
>> int sr_cr;
>>
>> - if (of_property_read_bool(np, "m25p,quad-read")) {
>> + if (of_property_read_bool(np, "m25p,quad-read")
>> + || of_property_read_bool(np, "m25p,ddr-quad-read")) {
>> /* The configuration register is set by the second byte. */
>> sr_cr = CR_QUAD<< 8;
>>
>> @@ -927,10 +928,20 @@ static void m25p80_check_quad_read(struct m25p 
>> *flash, struct device_node *np)
>> if (!(ret> 0&& (ret& CR_QUAD)))
>> return;
>>
>> - if (flash->mtd.size<= SZ_16M)
>> - flash->read_opcode = OPCODE_QIOR;
>> - else
>> - flash->read_opcode = OPCODE_4QIOR;
>> + if (of_property_read_bool(np, "m25p,quad-read")) {
>> + if (flash->mtd.size<= SZ_16M)
>> + flash->read_opcode = OPCODE_QIOR;
>> + else
>> + flash->read_opcode = OPCODE_4QIOR;
>> + return;
>> + }
>> +
>> + if (of_property_read_bool(np, "m25p,ddr-quad-read")) {
>> + if (flash->mtd.size<= SZ_16M)
>> + flash->read_opcode = OPCODE_DDRQIOR;
>> + else
>> + flash->read_opcode = OPCODE_4DDRQIOR;
>> + }
> I remember this getting asked in some other thread also...
> Quad read need dummy bits before reading out the data, what happens
> when the controller does not have LUT feature. ? 
I think the controller (not the QUADSPI) should submit a patch to fix it.

There are many different kinds of READs need the dummy, take S25FSL128S 
for example :

Fast-Read(dummy = 8),
Dual-Output Read(dummy = 8),
Dual I/O read(dummy = 4 for 3-byte; dummy = 2 for 4-byte)
.......
Quad i/o Read(dummy = 4)
DDR QUAD i/o Read(dummy = 8)
......................

Even the same spi command such as Dual I/O read (0xBB), different 
version of chips may require different
dummies.

-------------------------------------------------------------
So, the dummies are binded with the chips, not binded with the SPI 
commands.
-------------------------------------------------------------

We can not list all the dummies in the m25p_ids[] . It's not feasible.

An alternate method is to specific the dummy with the DT node, such as:
"m25p,quad-read = <4>", means this chip's Quad read needs dummy=4.



thanks
Huang Shijie
