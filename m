From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 May 2013 18:02:12 +0200
Subject: [PATCH V2] arm64: KVM: Fix
 =?UTF-8?Q?HCR=5FEL=32=20and=20VTCR=5FEL=32?=
 =?UTF-8?Q?=20configuration=20bits?=
In-Reply-To: <51910559.6060106@codeaurora.org>
References: <1368170630-19567-1-git-send-email-pranavkumar@linaro.org>
 <51910559.6060106@codeaurora.org>
Message-ID: <fae8138d41c55928a3c71b7073aea3b0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 May 2013 11:23:05 -0400, Christopher Covington
<cov@codeaurora.org> wrote:
> Hi Pranavkumar,
> 
> On 05/10/2013 03:23 AM, Pranavkumar Sawargaonkar wrote:
>> This patch does following fixes:
>> 
>> 1. Make HCR_* flags as unsigned long long constants
>> Reason : By default, compiler assumes numeric constants as
>> signed hence sign extending it when assigned to unsigned variable
>> such as hcr_el2 (in VCPU context). This accidently sets HCR_ID and
>> HCR_CD making entire guest memory non-cacheable. On real HW, this
>> breaks Stage2 ttbl walks and also breaks VirtIO.
>> 
>> 2. VTCR_EL2_ORGN0_WBWA and VTCR_EL2_IRGN0_WBWA macros.
>> 
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> ---
>>  arch/arm64/include/asm/kvm_arm.h |   73
>>  +++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 36 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_arm.h
>> b/arch/arm64/include/asm/kvm_arm.h
>> index 8ced0ca..14ead69 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -18,44 +18,45 @@
>>  #ifndef __ARM64_KVM_ARM_H__
>>  #define __ARM64_KVM_ARM_H__
>>  
>> +#include <linux/const.h>
>>  #include <asm/types.h>
>>  
>>  /* Hyp Configuration Register (HCR) bits */
>> -#define HCR_ID		(1 << 33)
>> -#define HCR_CD		(1 << 32)
>> +#define HCR_ID		(UL(0x1) << 33)
>> +#define HCR_CD		(UL(0x1) << 32)
> 
> Consider using the BIT() macro from linux/bitops.h to improve
readability.

This would probably cause problems when using these macros from assembly
code.

        M.
-- 
Fast, cheap, reliable. Pick two.
