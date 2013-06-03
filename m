From: monstr@monstr.eu (Michal Simek)
Date: Mon, 03 Jun 2013 11:51:38 +0200
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <51AC5060.80806@linaro.org>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org>
Message-ID: <51AC672A.5050501@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/03/2013 10:14 AM, Daniel Lezcano wrote:
> On 05/31/2013 12:44 PM, Sanjay Singh Rawat wrote:
>> The current code considers every wakeup as spurious, which is not
>> correct. Handle the same way as other arm platforms are doing.
>>
>> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> 
>> ---
>>  arch/arm/mach-zynq/hotplug.c |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
>> index c89672b..a1ab22c 100644
>> --- a/arch/arm/mach-zynq/hotplug.c
>> +++ b/arch/arm/mach-zynq/hotplug.c
>> @@ -67,6 +67,13 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
>>  		dsb();
>>  		wfi();
>>  
>> +		if (pen_release == cpu_logical_map(cpu)) {
>> +			/*
>> +			 * OK, proper wakeup, we're done
>> +			 */
>> +			break;
>> +		}
>> +

what pen_release stands for?
I have looked at it and others platform are also using it in platsmp
code which is not zynq case.
How is it supposed to work and how this variable should be used?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/0494cd1f/attachment-0001.sig>
