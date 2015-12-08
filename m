From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 9 Dec 2015 08:17:53 +0900
Subject: [PATCH v6 4/6] arm64: insn: add instruction decoders for ldp/stp
 and add/sub
In-Reply-To: <20151208181517.GF27393@arm.com>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-5-git-send-email-takahiro.akashi@linaro.org>
 <20151208181517.GF27393@arm.com>
Message-ID: <75E5C339-BD3C-4DD6-9563-49FFB108D96F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 9, 2015, at 3:15 AM, Will Deacon wrote:

Hi Will,

> On Wed, Nov 18, 2015 at 03:43:07PM +0900, AKASHI Takahiro wrote:
>> A function prologue analyzer is a requisite for implementing stack tracer
>> and getting better views of stack usages on arm64.
>> To implement a function prologue analyzer, we have to be able to decode,
>> at least, stp, add, sub and mov instructions.
>> 
>> This patch adds decoders for those instructions, that are used solely
>> by stack tracer for now, but generic enough for other uses.
>> 
>> Reviewed-by: Jungseok Lee <jungseoklee85@gmail.com>
>> Tested-by: Jungseok Lee <jungseoklee85@gmail.com>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>> arch/arm64/include/asm/insn.h |   18 ++++++++
>> arch/arm64/kernel/insn.c      |  102 +++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 120 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 30e50eb..8d5c538 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -165,6 +165,8 @@ enum aarch64_insn_ldst_type {
>> 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
>> 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
>> 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
>> +	AARCH64_INSN_LDST_LOAD_PAIR,
>> +	AARCH64_INSN_LDST_STORE_PAIR,
> 
> For consistency with the rest of this header, we should be calling these
> AARCH64_INSN_LDST_{LOAD,STORE}_PAIR_REG_OFFSET...
> 
>> };
>> 
>> enum aarch64_insn_adsb_type {
>> @@ -225,6 +227,8 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>> 
>> __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
>> __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
>> +__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
>> +__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
> 
> ... and using stp_reg/ldp_reg here.
> 
>> __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
>> __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
>> __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
>> @@ -277,6 +281,7 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
>> __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
>> __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
>> __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
>> +__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F00E0)
> 
> Is this encoding correct? I ended up with 0xd69f03e0.

You're right. This is updated in [PATCH v6 6/6]. Please refer to [1] for
more details.

[1] http://www.spinics.net/lists/arm-kernel/msg462856.html

Best Regards
Jungseok Lee
