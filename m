From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 13:25:39 -0500
Subject: [PATCH v5 13/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <20130114164326.GH23505@n2100.arm.linux.org.uk>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108184005.46302.38495.stgit@ubuntu>
 <20130114164326.GH23505@n2100.arm.linux.org.uk>
Message-ID: <CANM98qKASA_YML6L0KDHNsPShA+rfE2E=XXznqG4+dNn+939kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:43 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 08, 2013 at 01:40:05PM -0500, Christoffer Dall wrote:
>> diff --git a/arch/arm/kvm/decode.c b/arch/arm/kvm/decode.c
>> new file mode 100644
>> index 0000000..469cf14
>> --- /dev/null
>> +++ b/arch/arm/kvm/decode.c
>> @@ -0,0 +1,462 @@
>> +/*
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>> + */
>> +#include <linux/kvm_host.h>
>> +#include <asm/kvm_mmio.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_decode.h>
>> +#include <trace/events/kvm.h>
>> +
>> +#include "trace.h"
>> +
>> +struct arm_instr {
>> +     /* Instruction decoding */
>> +     u32 opc;
>> +     u32 opc_mask;
>> +
>> +     /* Decoding for the register write back */
>> +     bool register_form;
>> +     u32 imm;
>> +     u8 Rm;
>> +     u8 type;
>> +     u8 shift_n;
>> +
>> +     /* Common decoding */
>> +     u8 len;
>> +     bool sign_extend;
>> +     bool w;
>> +
>> +     bool (*decode)(struct kvm_decode *decode, struct kvm_exit_mmio *mmio,
>> +                    unsigned long instr, struct arm_instr *ai);
>> +};
>> +
>> +enum SRType {
>> +     SRType_LSL,
>> +     SRType_LSR,
>> +     SRType_ASR,
>> +     SRType_ROR,
>> +     SRType_RRX
>> +};
>> +
>> +/* Modelled after DecodeImmShift() in the ARM ARM */
>> +static enum SRType decode_imm_shift(u8 type, u8 imm5, u8 *amount)
>> +{
>> +     switch (type) {
>> +     case 0x0:
>> +             *amount = imm5;
>> +             return SRType_LSL;
>> +     case 0x1:
>> +             *amount = (imm5 == 0) ? 32 : imm5;
>> +             return SRType_LSR;
>> +     case 0x2:
>> +             *amount = (imm5 == 0) ? 32 : imm5;
>> +             return SRType_ASR;
>> +     case 0x3:
>> +             if (imm5 == 0) {
>> +                     *amount = 1;
>> +                     return SRType_RRX;
>> +             } else {
>> +                     *amount = imm5;
>> +                     return SRType_ROR;
>> +             }
>> +     }
>> +
>> +     return SRType_LSL;
>> +}
>> +
>> +/* Modelled after Shift() in the ARM ARM */
>> +static u32 shift(u32 value, u8 N, enum SRType type, u8 amount, bool carry_in)
>> +{
>> +     u32 mask = (1 << N) - 1;
>> +     s32 svalue = (s32)value;
>> +
>> +     BUG_ON(N > 32);
>> +     BUG_ON(type == SRType_RRX && amount != 1);
>> +     BUG_ON(amount > N);
>> +
>> +     if (amount == 0)
>> +             return value;
>> +
>> +     switch (type) {
>> +     case SRType_LSL:
>> +             value <<= amount;
>> +             break;
>> +     case SRType_LSR:
>> +              value >>= amount;
>> +             break;
>> +     case SRType_ASR:
>> +             if (value & (1 << (N - 1)))
>> +                     svalue |= ((-1UL) << N);
>> +             value = svalue >> amount;
>> +             break;
>> +     case SRType_ROR:
>> +             value = (value >> amount) | (value << (N - amount));
>> +             break;
>> +     case SRType_RRX: {
>> +             u32 C = (carry_in) ? 1 : 0;
>> +             value = (value >> 1) | (C << (N - 1));
>> +             break;
>> +     }
>> +     }
>> +
>> +     return value & mask;
>> +}
>> +
>> +static bool decode_arm_wb(struct kvm_decode *decode, struct kvm_exit_mmio *mmio,
>> +                       unsigned long instr, const struct arm_instr *ai)
>> +{
>> +     u8 Rt = (instr >> 12) & 0xf;
>> +     u8 Rn = (instr >> 16) & 0xf;
>> +     u8 W = (instr >> 21) & 1;
>> +     u8 U = (instr >> 23) & 1;
>> +     u8 P = (instr >> 24) & 1;
>> +     u32 base_addr = *kvm_decode_reg(decode, Rn);
>> +     u32 offset_addr, offset;
>> +
>> +     /*
>> +      * Technically this is allowed in certain circumstances,
>> +      * but we don't support it.
>> +      */
>> +     if (Rt == 15 || Rn == 15)
>> +             return false;
>> +
>> +     if (P && !W) {
>> +             kvm_err("Decoding operation with valid ISV?\n");
>> +             return false;
>> +     }
>> +
>> +     decode->rt = Rt;
>> +
>> +     if (ai->register_form) {
>> +             /* Register operation */
>> +             enum SRType s_type;
>> +             u8 shift_n = 0;
>> +             bool c_bit = *kvm_decode_cpsr(decode) & PSR_C_BIT;
>> +             u32 s_reg = *kvm_decode_reg(decode, ai->Rm);
>> +
>> +             s_type = decode_imm_shift(ai->type, ai->shift_n, &shift_n);
>> +             offset = shift(s_reg, 5, s_type, shift_n, c_bit);
>> +     } else {
>> +             /* Immediate operation */
>> +             offset = ai->imm;
>> +     }
>> +
>> +     /* Handle Writeback */
>> +     if (U)
>> +             offset_addr = base_addr + offset;
>> +     else
>> +             offset_addr = base_addr - offset;
>> +     *kvm_decode_reg(decode, Rn) = offset_addr;
>> +     return true;
>> +}
>> +
>> +static bool decode_arm_ls(struct kvm_decode *decode, struct kvm_exit_mmio *mmio,
>> +                       unsigned long instr, struct arm_instr *ai)
>> +{
>> +     u8 A = (instr >> 25) & 1;
>> +
>> +     mmio->is_write = ai->w;
>> +     mmio->len = ai->len;
>> +     decode->sign_extend = false;
>> +
>> +     ai->register_form = A;
>> +     ai->imm = instr & 0xfff;
>> +     ai->Rm = instr & 0xf;
>> +     ai->type = (instr >> 5) & 0x3;
>> +     ai->shift_n = (instr >> 7) & 0x1f;
>> +
>> +     return decode_arm_wb(decode, mmio, instr, ai);
>> +}
>> +
>> +static bool decode_arm_extra(struct kvm_decode *decode,
>> +                          struct kvm_exit_mmio *mmio,
>> +                          unsigned long instr, struct arm_instr *ai)
>> +{
>> +     mmio->is_write = ai->w;
>> +     mmio->len = ai->len;
>> +     decode->sign_extend = ai->sign_extend;
>> +
>> +     ai->register_form = !((instr >> 22) & 1);
>> +     ai->imm = ((instr >> 4) & 0xf0) | (instr & 0xf);
>> +     ai->Rm = instr & 0xf;
>> +     ai->type = 0; /* SRType_LSL */
>> +     ai->shift_n = 0;
>> +
>> +     return decode_arm_wb(decode, mmio, instr, ai);
>> +}
>> +
>> +/*
>> + * The encodings in this table assumes that a fault was generated where the
>> + * ISV field in the HSR was clear, and the decoding information was invalid,
>> + * which means that a register write-back occurred, the PC was used as the
>> + * destination or a load/store multiple operation was used. Since the latter
>> + * two cases are crazy for MMIO on the guest side, we simply inject a fault
>> + * when this happens and support the common case.
>> + *
>> + * We treat unpriviledged loads and stores of words and bytes like all other
>> + * loads and stores as their encodings mandate the W bit set and the P bit
>> + * clear.
>> + */
>> +static const struct arm_instr arm_instr[] = {
>> +     /**************** Load/Store Word and Byte **********************/
>> +     /* Store word with writeback */
>> +     { .opc = 0x04000000, .opc_mask = 0x0c500000, .len = 4, .w = true,
>> +             .sign_extend = false, .decode = decode_arm_ls },
>> +     /* Store byte with writeback */
>> +     { .opc = 0x04400000, .opc_mask = 0x0c500000, .len = 1, .w = true,
>> +             .sign_extend = false, .decode = decode_arm_ls },
>> +     /* Load word with writeback */
>> +     { .opc = 0x04100000, .opc_mask = 0x0c500000, .len = 4, .w = false,
>> +             .sign_extend = false, .decode = decode_arm_ls },
>> +     /* Load byte with writeback */
>> +     { .opc = 0x04500000, .opc_mask = 0x0c500000, .len = 1, .w = false,
>> +             .sign_extend = false, .decode = decode_arm_ls },
>> +
>> +     /*************** Extra load/store instructions ******************/
>> +
>> +     /* Store halfword with writeback */
>> +     { .opc = 0x000000b0, .opc_mask = 0x0c1000f0, .len = 2, .w = true,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +     /* Load halfword with writeback */
>> +     { .opc = 0x001000b0, .opc_mask = 0x0c1000f0, .len = 2, .w = false,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +
>> +     /* Load dual with writeback */
>> +     { .opc = 0x000000d0, .opc_mask = 0x0c1000f0, .len = 8, .w = false,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +     /* Load signed byte with writeback */
>> +     { .opc = 0x001000d0, .opc_mask = 0x0c1000f0, .len = 1, .w = false,
>> +             .sign_extend = true,  .decode = decode_arm_extra },
>> +
>> +     /* Store dual with writeback */
>> +     { .opc = 0x000000f0, .opc_mask = 0x0c1000f0, .len = 8, .w = true,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +     /* Load signed halfword with writeback */
>> +     { .opc = 0x001000f0, .opc_mask = 0x0c1000f0, .len = 2, .w = false,
>> +             .sign_extend = true,  .decode = decode_arm_extra },
>> +
>> +     /* Store halfword unprivileged */
>> +     { .opc = 0x002000b0, .opc_mask = 0x0f3000f0, .len = 2, .w = true,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +     /* Load halfword unprivileged */
>> +     { .opc = 0x003000b0, .opc_mask = 0x0f3000f0, .len = 2, .w = false,
>> +             .sign_extend = false, .decode = decode_arm_extra },
>> +     /* Load signed byte unprivileged */
>> +     { .opc = 0x003000d0, .opc_mask = 0x0f3000f0, .len = 1, .w = false,
>> +             .sign_extend = true , .decode = decode_arm_extra },
>> +     /* Load signed halfword unprivileged */
>> +     { .opc = 0x003000d0, .opc_mask = 0x0f3000f0, .len = 2, .w = false,
>> +             .sign_extend = true , .decode = decode_arm_extra },
>
> So here, yet again, we end up with more code decoding the ARM load/store
> instructions so that we can do something with them.  How many places do
> we now have in the ARM kernel doing this exact same thing?  Do we really
> need to keep rewriting this functionality each time a feature that needs
> it gets implemented, or is _someone_ going to sort this out once and for
> all?


Hi Russell,

This was indeed discussed a couple of time already, and I hear your concern.

However, unifying all instruction decoding within arch/arm is quite
the heavy task, and requires agreeing on some canonical API that
people can live with and it will likely take a long time.  I seem to
recall there were also arguments against unifying kprobe code with
other instruction decoding, as the kprobe code was also written to
work highly optimized under certain assumptions, if I understood
previous comments correctly.

Therefore I tried writing the decoding up in a way, which was not too
KVM specific, but without adding a lot of code paths to decode
instructions that were never going to be decoded by KVM and thus
trying to avoid having untested code in the kernel.

I really hope that this will not hold up the KVM patches right now, as
unifying the decoding would not break any external APIs when doing it
later.  Maintaining these patches out-of-tree is placing an
increasingly large burden on both me and Marc Zyngier especially, and
more and more people are requesting the KVM functionality.

That being said, I do like the though of having a complete solution
for instruction decoding in the kernel, and if I in any way can find
time down the road, I'd be happy taking part in writing this code,
especially if I receive help from people knowing the other potential
subsystems benefiting from such code.

So, I would go as far as to beg you to accept this code as part of the
KVM/ARM implementation with the promise that I *will* help out or take
charge later on in a unifying effort if in any way possible for me?

Best,
-Christoffer
