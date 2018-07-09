From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Jul 2018 13:36:06 +0100
Subject: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
In-Reply-To: <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
Message-ID: <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/07/18 13:17, Michal Simek wrote:
> Hi Sudeep,
> 
> On 2.5.2018 12:30, Sudeep Holla wrote:
>> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
>> where the semantics are described by the PSCI specification itself as
>> well as vendor-specific resets. Currently only system warm reset
>> semantics is defined as part of architectural resets by the specification.
>>
>> This patch implements support for SYSTEM_RESET2 by making using of
>> reboot_mode passed by the reboot infrastructure in the kernel.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>>  include/uapi/linux/psci.h |  2 ++
>>  2 files changed, 23 insertions(+)
>>
>> v1->v2:
>> 	- Added mising static anotation to psci_system_reset2_supported
>> 	- Added missing ')' in the comment
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index c80ec1d03274..91748725534e 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>
>>  static u32 psci_cpu_suspend_feature;
>> +static bool psci_system_reset2_supported;
>>
>>  static inline bool psci_has_ext_power_state(void)
>>  {
>> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
>>
>>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>  {
>> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> 
> I am curious about this reboot_mode setup. I have grepped the kernel and
> reboot_mode is setup via kernel parameters at boot time.
> Shouldn't user decide what reboot type wants to do?
> 

I have almost forgotten how I tested this. IIRC and looking quickly @
kernel/reboot.c and __setup(reboot=,...), I recall passing reboot=w
while testing this. We can do something like what efi_reboot, but not
sure if we need that yet if users need too decide after boot.

-- 
Regards,
Sudeep
