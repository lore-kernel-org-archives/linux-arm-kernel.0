From: dave.long@linaro.org (David Long)
Date: Fri, 16 Jan 2015 16:34:04 -0500
Subject: [PATCH v4 4/6] arm64: Kprobes instruction simulation support
In-Reply-To: <CAHM4w1n6wCUSX1QjP8EyA9zkJBZTM=6Vc32Vjm3wPuDv=FXZzw@mail.gmail.com>
References: <1420949002-3726-1-git-send-email-dave.long@linaro.org>	<1420949002-3726-5-git-send-email-dave.long@linaro.org>
 <CAHM4w1n6wCUSX1QjP8EyA9zkJBZTM=6Vc32Vjm3wPuDv=FXZzw@mail.gmail.com>
Message-ID: <54B983CC.6090507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/15 04:32, Pratyush Anand wrote:
> On Sun, Jan 11, 2015 at 9:33 AM, David Long <dave.long@linaro.org> wrote:
>> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>>
>> Add support for AArch64 instruction simulation in kprobes.
>>
>> Kprobes needs simulation of instructions that cannot be stepped
>> from different memory location, e.g.: those instructions
>> that uses PC-relative addressing. In simulation, the behaviour
>> of the instruction is implemented using a copy of pt_regs.
>>
>> Following instruction catagories are simulated:
>>   - All branching instructions(conditional, register, and immediate)
>>   - Literal access instructions(load-literal, adr/adrp)
>>
>> Conditional execution is limited to branching instructions in
>> ARM v8. If conditions at PSTATE do not match the condition fields
>> of opcode, the instruction is effectively NOP. Kprobes considers
>> this case as 'miss'.
>> changes since v3:
>> from David A. Long:
>> 1) Fix incorrect simulate_ldrsw_literal() semantics.
>> 2) Use instruction test functions instead of private parse table.
>> from Will Cohen:
>> 3) Remove PC adjustments when simulating an instruction.
>> 4) Fix displacement calculations.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>
> [...]
>
>>   static bool aarch64_insn_is_steppable(u32 insn)
>>   {
>> @@ -60,6 +130,32 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>>           */
>>          if (aarch64_insn_is_steppable(insn))
>>                  return INSN_GOOD;
>> +
>> +       asi->prepare = prepare_none;
>> +
>> +       if (aarch64_insn_is_bcond(insn)) {
>> +               asi->prepare = prepare_bcond;
>> +               asi->handler = simulate_b_cond;
>> +       } else if (aarch64_insn_is_cb(insn)) {
>> +               asi->prepare = prepare_cbz_cbnz;
>> +               asi->handler = simulate_cbz_cbnz;
>> +       } else if (aarch64_insn_is_tb(insn)) {
>> +               asi->prepare = prepare_tbz_tbnz;
>> +               asi->handler = simulate_tbz_tbnz;
>> +       } else if (aarch64_insn_is_adr(insn))
>
> aarch64_insn_is_adr should be modified to aarch64_insn_is_adr_adrp

Yes.

>> +               asi->handler = simulate_adr_adrp;
>> +       else if (aarch64_insn_is_b_bl(insn))
>> +               asi->handler = simulate_b_bl;
>> +       else if (aarch64_insn_is_ldr_lit(insn))
>> +               asi->handler = simulate_ldr_literal;
>> +       else if (aarch64_insn_is_ldrsw_lit(insn))
>> +               asi->handler = simulate_ldrsw_literal;
>
> also
>
> else if (aarch64_insn_is_br_blr(insn) || aarch64_insn_is_ret(insn))
>                 asi->handler = simulate_br_blr_ret;

Yes.

>
> ~Pratyush
>

-dl
