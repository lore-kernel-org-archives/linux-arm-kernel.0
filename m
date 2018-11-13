From: elder@linaro.org (Alex Elder)
Date: Tue, 13 Nov 2018 10:58:02 -0600
Subject: [RFC PATCH 04/12] soc: qcom: ipa: immediate commands
In-Reply-To: <CAK8P3a3iKshE3yCG477AeZbKbLtpDwMhn5mfLySFRLOLmUv5AQ@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-5-elder@linaro.org>
 <CAK8P3a3iKshE3yCG477AeZbKbLtpDwMhn5mfLySFRLOLmUv5AQ@mail.gmail.com>
Message-ID: <dbaf1c86-ab9d-fa90-6718-998f1f1b6dd3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 8:36 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> +/**
>> + * struct ipahal_context - HAL global context data
>> + * @empty_fltrt_tbl:   Empty table to be used for table initialization
>> + */
>> +static struct ipahal_context {
>> +       struct ipa_dma_mem empty_fltrt_tbl;
>> +} ipahal_ctx_struct;
>> +static struct ipahal_context *ipahal_ctx = &ipahal_ctx_struct;
> 
> Remove the global variables here

Not done yet, but I will do this.  I've been working on eliminating
the top-level "ipa_ctx" global (which is *very* pervasive) and in
the process I'm eliminating all the others as well.  I'll get to
this soon.

>> +/* Immediate commands H/W structures */
>> +
>> +/* struct ipa_imm_cmd_hw_ip_fltrt_init - IP_V*_FILTER_INIT/IP_V*_ROUTING_INIT
>> + * command payload in H/W format.
>> + * Inits IPv4/v6 routing or filter block.
>> + * @hash_rules_addr: Addr in system mem where hashable flt/rt rules starts
>> + * @hash_rules_size: Size in bytes of the hashable tbl to cpy to local mem
>> + * @hash_local_addr: Addr in shared mem where hashable flt/rt tbl should
>> + *  be copied to
>> + * @nhash_rules_size: Size in bytes of the non-hashable tbl to cpy to local mem
>> + * @nhash_local_addr: Addr in shared mem where non-hashable flt/rt tbl should
>> + *  be copied to
>> + * @rsvd: reserved
>> + * @nhash_rules_addr: Addr in sys mem where non-hashable flt/rt tbl starts
>> + */
>> +struct ipa_imm_cmd_hw_ip_fltrt_init {
>> +       u64 hash_rules_addr;
>> +       u64 hash_rules_size     : 12,
>> +           hash_local_addr     : 16,
>> +           nhash_rules_size    : 12,
>> +           nhash_local_addr    : 16,
>> +           rsvd                : 8;
>> +       u64 nhash_rules_addr;
>> +};
> 
> In hardware structures, you should not use bit fields, as the ordering
> of the bits is not well-defined in C. The only portable way to do this
> is to use shifts and masks unfortunately.

This is something I held off fixing because I have seen other use
of bit fields in the kernel.  I wasn't sure whether my instinct about
it (which matches what you say) was wrong, and didn't want to do the
work to change things over to masks without knowing.  Based on your
suggestion, I will proceed with this conversion.

>> +struct ipa_imm_cmd_hw_hdr_init_local {
>> +       u64 hdr_table_addr;
>> +       u32 size_hdr_table      : 12,
>> +           hdr_addr            : 16,
>> +           rsvd                : 4;
>> +};
> 
> I would also add a 'u32 pad' member at the end to make the padding
> explicit here, or mark the first member as '__aligned(4) __packed'
> if you want to avoid the padding.

Yes, this is a good suggestion, and I will implement it.

You're right that the actual size of this structure includes the
extra 4 byte pad.  But I'm not actually sure whether the hardware
touches it because the size of immediate commands is implied by
the opcode.  To be safe, I'll make the pad explicit; but if I
learn it's not needed I'll define it to be packed.

>> +void *ipahal_dma_shared_mem_write_pyld(struct ipa_dma_mem *mem, u32 offset)
>> +{
>> +       struct ipa_imm_cmd_hw_dma_shared_mem *data;
>> +
>> +       ipa_assert(mem->size < 1 << 16);        /* size is 16 bits wide */
>> +       ipa_assert(offset < 1 << 16);           /* local_addr is 16 bits wide */
>> +
>> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return NULL;
>> +
>> +       data->size = mem->size;
>> +       data->local_addr = offset;
>> +       data->direction = 0;    /* 0 = write to IPA; 1 = read from IPA */
>> +       data->skip_pipeline_clear = 0;
>> +       data->pipeline_clear_options = IPAHAL_HPS_CLEAR;
>> +       data->system_addr = mem->phys;
>> +
>> +       return data;
>> +}
> 
> The 'void *' return looks odd here, and also the dynamic allocation.

It was done because it allows the definition of the data structure
to be hidden within this file.

> It looks to me like all these functions could be better done the
> other way round, basically putting the
> ipa_imm_cmd_hw_dma_shared_mem etc structures on the stack
> of the caller. At least for this one, the dynamic allocation
> doesn't help at all because the caller is the same that
> frees it again after the command. I suspect the same is
> true for a lot of those commands.

Yes, I see what you're saying.  In fact, now that I look, all of
these payload allocating functions except for one are used just
the way you describe (freed in the same function that uses it).
And the one is saved with the intention of avoiding an allocation
failure...  But I'll mention that this code was structured very
differently originally.

So I agree, putting them on the stack (given they're relatively
small--most 16 bytes one 24 bytes) is better.  And it seems I
can reduce some complexity by getting rid of that preallocated
command, which is a great outcome.

If I run into trouble implementing any of the above suggestions
I will circle back and explain.

Thanks a lot.

					-Alex

> 
>        Arnd
> 
