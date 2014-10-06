From: monstr@monstr.eu (Michal Simek)
Date: Mon, 06 Oct 2014 19:54:53 +0200
Subject: [PATCH 3/3] ARM: zynq: Extend SLCR driver to read OCM
 configuration
In-Reply-To: <30d758b569504e88a9b4a999f08be17b@BN1AFFO11FD055.protection.gbl>
References: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
 <586ef67a22005316fd65cebbbd4019a8a2094e07.1412595859.git.michal.simek@xilinx.com>
 <30d758b569504e88a9b4a999f08be17b@BN1AFFO11FD055.protection.gbl>
Message-ID: <5432D76D.70004@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On 10/06/2014 05:59 PM, S?ren Brinkmann wrote:
> Hi Michal,
> 
> On Mon, 2014-10-06 at 01:44PM +0200, Michal Simek wrote:
>> Get OCM configuration from SLCR.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm/mach-zynq/slcr.c | 15 +++++++++++++++
>>  include/soc/zynq/common.h |  1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
>> index cb7c46165728..0c3e45090c09 100644
>> --- a/arch/arm/mach-zynq/slcr.c
>> +++ b/arch/arm/mach-zynq/slcr.c
>> @@ -27,6 +27,7 @@
>>  #define SLCR_A9_CPU_RST_CTRL_OFFSET	0x244 /* CPU Software Reset Control */
>>  #define SLCR_REBOOT_STATUS_OFFSET	0x258 /* PS Reboot Status */
>>  #define SLCR_PSS_IDCODE			0x530 /* PS IDCODE */
>> +#define SLCR_OCM_CFG_OFFSET		0x910 /* OCM Address Mapping */
>>
>>  #define SLCR_UNLOCK_MAGIC		0xDF0D
>>  #define SLCR_A9_CPU_CLKSTOP		0x10
>> @@ -126,6 +127,20 @@ void zynq_slcr_system_reset(void)
>>  }
>>
>>  /**
>> + * zynq_slcr_get_ocm_config - Get SLCR OCM config
>> + *
>> + * Return:	OCM config bits
>> + */
>> +u32 zynq_slcr_get_ocm_config(void)
>> +{
>> +	u32 val;
>> +
>> +	zynq_slcr_read(&val, SLCR_OCM_CFG_OFFSET);
>> +
>> +	return val;
>> +}
> 
> a different idea would be, instead of creating this specific API call
> for the OCMC to let the OCMC driver use regmap and making git a subnode
> of the SLCR.
> In the long run that might be a better option otherwise we'll end up
> with a whole bunch of zynq_slcr_get_foo() calls for each driver that
> needs to read an SLCR register.

yes using regmap is also possible and I know that.

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/59ff5cfe/attachment.sig>
