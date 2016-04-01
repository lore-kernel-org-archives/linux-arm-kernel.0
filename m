From: gangchen@rdamicro.com (=?utf-8?B?6ZmI5YiaKEdhbmdjaGVuKQ==?=)
Date: Fri, 1 Apr 2016 11:35:13 +0000
Subject: [PATCH V4 1/1] ARM : missing corrupted reg in __div64_32
In-Reply-To: <20160401110315.GK3701@e103592.cambridge.arm.com>
References: <20160401085631.GJ3701@e103592.cambridge.arm.com>
 <BLU436-SMTP12207857FFB72680FD3D560999A0@phx.gbl>
 <20160401110315.GK3701@e103592.cambridge.arm.com>
Message-ID: <56FE5CF0.3020205@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/01/2016 07:03 PM, Dave Martin wrote:
> On Fri, Apr 01, 2016 at 06:28:49PM +0800, chengang wrote:
>> __xl(R0 in little endian system, or R1 in big endian system) is corrupted
>> by the call to  __do_div64i(). The  compiler is not aware of this, so if
> Should that be "__do_div64", not "__do_div64i"?
>
>> n is used afterwards __xl won't be reloaded and n will contain incorrect value.
>>
>> Mark 64bits variable __n as inputi/output to inform compiler both r0 and r1
> Typo: "inputi"
>
>> are changed by the funciton call.
>>
>> Signed-off-by: Chen Gang <gangchen@rdamicro.com>
>> Signed-off-by: Chen Gang <changeang.beijing@outlook.com>
>> ---
>>   arch/arm/include/asm/div64.h | 22 ++++++++--------------
>>   1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
>> index e1f0776..1153e6d 100644
>> --- a/arch/arm/include/asm/div64.h
>> +++ b/arch/arm/include/asm/div64.h
>> @@ -21,30 +21,24 @@
>>    * for arguments and results (beware).
>>    */
>>   
>> -#ifdef __ARMEB__
>> -#define __xh "r0"
>> -#define __xl "r1"
>> -#else
>> -#define __xl "r0"
>> -#define __xh "r1"
>> -#endif
>>   
>>   static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>>   {
>>   	register unsigned int __base      asm("r4") = base;
>>   	register unsigned long long __n   asm("r0") = *n;
>>   	register unsigned long long __res asm("r2");
>> -	register unsigned int __rem       asm(__xh);
>> -	asm(	__asmeq("%0", __xh)
>> +	asm(	__asmeq("%0", "r0")
>>   		__asmeq("%1", "r2")
>> -		__asmeq("%2", "r0")
>> -		__asmeq("%3", "r4")
>> +		__asmeq("%2", "r4")
>>   		"bl	__do_div64"
>> -		: "=r" (__rem), "=r" (__res)
>> -		: "r" (__n), "r" (__base)
>> +		: "+r" (__n), "=r" (__res)
>> +		: "r" (__base)
>>   		: "ip", "lr", "cc");
>>   	*n = __res;
>> -	return __rem;
>> +	/*
>> +	 * __do_div64 returns the remainder in the upper word of __n
>> +	 */
> Minor nit: ^ this is short enough to be a one-line comment
>
>> +	return __n >> 32;
>>   }
>>   #define __div64_32 __div64_32
> With those changes,
>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks a lot , especially for your patience! I just sent V5, cheers!
>
> Cheers
> ---Dave
