From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 9 May 2014 16:53:19 +0200
Subject: [PATCH 68/97] ARM: l2c: sti: remove cache size override
In-Reply-To: <535F4B20.9090904@linaro.org>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHT-0001YK-DL@rmk-PC.arm.linux.org.uk> <535F4B20.9090904@linaro.org>
Message-ID: <536CEBDF.2000307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

On 04/29/2014 08:48 AM, Srinivas Kandagatla wrote:
> Hi Russell,
> Thankyou for the patch,
>
> The only issue I see is, on most of the STi SOCs the default value for
> AUXCTRL register is 0x0, so the waysize is not set.
I checked all the ARM SoCs we support currently.
Only STiH416 has its reset value at 0x0.

>
> The way size is different on some SOCs in the same series.
>
> Where is the way-size mentioned in this new style?

Then, I think it should be the role of the bootloaders to set it for 
STiH416 (I have been told U-Boot already does it).
Does it sound acceptable for you?

Best regards,
Maxime

>
> Thanks,
> srini
>
> On 28/04/14 20:31, Russell King wrote:
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>   arch/arm/mach-sti/board-dt.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
>> index dc8669efc12d..cf716ae10726 100644
>> --- a/arch/arm/mach-sti/board-dt.c
>> +++ b/arch/arm/mach-sti/board-dt.c
>> @@ -16,15 +16,9 @@
>>
>>   void __init stih41x_l2x0_init(void)
>>   {
>> -    u32 way_size = 0x4;
>> -    u32 aux_ctrl;
>> -    /* may be this can be encoded in macros like BIT*() */
>> -    aux_ctrl = L2C_AUX_CTRL_SHARED_OVERRIDE |
>> -           L310_AUX_CTRL_DATA_PREFETCH |
>> -           L310_AUX_CTRL_INSTR_PREFETCH |
>> -           L2C_AUX_CTRL_WAY_SIZE(way_size);
>> -
>> -    l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
>> +    l2x0_of_init(L2C_AUX_CTRL_SHARED_OVERRIDE |
>> +             L310_AUX_CTRL_DATA_PREFETCH |
>> +             L310_AUX_CTRL_INSTR_PREFETCH, 0xc00f0fff);
>>   }
>>
>>   static void __init stih41x_machine_init(void)
>>
