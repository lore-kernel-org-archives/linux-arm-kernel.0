From: monstr@monstr.eu (Michal Simek)
Date: Mon, 10 Feb 2014 08:03:43 +0100
Subject: [PATCH 01/10] watchdog: xilinx: Convert driver to the watchdog
 framework
In-Reply-To: <52F7DF2F.5060001@roeck-us.net>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <52F7DF2F.5060001@roeck-us.net>
Message-ID: <52F879CF.8080906@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2014 09:03 PM, Guenter Roeck wrote:
> On 01/31/2014 06:18 AM, Michal Simek wrote:
>> - Remove uneeded headers, fops functions
>> - Use xilinx_wdt prefix in start/stop/keepalive functions
>>    and in new structures
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Hi Michal,
> 
>>   static int xwdt_probe(struct platform_device *pdev)
>>   {
>>       int rc;
>> @@ -314,7 +184,7 @@ static int xwdt_probe(struct platform_device *pdev)
>>                       "xlnx,wdt-enable-once", NULL);
>>       if (tmptr == NULL) {
>>           pr_warn("Parameter \"xlnx,wdt-enable-once\" not found in device tree!\n");
>> -        xdev.nowayout = WATCHDOG_NOWAYOUT;
>> +        watchdog_set_nowayout(&xilinx_wdt_wdd, true);
> 
> Sure you want to set this to always true instead of using WATCHDOG_NOWAYOUT ?

I have checked it and
option CONFIG_WATCHDOG_NOWAYOUT - Disable watchdog shutdown on close

with this part in the header

100 #ifdef CONFIG_WATCHDOG_NOWAYOUT
101 #define WATCHDOG_NOWAYOUT               1
102 #define WATCHDOG_NOWAYOUT_INIT_STATUS   (1 << WDOG_NO_WAY_OUT)
103 #else
104 #define WATCHDOG_NOWAYOUT               0
105 #define WATCHDOG_NOWAYOUT_INIT_STATUS   0
106 #endif

enable once is hardware option and it means when this option is setup in
hw you can't stop watchdog. That's why I think that setting up true
instead of WATCHDOG_NOWAYOUT is correct.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/4b2e4d94/attachment.sig>
