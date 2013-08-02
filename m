From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 2 Aug 2013 16:00:20 +0300
Subject: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
In-Reply-To: <51FBAC21.2040609@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
 <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
 <51FBAC21.2040609@ti.com>
Message-ID: <51FBAD64.5090600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/13 15:54, Nishanth Menon wrote:
> On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
>> Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus.
>> With non-DT, the bus number was 3, and that is what is used in the
>> dss-common.c which contains the platform data for Panda's DVI.
>>
>> However, with DT, the bus number is 2. As we now only have DT boot for
>> Panda, we have to change the bus number to make DVI EDID read
>> operational.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/mach-omap2/dss-common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/dss-common.c
>> b/arch/arm/mach-omap2/dss-common.c
>> index 393aeef..043e570 100644
>> --- a/arch/arm/mach-omap2/dss-common.c
>> +++ b/arch/arm/mach-omap2/dss-common.c
>> @@ -42,7 +42,7 @@
>>
>>   /* Using generic display panel */
>>   static struct tfp410_platform_data omap4_dvi_panel = {
>> -    .i2c_bus_num        = 3,
>> +    .i2c_bus_num        = 2,
>>       .power_down_gpio    = PANDA_DVI_TFP410_POWER_DOWN_GPIO,
>>   };
>>
>>
> completely dumb question :) :
> why cant we have dts support for this instead of having to renumber
> every time?

What do you mean "every time"?

Feel free to help me develop the DT support for DSS =). When that's
done, we can remove all this code.

> Example: if -EPROBEDEFER is incurred due to some unexpected dependency,
> we'd have to redo the numbering in the kernel yet again.

Hmm, sorry? Do you mean that the i2c bus numbers can change "randomly"?

With board files they were numbered 1, 2, 3, 4, but with DT boot they
seem to be 0, 1, 2, 3. And as we have the current situation where omap4
boots with DT, but DSS does not have DT support, we add the DSS related
devices in a board-file-like-fashion.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/6f57aa2b/attachment.sig>
