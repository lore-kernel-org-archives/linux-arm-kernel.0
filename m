From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Dec 2016 10:58:01 +0000
Subject: [PATCH 2/2] arm64: alternatives: Work around NOP generation with
 broken assembler
In-Reply-To: <20161205100545.GA14058@arm.com>
References: <20161203140538.23525-1-marc.zyngier@arm.com>
 <20161203140538.23525-3-marc.zyngier@arm.com>
 <20161205100545.GA14058@arm.com>
Message-ID: <c7de1968-7d50-a435-56ea-a7f3e9cb52da@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/16 10:05, Will Deacon wrote:
> On Sat, Dec 03, 2016 at 02:05:38PM +0000, Marc Zyngier wrote:
>> When compiling a .inst directive in an alternative clause with
>> a rather old version of gas (circa 2.24), and when used with
>> the alternative_else_nop_endif feature, the compilation fails
>> with a rather cryptic message such as:
>>
>> arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression
>>
>> which is caused by the bug described in eb7c11ee3c5c ("arm64:
>> alternative: Work around .inst assembler bugs").
>>
>> This effectively prevents the use of the "nops" macro, which
>> requires the number of instruction as a parameter (the assembler
>> is confused and unable to compute the difference between two labels).
>>
>> As an alternative(!), use the .fill directive to output the number
>> of required NOPs (.fill has the good idea to output the fill pattern
>> in the endianness of the instruction stream).
> 
> Are you sure about that? The gas docs say:
> 
> `The contents of each repeat bytes is taken from an 8-byte number. The
>  highest order 4 bytes are zero. The lowest order 4 bytes are value rendered
>  in the byte-order of an integer on the computer as is assembling for.'
> 
> and I'd expect "integer" to refer to data values, rather than instructions.

My tests on 2.24 and 2.25 seem to show that the output is always LE,
which could be another GAS issue. I've asked the binutils people for
information.

> 
>>
>> Fixes: 792d47379f4d ("arm64: alternative: add auto-nop infrastructure")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/alternative.h | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
>> index 39feb85..39f8c98 100644
>> --- a/arch/arm64/include/asm/alternative.h
>> +++ b/arch/arm64/include/asm/alternative.h
>> @@ -159,9 +159,19 @@ void apply_alternatives(void *start, size_t length);
>>   * of NOPs. The number of NOPs is chosen automatically to match the
>>   * previous case.
>>   */
>> +
>> +#define NOP_INST	0xd503201f
> 
> If we define this, let's put it in insn.h or something. It could even be
> used in the vdso linker script, which open codes this constant.

Sure.

> 
>> +
>>  .macro alternative_else_nop_endif
>>  alternative_else
>> -	nops	(662b-661b) / AARCH64_INSN_SIZE
>> +	/*
>> +	 * The same assembler bug strikes again here if the first half
>> +	 * of the alternative sequence contains a .inst, leading to a
>> +	 * bizarre error message. Fortulately, .fill replaces the
> 
> Fortunately
> 
>> +	 * "nops" macro by inserting padding with the target machine
>> +	 * endianness.
>> +	 */
>> +	.fill	(662b-661b) / AARCH64_INSN_SIZE, AARCH64_INSN_SIZE, NOP_INST
> 
> Assuming we can get .fill to do the right thing, we should probably use
> it in __nops rather than open-coding it here. Or is the issue that we're
> unable to pass (662b-661b) / AARCH64_INSN_SIZE to any macro?

Having an intermediate macro seems to work (probably because this is not
actually evaluated until it reaches .fill). I'll update the patch if I
get confirmation of the validity of the workaround from the binutils people.

Otherwise, we'll have to find another alternative, and maybe go back to
not using the auto-nop for SET_PSTATE_PAN/UAO.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
