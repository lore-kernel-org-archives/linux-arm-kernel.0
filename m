From: per.forlin@stericsson.com (=?ISO-8859-1?Q?Per_F=F6rlin?=)
Date: Sat, 24 Sep 2011 11:32:48 +0200
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <4E7DA3C0.7000208@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2011 10:13 AM, Mika Westerberg wrote:
> On Sat, Sep 24, 2011 at 10:02:50AM +0200, Per Forlin wrote:
>> PC runs virtual addresses when calling cpu_v7_reset(). The MMU
>> is switched off and "mov pc, r0" sets pc back to
>> virtual addresses even though the MMU is switched off.
>> This will result in a crash if the pipeline delay after
>> MMU disable is one instruction. To prevent this set PC
>> to physical addresses before disabling the MMU.
>>
>> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>> ---
>>  arch/arm/mm/proc-v7.S |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 9049c07..f26e831 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -64,6 +64,7 @@ ENDPROC(cpu_v7_proc_fin)
>>   */
>>  	.align	5
>>  ENTRY(cpu_v7_reset)
>> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses
> 
> This only works on machines where PHYS_OFFSET is zero.
> 
You are right! Russell was very quick to point out the same thing. 

> IIRC, there is a P<->V offset calculated at boot time. Maybe you could use
> that instead here?
> 
I am trying to figure out how I can get the value of PHYS_OFFSET in assembler code (proc-v7.S).
I guess I could use the value calculated in arch/arm/kernel.head.S but wouldn't that make
this patch dependent on CONFIG_ARM_PATCH_PHYS_VIRT?

Regards,
Per
