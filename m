From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 10:14:08 -0700
Subject: [PATCH v3 26/32] arm64: KVM: 32bit handling of coprocessor traps
In-Reply-To: <5177E12C.8020909@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-27-git-send-email-marc.zyngier@arm.com>
 <20130423230159.GL20569@gmail.com> <5177E12C.8020909@arm.com>
Message-ID: <CAEDV+gJ5caireE_Nz11znqFpV1D3j02Ekt-9tJiN-ueXjhQOHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 6:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 24/04/13 00:01, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:28PM +0100, Marc Zyngier wrote:
>>> Provide the necessary infrastructure to trap coprocessor accesses that
>>> occur when running 32bit guests.
>>>
>>> Also wire SMC and HVC trapped in 32bit mode while were at it.
>>>
>>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_coproc.h |   5 +
>>>  arch/arm64/kvm/handle_exit.c        |   7 ++
>>>  arch/arm64/kvm/sys_regs.c           | 178 ++++++++++++++++++++++++++++++++++--
>>>  3 files changed, 183 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_coproc.h b/arch/arm64/include/asm/kvm_coproc.h
>>> index 9b4477a..9a59301 100644
>>> --- a/arch/arm64/include/asm/kvm_coproc.h
>>> +++ b/arch/arm64/include/asm/kvm_coproc.h
>>> @@ -32,11 +32,16 @@ struct kvm_sys_reg_table {
>>>
>>>  struct kvm_sys_reg_target_table {
>>>       struct kvm_sys_reg_table table64;
>>> +     struct kvm_sys_reg_table table32;
>>>  };
>>>
>>>  void kvm_register_target_sys_reg_table(unsigned int target,
>>>                                      struct kvm_sys_reg_target_table *table);
>>>
>>> +int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>> +int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>> +int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>> +int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>>  int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>>
>>>  #define kvm_coproc_table_init kvm_sys_reg_table_init
>>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>>> index 4766b7f..9beaca03 100644
>>> --- a/arch/arm64/kvm/handle_exit.c
>>> +++ b/arch/arm64/kvm/handle_exit.c
>>> @@ -62,6 +62,13 @@ static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>
>>>  static exit_handle_fn arm_exit_handlers[] = {
>>>       [ESR_EL2_EC_WFI]        = kvm_handle_wfi,
>>> +     [ESR_EL2_EC_CP15_32]    = kvm_handle_cp15_32,
>>> +     [ESR_EL2_EC_CP15_64]    = kvm_handle_cp15_64,
>>> +     [ESR_EL2_EC_CP14_MR]    = kvm_handle_cp14_access,
>>> +     [ESR_EL2_EC_CP14_LS]    = kvm_handle_cp14_load_store,
>>> +     [ESR_EL2_EC_CP14_64]    = kvm_handle_cp14_access,
>>> +     [ESR_EL2_EC_HVC32]      = handle_hvc,
>>> +     [ESR_EL2_EC_SMC32]      = handle_smc,
>>>       [ESR_EL2_EC_HVC64]      = handle_hvc,
>>>       [ESR_EL2_EC_SMC64]      = handle_smc,
>>>       [ESR_EL2_EC_SYS64]      = kvm_handle_sys_reg,
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index 9df3b32..0303218 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -38,6 +38,10 @@
>>>   * types are different. My gut feeling is that it should be pretty
>>>   * easy to merge, but that would be an ABI breakage -- again. VFP
>>>   * would also need to be abstracted.
>>> + *
>>> + * For AArch32, we only take care of what is being trapped. Anything
>>> + * that has to do with init and userspace access has to go via the
>>> + * 64bit interface.
>>>   */
>>>
>>>  /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>>> @@ -163,6 +167,16 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>>       { Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
>>>         access_dcsw },
>>>
>>> +     /* TEECR32_EL1 */
>>> +     { Op0(0b10), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
>>> +       NULL, reset_val, TEECR32_EL1, 0 },
>>> +     /* TEEHBR32_EL1 */
>>> +     { Op0(0b10), Op1(0b010), CRn(0b0001), CRm(0b0000), Op2(0b000),
>>> +       NULL, reset_val, TEEHBR32_EL1, 0 },
>>> +     /* DBGVCR32_EL2 */
>>> +     { Op0(0b10), Op1(0b100), CRn(0b0000), CRm(0b0111), Op2(0b000),
>>> +       NULL, reset_val, DBGVCR32_EL2, 0 },
>>> +
>>>       /* MPIDR_EL1 */
>>>       { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b101),
>>>         NULL, reset_mpidr, MPIDR_EL1 },
>>> @@ -273,6 +287,39 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>>       /* TPIDRRO_EL0 */
>>>       { Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
>>>         NULL, reset_unknown, TPIDRRO_EL0 },
>>> +
>>> +     /* DACR32_EL2 */
>>> +     { Op0(0b11), Op1(0b100), CRn(0b0011), CRm(0b0000), Op2(0b000),
>>> +       NULL, reset_unknown, DACR32_EL2 },
>>> +     /* IFSR32_EL2 */
>>> +     { Op0(0b11), Op1(0b100), CRn(0b0101), CRm(0b0000), Op2(0b001),
>>> +       NULL, reset_unknown, IFSR32_EL2 },
>>> +     /* FPEXC32_EL2 */
>>> +     { Op0(0b11), Op1(0b100), CRn(0b0101), CRm(0b0011), Op2(0b000),
>>> +       NULL, reset_val, FPEXC32_EL2, 0x70 },
>>> +};
>>> +
>>> +/* Trapped cp15 registers */
>>> +static const struct sys_reg_desc cp15_regs[] = {
>>> +     /*
>>> +      * DC{C,I,CI}SW operations:
>>> +      */
>>> +     { Op1( 0), CRn( 7), CRm( 6), Op2( 2), access_dcsw },
>>> +     { Op1( 0), CRn( 7), CRm(10), Op2( 2), access_dcsw },
>>> +     { Op1( 0), CRn( 7), CRm(14), Op2( 2), access_dcsw },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 0), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 1), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 2), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 3), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 5), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 6), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(12), Op2( 7), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(13), Op2( 0), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(13), Op2( 1), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(13), Op2( 2), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(14), Op2( 0), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(14), Op2( 1), pm_fake },
>>> +     { Op1( 0), CRn( 9), CRm(14), Op2( 2), pm_fake },
>>>  };
>>>
>>>  /* Target specific emulation tables */
>>> @@ -285,13 +332,20 @@ void kvm_register_target_sys_reg_table(unsigned int target,
>>>  }
>>>
>>>  /* Get specific register table for this target. */
>>> -static const struct sys_reg_desc *get_target_table(unsigned target, size_t *num)
>>> +static const struct sys_reg_desc *get_target_table(unsigned target,
>>> +                                                bool mode_is_64,
>>> +                                                size_t *num)
>>>  {
>>>       struct kvm_sys_reg_target_table *table;
>>>
>>>       table = target_tables[target];
>>> -     *num = table->table64.num;
>>> -     return table->table64.table;
>>> +     if (mode_is_64) {
>>> +             *num = table->table64.num;
>>> +             return table->table64.table;
>>> +     } else {
>>> +             *num = table->table32.num;
>>> +             return table->table32.table;
>>> +     }
>>>  }
>>>
>>>  static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
>>> @@ -319,13 +373,123 @@ static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
>>>       return NULL;
>>>  }
>>>
>>> +int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>> +{
>>> +     kvm_inject_undefined(vcpu);
>>> +     return 1;
>>> +}
>>> +
>>> +int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>> +{
>>> +     kvm_inject_undefined(vcpu);
>>> +     return 1;
>>> +}
>>> +
>>> +static int emulate_cp15(struct kvm_vcpu *vcpu,
>>> +                     const struct sys_reg_params *params)
>>> +{
>>> +     size_t num;
>>> +     const struct sys_reg_desc *table, *r;
>>> +
>>> +     table = get_target_table(vcpu->arch.target, false, &num);
>>> +
>>> +     /* Search target-specific then generic table. */
>>> +     r = find_reg(params, table, num);
>>> +     if (!r)
>>> +             r = find_reg(params, cp15_regs, ARRAY_SIZE(cp15_regs));
>>> +
>>> +     if (likely(r)) {
>>> +             /* If we don't have an accessor, we should never get here! */
>>> +             BUG_ON(!r->access);
>>
>> again not quite sure if this warrants a crash of the entire host.
>>
>>> +
>>> +             if (likely(r->access(vcpu, params, r))) {
>>> +                     /* Skip instruction, since it was emulated */
>>> +                     kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>>> +                     return 1;
>>> +             }
>>> +             /* If access function fails, it should complain. */
>>> +     } else {
>>> +             kvm_err("Unsupported guest CP15 access at: %08lx\n",
>>> +                     *vcpu_pc(vcpu));
>>> +             print_sys_reg_instr(params);
>>> +     }
>>> +     kvm_inject_undefined(vcpu);
>>> +     return 1;
>>> +}
>>> +
>>> +/**
>>> + * kvm_handle_cp15_64 -- handles a mrrc/mcrr trap on a guest CP15 access
>>> + * @vcpu: The VCPU pointer
>>> + * @run:  The kvm_run struct
>>> + */
>>> +int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>> +{
>>> +     struct sys_reg_params params;
>>> +     u32 hsr = kvm_vcpu_get_hsr(vcpu);
>>> +     int Rt2 = (hsr >> 10) & 0xf;
>>> +     int ret;
>>> +
>>> +     params.CRm = (hsr >> 1) & 0xf;
>>> +     params.Rt = (hsr >> 5) & 0xf;
>>> +     params.is_write = ((hsr & 1) == 0);
>>> +
>>> +     params.Op0 = 0;
>>> +     params.Op1 = (hsr >> 16) & 0xf;
>>> +     params.Op2 = 0;
>>> +     params.CRn = 0;
>>> +
>>> +     /*
>>> +      * Massive hack here. Store Rt2 in the top 32bits so we only
>>> +      * have one register to deal with. As we use the same trap
>>> +      * backends between AArch32 and AArch64, we get away with it.
>>> +      */
>>> +     if (params.is_write) {
>>> +             u64 val = *vcpu_reg(vcpu, params.Rt);
>>> +             val &= 0xffffffff;
>>> +             val |= *vcpu_reg(vcpu, Rt2) << 32;
>>> +             *vcpu_reg(vcpu, params.Rt) = val;
>>> +     }
>>> +
>>> +     ret = emulate_cp15(vcpu, &params);
>>> +
>>> +     /* Reverse hack here */
>>
>> nit: consider changing the wording to something like 'Similar hack for
>> reads here', so readers don't think you are trying to reverse the hack
>> you did above.
>
> Sure.
>
>>> +     if (ret && !params.is_write) {
>>> +             u64 val = *vcpu_reg(vcpu, params.Rt);
>>> +             val >>= 32;
>>> +             *vcpu_reg(vcpu, Rt2) = val;
>>
>> actually the emulate_cp15 should probably be turned into a void and the
>> ret check could go away, same thing on the 32-bit side.
>
> Well, if we don't BUG_ON() in emulate_cp15, then we do want to return
> something that meaningfully shown that we failed to handle the trap.
>
yeah, but then we should also change the check to be 'if (ret >= 0 &&
...)' since 0 wouldn't be an error, or change emulate_cp15 to return a
bool or the conventional 0 or error code here... So something should
change is all I'm trying to say.
