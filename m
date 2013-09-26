From: leoy@marvell.com (Leo Yan)
Date: Thu, 26 Sep 2013 19:12:53 +0800
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <20130924130012.GE25907@arm.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
 <524021EC.2000207@marvell.com>
 <20130923152606.GA6157@e102648.cambridge.arm.com>
 <5240F246.6050402@marvell.com>
 <20130924090236.GY10174@e102648.cambridge.arm.com>
 <52417C4D.1030009@marvell.com> <20130924130012.GE25907@arm.com>
Message-ID: <524416B5.3040303@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 09:00 PM, Catalin Marinas wrote:
> On Tue, Sep 24, 2013 at 12:49:33PM +0100, Leo Yan wrote:
>> On 09/24/2013 05:02 PM, Achin Gupta wrote:
>>> On Tue, Sep 24, 2013 at 03:00:38AM +0100, Leo Yan wrote:
>>>> Here have another question, ARM have the example code for boot wrapper
>>>> which will switch from EL3 to secure EL1 rather than non-secure's EL1?
>>>
>>> I dont' think we do but let me check. Switching to S-EL1 instead of
>>> NS-EL1 should be a matter of _not_ setting the SCR_EL3.NS bit before
>>> doing the exception level change (ERET).
>>
>> I quick try with below patch for boot wrapper, i saw foundataion model
>> cannot boot up successfully and there have no console output; suppose
>> it's hang at some boot operations, but now foundation model cannot debug
>> low level code, so i cannot debug further more. :-(
>>
>> diff --git a/boot.S b/boot.S
>> index a1f25e2..2f1b867 100644
>> --- a/boot.S
>> +++ b/boot.S
>> @@ -19,7 +19,6 @@ _start:
>>           b.ne    start_ns                        // skip EL3 initialisation
>>
>>           mov     x0, #0x30                       // RES1
>> -       orr     x0, x0, #(1 << 0)               // Non-secure EL1
>>           orr     x0, x0, #(1 << 8)               // HVC enable
>>           orr     x0, x0, #(1 << 10)              // 64-bit EL2
>>           msr     scr_el3, x0
>
> You also need to make sure the boot wrapper starts the kernel in S-EL1
> rather than NS-EL2.
>

Hi Catalin,

I tried to use below modification, but it still failed to boot up on 
foundation model; pls help review if convienence.

Also, i reviewed the kernel's code, the kernel will check if the core is 
NS-EL2 and will switch to NS-EL1; do u think this code will conflict w/t 
the core run into the kernel with S-EL1 state?

diff --git a/boot.S b/boot.S
index a1f25e2..f5683d6 100644
--- a/boot.S
+++ b/boot.S
@@ -19,7 +19,6 @@ _start:
         b.ne    start_ns                        // skip EL3 initialisation

         mov     x0, #0x30                       // RES1
-       orr     x0, x0, #(1 << 0)               // Non-secure EL1
         orr     x0, x0, #(1 << 8)               // HVC enable
         orr     x0, x0, #(1 << 10)              // 64-bit EL2
         msr     scr_el3, x0
@@ -62,7 +61,7 @@ _start:
          * Prepare the switch to the EL2_SP1 mode from EL3
          */
         ldr     x0, =start_ns                   // Return after mode switch
-       mov     x1, #0x3c9                      // EL2_SP1 | D | A | I | F
+       mov     x1, #0x3c5                      // EL1_SP1 | D | A | I | F
         msr     elr_el3, x0
         msr     spsr_el3, x1
         eret

> BTW, why do you need this? There are no virtualisation features
> supported on the secure side.

So far the virtualisation is not a mandatory feature in short term due 
now our product is mainly focusing on the mobile product, so firstly we 
want to enable Linux kernel directly on secure world; just like we do 
same as ARMv7.

 From the previous discussion of MCPM, I understand this is not very 
consolidate w/t ARM's original idea of generic firmware (including 
PSCI); but actually i also think this is not confict.

because even the kernel run in S-EL1, we also can call SMC to switch to 
monitor mode and call PSCI related APIs, so whatever the kernel run in 
which world, eventually the firmware and PSCI will both support them. 
pls correct me if i misunderstand for this.

Thx,
Leo Yan
