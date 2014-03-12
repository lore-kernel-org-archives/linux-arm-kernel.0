From: monstr@monstr.eu (Michal Simek)
Date: Wed, 12 Mar 2014 12:51:28 +0100
Subject: [PATCH 3/7] ARM: zynq: Hang iomapped slcr address on device_node
In-Reply-To: <CAOesGMjzNWXs26T2ZxGi=ASk2ETk0P5re-QdfwGT6O8M=5tDkA@mail.gmail.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
 <ae4583176ee5c9d8a8a2d53c000b86711eb66287.1389018985.git.michal.simek@xilinx.com>
 <CAOesGMjzNWXs26T2ZxGi=ASk2ETk0P5re-QdfwGT6O8M=5tDkA@mail.gmail.com>
Message-ID: <53204A40.4090805@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 10:26 PM, Olof Johansson wrote:
> On Mon, Jan 6, 2014 at 6:36 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>> For later usage by zynq clk driver.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  arch/arm/mach-zynq/slcr.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
>> index 9746de7..2891dcf 100644
>> --- a/arch/arm/mach-zynq/slcr.c
>> +++ b/arch/arm/mach-zynq/slcr.c
>> @@ -121,6 +121,8 @@ int __init zynq_early_slcr_init(void)
>>                 BUG();
>>         }
>>
>> +       np->data = (__force void *)zynq_slcr_base;
> 
> 
> This is quite unusual, we normally remap again if needed. Is there a
> reason you can't just have the driver request the resource and map it
> like most other ones do?

I took this patch from Steffen because remapping slcr again in clock
driver is another mapping for the same IP. Use one ioremap region
seems to me better if there is a way. Of course if this is strictly
prohibited we can do another mapping in clock driver.

Here is the RFC I have sent after my discussion with Arnd
that we should use early syscon initialization and regmap.
This is just RFC to show slcr cleaning up.
http://permalink.gmane.org/gmane.linux.kernel/1651213
(Here is broken CLK part because clk subsystem uses clk_readl/clk_writel
- changing this is discussed in other threads)

>From v1 - regmap device separation was applied by Mark
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/nodev

>From v2 - "mfd: syscon: Support early initialization"
I expected to get any comment from Arnd but I will respin this
based on Lee's comments

To summarize this for future I would like to use access with regmap
with one ioremap.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/f612458f/attachment.sig>
