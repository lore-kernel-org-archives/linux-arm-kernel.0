From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 24 Jul 2013 00:31:36 -0700
Subject: updates for be8 patch series
In-Reply-To: <51EECBBD.20000@codethink.co.uk>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
 <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
 <CAA3XUr1BJD-ypfJiEsp079qHDERjGp-xFxc_ke_Ep9z3N=UPaA@mail.gmail.com>
 <51EECBBD.20000@codethink.co.uk>
Message-ID: <CAA3XUr1zHQbh+baVzQfgEebqYsEzUVp6wGOMe2PE6PUamAnbbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Please see inline

On 23 July 2013 11:30, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 23/07/13 19:03, Victor Kamensky wrote:
>>
>> Hi Ben,
>>
>> Sorry for multiple post. I am new to this, and I could not get mailing
>> list to accept my original email.
>> For sake of others so people can see discussed patch, here it goes
>> again with patch file inlined
>> now. Hope it will this time
>>
>> Wrt BE8 little endian instructions you will need to fix couple more
>> places:
>>      ftrace arch/arm/kernel/ftrace.c
>>      kprobes arch/arm/kernel/kprobes.c
>> Also in big endian mode atomic64_xxx function will need fixes, otherwise
>> perf
>> counters will be truncated on max of 32bit values
>>      atomic64 arch/arm/include/asm/atomic.h
>>
>> I've attached board independent (core) patch from my work that made
>> Pandaboard ES
>> kernel run in BE mode. You can check my version of fixes for above issues
>> in the
>> patch. Look for corresponding files changes. Please rework them
>> according to style
>> and rules of your patch series. Note the patch itself contains fixes
>> for few other
>> issues that already fixed in your series. I'll cross check and compare
>> individual
>> areas latter. I think you may find attached patch interesting as well,
>> it was developed
>> independent from yours but matches its very well.
>>
>> Wrt of testing: ftrace was tested on Pandaboard ES, krprobes changes were
>> tested
>> with SystemTap at some point of patch version on Pandaboard ES (not
>> thumb mode though),
>> also it may deteriorated while ported across different kernel version,
>> good idea to
>> rested last patch. atomic64 were tested on Pandaboard ES and Marvell
>> Armada XP.
>>
>> Thanks,
>> Victor
>
>
> First notes, please always format your emails (where possible) to
> under 80 characters per line so that they do not get mangled when
> viewed on limited screens (for example, I often read email via a
> 24x80 terminal)

Yes, I understand. Sorry about this. Please bear with me a bit. I am new to
Linaro .. just my second week started. Still learning tools used here, and
still struggling with default email client.

> Second note, when producing patches, it is better to try and split
> them into a series of patches to reach a goal than just one large
> patch. It keeps a lot of useful information (see patch comments)
> and it means that if there is a problem, then bits can be lifted
> out to check.

Yes, I understand. Indeed multiple patches is best from. But I did not really
mean try to contribute these patches, but rather throw patch over the wall for
reference.

I believe largely your series covers the same things, in more accurate way,
and should be continued. I plan to review your series and will try to
integrate it and run on Pandaboard ES. Note for this testing I would use big
patch of TI OMAP4 drivers to be endian neutral. It will take me several days.
If I find anything I will let you know accross these days.

Note my original experiment was done against TI 3.1 kernel and after that
was carried forward without great care, so it may explain few descrepencies
below and my blunder with ftrace comment.

>
>
>> Index: linux-linaro-tracking/arch/arm/Makefile
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/Makefile
>> +++ linux-linaro-tracking/arch/arm/Makefile
>> @@ -16,6 +16,7 @@ LDFLAGS        :=
>>   LDFLAGS_vmlinux    :=-p --no-undefined -X
>>   ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>>   LDFLAGS_vmlinux    += --be8
>> +KBUILD_LDFLAGS_MODULE += --be8
>>   endif
>>
>>   OBJCOPYFLAGS    :=-O binary -R .comment -S
>> @@ -43,12 +44,19 @@ ifeq ($(CONFIG_CC_STACKPROTECTOR),y)
>>   KBUILD_CFLAGS    +=-fstack-protector
>>   endif
>>
>> +# Passing endian compilation flag in both CPPFLAGS ad CFLAGS. There are
>> +# places where CFLAGS alone are used (cmd_record_mcount). And it has to
>> +# be in CPPFLAGS because it affects what macros (__ARMEB__,
>> __BYTE_ORDER__,
>> +# __FLOAT_WORD_ORDER__) are defined. So replication of flag seems to be
>> +# good compromise
>>   ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
>>   KBUILD_CPPFLAGS    += -mbig-endian
>> +KBUILD_CFLAGS    += -mbig-endian
>>   AS        += -EB
>>   LD        += -EB
>>   else
>>   KBUILD_CPPFLAGS    += -mlittle-endian
>> +KBUILD_CFLAGS    += -mlittle-endian
>>   AS        += -EL
>>   LD        += -EL
>>   endif
>
>
> See the comment below.
>
>
>> Index: linux-linaro-tracking/arch/arm/boot/compressed/Makefile
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/boot/compressed/Makefile
>> +++ linux-linaro-tracking/arch/arm/boot/compressed/Makefile
>> @@ -138,6 +138,24 @@ endif
>>   ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>>   LDFLAGS_vmlinux += --be8
>>   endif
>> +
>> +# Passing endian compilation flag in both CPPFLAGS ad CFLAGS. There are
>> +# places where CFLAGS alone are used (cmd_record_mcount). And it has to
>> +# be in CPPFLAGS because it affects what macros (__ARMEB__,
>> __BYTE_ORDER__,
>> +# __FLOAT_WORD_ORDER__) are defined. So replication of flag seems to be
>> +# good compromise
>> +ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
>> +KBUILD_CPPFLAGS    += -mbig-endian
>> +KBUILD_CFLAGS    += -mbig-endian
>> +AS        += -EB
>> +LD        += -EB
>> +else
>> +KBUILD_CPPFLAGS    += -mlittle-endian
>> +KBUILD_CFLAGS    += -mlittle-endian
>> +AS        += -EL
>> +LD        += -EL
>> +endif
>> +
>>   # ?
>>   LDFLAGS_vmlinux += -p
>>   # Report unresolved symbol references
>
>
> I've not been bitten by this one. Is there anyone else who can comment
> on KBUILD_CFLAGS vs KBUILD_CPPFLAGS?
>
> I had assumed that arch/arm/boot/compressed/Makefile would have
> inherited the flags from the arch/arm/Makefile. Someone else would
> be better qualified to comment on this.

Let's ignore this. I don't think it is relevant now. There was probably some
odd situation in old kernel.

>
>> Index: linux-linaro-tracking/arch/arm/boot/compressed/head.S
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/boot/compressed/head.S
>> +++ linux-linaro-tracking/arch/arm/boot/compressed/head.S
>> @@ -141,6 +141,12 @@ start:
>>   #endif
>>           mov    r7, r1            @ save architecture ID
>>           mov    r8, r2            @ save atags pointer
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +                /*
>> +                 * Switch to bigendian mode
>> +                 */
>> +                setend  be
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>>
>>   #ifndef __ARM_ARCH_2__
>>           /*
>> Index: linux-linaro-tracking/arch/arm/include/asm/setup.h
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/include/asm/setup.h
>> +++ linux-linaro-tracking/arch/arm/include/asm/setup.h
>> @@ -53,4 +53,8 @@ extern int arm_add_memory(phys_addr_t st
>>   extern void early_print(const char *str, ...);
>>   extern void dump_machine_table(void);
>>
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +void byteswap_tags(struct tag *t);
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>> +
>>   #endif
>
>
> You could have done
>
> #ifdef CONFIG_LITTLE_ENDIAN_LOADER
> void byteswap_tags(struct tag *t);
> #else
> static inline void byteswap_tags(struct tag *t) { }
> #endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/Makefile
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/Makefile
>> +++ linux-linaro-tracking/arch/arm/kernel/Makefile
>> @@ -22,6 +22,7 @@ obj-y        := elf.o entry-armv.o entry-commo
>>   obj-$(CONFIG_ATAGS)        += atags_parse.o
>>   obj-$(CONFIG_ATAGS_PROC)    += atags_proc.o
>>   obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
>> +obj-$(CONFIG_LITTLE_ENDIAN_LOADER) += atags_byteswap.o
>>
>>   obj-$(CONFIG_OC_ETM)        += etm.o
>>   obj-$(CONFIG_CPU_IDLE)        += cpuidle.o
>> Index: linux-linaro-tracking/arch/arm/kernel/atags_byteswap.c
>> ===================================================================
>> --- /dev/null
>> +++ linux-linaro-tracking/arch/arm/kernel/atags_byteswap.c
>> @@ -0,0 +1,119 @@
>> +#include<linux/slab.h>
>> +#include<linux/proc_fs.h>
>> +#include<linux/swab.h>
>> +#include<asm/setup.h>
>> +#include<asm/types.h>
>> +#include<asm/page.h>
>> +
>> +#define byteswap32(x) (x) = __swab32((x))
>> +#define byteswap16(x) (x) = __swab16((x))
>> +
>> +static void __init byteswap_tag_core(struct tag *tag)
>> +{
>> +  byteswap32(tag->u.core.flags);
>> +  byteswap32(tag->u.core.pagesize);
>> +  byteswap32(tag->u.core.rootdev);
>> +}
>> +
>> +static void __init byteswap_tag_mem32(struct tag *tag)
>> +{
>> +  byteswap32(tag->u.mem.size);
>> +  byteswap32(tag->u.mem.start);
>> +}
>> +
>> +static void __init byteswap_tag_videotext(struct tag *tag)
>> +{
>> +  byteswap16(tag->u.videotext.video_page);
>> +  byteswap16(tag->u.videotext.video_ega_bx);
>> +  byteswap16(tag->u.videotext.video_points);
>> +}
>> +
>> +static void __init byteswap_tag_ramdisk(struct tag *tag)
>> +{
>> +  byteswap32(tag->u.ramdisk.flags);
>> +  byteswap32(tag->u.ramdisk.size);
>> +  byteswap32(tag->u.ramdisk.start);
>> +}
>> +
>> +static void __init byteswap_tag_initrd(struct tag *tag)
>> +{
>> +  byteswap32(tag->u.initrd.start);
>> +  byteswap32(tag->u.initrd.size);
>> +}
>> +
>> +static void __init byteswap_tag_serialnr(struct tag *tag)
>> +{
>> +  byteswap32(tag->u.serialnr.low);
>> +  byteswap32(tag->u.serialnr.high);
>> +}
>> +
>> +static void __init byteswap_tag_revision(struct tag *tag)
>> +{
>> +    byteswap32(tag->u.revision.rev);
>> +}
>> +
>> +static void __init byteswap_tag_videolfb(struct tag *tag)
>> +{
>> +    byteswap16(tag->u.videolfb.lfb_width);
>> +    byteswap16(tag->u.videolfb.lfb_height);
>> +    byteswap16(tag->u.videolfb.lfb_depth);
>> +    byteswap16(tag->u.videolfb.lfb_linelength);
>> +    byteswap32(tag->u.videolfb.lfb_base);
>> +    byteswap32(tag->u.videolfb.lfb_size);
>> +}
>> +
>> +static void __init byteswap_tag_acorn(struct tag *tag)
>> +{
>> +    byteswap32(tag->u.acorn.memc_control_reg);
>> +    byteswap32(tag->u.acorn.vram_pages);
>> +}
>> +
>> +static void __init byteswap_tag_memclk(struct tag *tag)
>> +{
>> +    byteswap32(tag->u.memclk.fmemclk);
>> +}
>> +
>> +void __init byteswap_tags(struct tag *t)
>> +{
>> +  for (; t->hdr.size; t = tag_next(t)) {
>> +    byteswap32(t->hdr.size);
>> +    byteswap32(t->hdr.tag);
>> +    switch(t->hdr.tag) {
>> +    case ATAG_CORE:
>> +      byteswap_tag_core(t);
>> +      break;
>> +    case ATAG_MEM:
>> +      byteswap_tag_mem32(t);
>> +      break;
>> +    case ATAG_VIDEOTEXT:
>> +      byteswap_tag_videotext(t);
>> +      break;
>> +    case ATAG_RAMDISK:
>> +      byteswap_tag_ramdisk(t);
>> +      break;
>> +    case ATAG_INITRD2:
>> +      byteswap_tag_initrd(t);
>> +      break;
>> +    case ATAG_SERIAL:
>> +      byteswap_tag_serialnr(t);
>> +      break;
>> +    case ATAG_REVISION:
>> +      byteswap_tag_revision(t);
>> +      break;
>> +    case ATAG_VIDEOLFB:
>> +      byteswap_tag_videolfb(t);
>> +      break;
>> +    case ATAG_CMDLINE:
>> +      break;
>> +    case ATAG_ACORN:
>> +      byteswap_tag_acorn(t);
>> +      break;
>> +    case ATAG_MEMCLK:
>> +      byteswap_tag_memclk(t);
>> +      break;
>> +    default:
>> +      /* Need to complain? */
>> +      break;
>> +    }
>> +  }
>> +}
>
>
> I think swapping on read is a better idea, as it leaves
> these in their original format.
>
> PS, looks like you either have a formatting issue with
> your email client or your code. Did this pass checkpatch?
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/head-common.S
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/head-common.S
>> +++ linux-linaro-tracking/arch/arm/kernel/head-common.S
>> @@ -48,6 +48,9 @@ __vet_atags:
>>       bne    1f
>>
>>       ldr    r5, [r2, #0]
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +        rev     r5, r5
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>>   #ifdef CONFIG_OF_FLATTREE
>>       ldr    r6, =OF_DT_MAGIC        @ is it a DTB?
>>       cmp    r5, r6
>> @@ -57,6 +60,9 @@ __vet_atags:
>>       cmpne    r5, #ATAG_CORE_SIZE_EMPTY
>>       bne    1f
>>       ldr    r5, [r2, #4]
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +        rev     r5, r5
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>>       ldr    r6, =ATAG_CORE
>>       cmp    r5, r6
>>       bne    1f
>
>
> bit-untidy. also, does OF_DT_MAGIC get changed by the
> endian-ness, or is that somewhere else in the head code?
>
>> Index: linux-linaro-tracking/arch/arm/kernel/module.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/module.c
>> +++ linux-linaro-tracking/arch/arm/kernel/module.c
>> @@ -45,6 +45,65 @@ void *module_alloc(unsigned long size)
>>   }
>>   #endif
>>
>> +/*
>> + * For relocations in exectuable sections if we configured with
>> + * CONFIG_CPU_ENDIAN_BE8 we assume that code is in little endian byteswap
>> + * form already and we need to byteswap value when we read and when we
>> + * write. If relocaton R_ARM_ABS32 type we assume that it is relocation
>> for
>> + * data piece and we do not perform byteswaps when such relocation
>> applied.
>> + * This herustic based approach may break in future.
>> + *
>> + * It seems that more correct way to handle be8 in kernel module is
>> + * to build module without --be8 option, but perform instruction byteswap
>> + * when module sections are loaded, after all relocation are applied.
>> + * In order to do such byteswap we need to read all mappings symbols ($a,
>> + * $d, $t), sort them, and apply byteswaps for $a and $t entries.
>> + */
>> +static inline u32 read_section_u32(Elf32_Shdr *dstsec, unsigned long loc)
>> +{
>> +       u32 retval = *(u32 *)loc;
>> +
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        if (dstsec->sh_flags&  SHF_EXECINSTR) {
>>
>> +                retval = __swab32(retval);
>> +        }
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +        return retval;
>> +}
>> +
>> +static inline void write_section_u32(Elf32_Shdr *dstsec, unsigned
>> long loc, u32 value)
>> +{
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        if (dstsec->sh_flags&  SHF_EXECINSTR) {
>>
>> +                value = __swab32(value);
>> +        }
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +        *(u32 *) loc = value;
>> +}
>> +
>> +#ifdef CONFIG_THUMB2_KERNEL
>> +static inline u16 read_section_u16(Elf32_Shdr *dstsec, unsigned long loc)
>> +{
>> +        u16 retval = *(u16 *) loc;
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        if (dstsec->sh_flags&  SHF_EXECINSTR) {
>>
>> +                retval = __swab16(retval);
>> +        }
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +        return retval;
>> +}
>> +
>> +static inline void write_section_u16(Elf32_Shdr *dstsec, unsigned
>> long loc, u16 value)
>> +{
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        if (dstsec->sh_flags&  SHF_EXECINSTR) {
>>
>> +                value = __swab16(value);
>> +        }
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +        *(u16 *) loc = value;
>> +}
>> +#endif /* CONFIG_THUMB2_KERNEL */
>> +
>>   int
>>   apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int
>> symindex,
>>              unsigned int relindex, struct module *module)
>> @@ -60,6 +119,7 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>           Elf32_Sym *sym;
>>           const char *symname;
>>           s32 offset;
>> +                u32 loc_u32;
>>   #ifdef CONFIG_THUMB2_KERNEL
>>           u32 upper, lower, sign, j1, j2;
>>   #endif
>> @@ -95,7 +155,8 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>           case R_ARM_PC24:
>>           case R_ARM_CALL:
>>           case R_ARM_JUMP24:
>> -            offset = (*(u32 *)loc&  0x00ffffff)<<  2;
>>
>> +                        loc_u32 = read_section_u32(dstsec, loc);
>> +            offset = (loc_u32&  0x00ffffff)<<  2;
>>               if (offset&  0x02000000)
>>
>>                   offset -= 0x04000000;
>>
>> @@ -112,27 +173,33 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>
>>               offset>>= 2;
>>
>> -            *(u32 *)loc&= 0xff000000;
>>
>> -            *(u32 *)loc |= offset&  0x00ffffff;
>> +            loc_u32&= 0xff000000;
>> +            loc_u32 |= offset&  0x00ffffff;
>>
>> +                        write_section_u32(dstsec, loc, loc_u32);
>>               break;
>>
>> -           case R_ARM_V4BX:
>> +                case R_ARM_V4BX:
>> +                        loc_u32 = read_section_u32(dstsec, loc);
>>                  /* Preserve Rm and the condition code. Alter
>>               * other bits to re-code instruction as
>>               * MOV PC,Rm.
>>               */
>> -               *(u32 *)loc&= 0xf000000f;
>>
>> -               *(u32 *)loc |= 0x01a0f000;
>> +               loc_u32&= 0xf000000f;
>>
>> +               loc_u32 |= 0x01a0f000;
>> +                       write_section_u32(dstsec, loc, loc_u32);
>>                  break;
>>
>>           case R_ARM_PREL31:
>> -            offset = *(u32 *)loc + sym->st_value - loc;
>> -            *(u32 *)loc = offset&  0x7fffffff;
>>
>> +                        loc_u32 = read_section_u32(dstsec, loc);
>> +            offset = loc_u32 + sym->st_value - loc;
>> +            loc_u32 = offset&  0x7fffffff;
>>
>> +                        write_section_u32(dstsec, loc, loc_u32);
>>               break;
>>
>>           case R_ARM_MOVW_ABS_NC:
>>           case R_ARM_MOVT_ABS:
>> -            offset = *(u32 *)loc;
>> +                        loc_u32 = read_section_u32(dstsec, loc);
>> +            offset = loc_u32;
>>               offset = ((offset&  0xf0000)>>  4) | (offset&  0xfff);
>>
>>               offset = (offset ^ 0x8000) - 0x8000;
>>
>> @@ -140,16 +207,17 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>               if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
>>                   offset>>= 16;
>>
>> -            *(u32 *)loc&= 0xfff0f000;
>>
>> -            *(u32 *)loc |= ((offset&  0xf000)<<  4) |
>> -                    (offset&  0x0fff);
>> +            loc_u32&= 0xfff0f000;
>> +            loc_u32 |= ((offset&  0xf000)<<  4) |
>> +                                   (offset&  0x0fff);
>>
>> +                        write_section_u32(dstsec, loc, loc_u32);
>>               break;
>>
>>   #ifdef CONFIG_THUMB2_KERNEL
>>           case R_ARM_THM_CALL:
>>           case R_ARM_THM_JUMP24:
>> -            upper = *(u16 *)loc;
>> -            lower = *(u16 *)(loc + 2);
>> +                        upper = read_section_u16(dstsec, loc);
>> +            lower = read_section_u16(dstsec, loc + 2);
>>
>>               /*
>>                * 25 bit signed address range (Thumb-2 BL and B.W
>> @@ -198,17 +266,19 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>               sign = (offset>>  24)&  1;
>>               j1 = sign ^ (~(offset>>  23)&  1);
>>               j2 = sign ^ (~(offset>>  22)&  1);
>> -            *(u16 *)loc = (u16)((upper&  0xf800) | (sign<<  10) |
>> -                        ((offset>>  12)&  0x03ff));
>> -            *(u16 *)(loc + 2) = (u16)((lower&  0xd000) |
>>
>> -                          (j1<<  13) | (j2<<  11) |
>> -                          ((offset>>  1)&  0x07ff));
>> +                        write_section_u16(dstsec, loc,
>> +                                          (u16)((upper&  0xf800) |
>> (sign<<  10) |
>> +                                                ((offset>>  12)&
>> 0x03ff)));
>>
>> +                        write_section_u16(dstsec, loc + 2,
>> +                                          (u16)((lower&  0xd000) |
>>
>> +                                                (j1<<  13) | (j2<<  11) |
>> +                                                ((offset>>  1)&
>> 0x07ff)));
>>
>>               break;
>>
>>           case R_ARM_THM_MOVW_ABS_NC:
>>           case R_ARM_THM_MOVT_ABS:
>> -            upper = *(u16 *)loc;
>> -            lower = *(u16 *)(loc + 2);
>> +                        upper = read_section_u16(dstsec, loc);
>> +            lower = read_section_u16(dstsec, loc + 2);
>>
>>               /*
>>                * MOVT/MOVW instructions encoding in Thumb-2:
>> @@ -229,12 +299,14 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
>>               if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
>>                   offset>>= 16;
>>
>> -            *(u16 *)loc = (u16)((upper&  0xfbf0) |
>> -                        ((offset&  0xf000)>>  12) |
>> -                        ((offset&  0x0800)>>  1));
>>
>> -            *(u16 *)(loc + 2) = (u16)((lower&  0x8f00) |
>> -                          ((offset&  0x0700)<<  4) |
>> -                          (offset&  0x00ff));
>>
>> +                        write_section_u16(dstsec, loc,
>> +                                          (u16)((upper&  0xfbf0) |
>> +                                                ((offset&  0xf000)>>  12)
>> |
>> +                                                ((offset&  0x0800)>>
>> 1)));
>>
>> +                        write_section_u16(dstsec, loc + 2,
>> +                                          (u16)((lower&  0x8f00) |
>> +                                                ((offset&  0x0700)<<  4)
>> |
>> +                                                (offset&  0x00ff)));
>>               break;
>>   #endif
>>
>
> I'm still not sure about this, I think the use of <asm/opcodes.h>
> is better here. Not sure if there's much point in checking the flags
> on the sections as I think the relocations pretty much define which
> endian they will be in.

Wrt asm/opcodes.h, yes, agree it should be used now.

I'll need to check why I used section attributes to guide byteswaps. I think it
was done for a reason. We tested it with bigger system on top with quite a bit
of different KMLs, I think I run into problem with some of them. Will need dig
back. As my comment says ideally it would be better to use $a, $d, $t, symbols;
that is what ld does with --be8 option, but it maybe too hard as
starting point.

>> Index: linux-linaro-tracking/arch/arm/mm/Kconfig
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/mm/Kconfig
>> +++ linux-linaro-tracking/arch/arm/mm/Kconfig
>> @@ -695,6 +695,15 @@ config CPU_ENDIAN_BE32
>>       help
>>         Support for the BE-32 (big-endian) mode on pre-ARMv6 processors.
>>
>> +config LITTLE_ENDIAN_LOADER
>> +        bool
>> +        depends on CPU_BIG_ENDIAN
>> +        default y
>> +        help
>> +          If Linux should operate in big-endian mode, but bootloader
>> (i.e u-boot)
>> +          is still in little endian mode and passes boot information in
>> little
>> +          endian form set this flag
>> +
>>   config CPU_HIGH_VECTOR
>>       depends on !MMU&&  CPU_CP15&&  !CPU_ARM740T
>>
>>       bool "Select the High exception vector"
>
>
>
>> Index: linux-linaro-tracking/arch/arm/mm/alignment.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/mm/alignment.c
>> +++ linux-linaro-tracking/arch/arm/mm/alignment.c
>> @@ -792,6 +792,10 @@ do_alignment(unsigned long addr, unsigne
>>
>>       regs->ARM_pc += isize;
>>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        instr = __swab32(instr); /* little endian instruction */
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +
>>       switch (CODING_BITS(instr)) {
>>       case 0x00000000:    /* 3.13.4 load/store instruction extensions */
>>           if (LDSTHD_I_BIT(instr))
>
>
> See comments on <asm/opcodes.h>
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/head.S
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/head.S
>> +++ linux-linaro-tracking/arch/arm/kernel/head.S
>> @@ -89,6 +89,12 @@ ENTRY(stext)
>>       @ ensure svc mode and all interrupts masked
>>       safe_svcmode_maskall r9
>>
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +    /*
>> +    * Switch to bigendian mode
>> +    */
>> +    setend    be
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>>       mrc    p15, 0, r9, c0, c0        @ get processor id
>>       bl    __lookup_processor_type        @ r5=procinfo r9=cpuid
>>       movs    r10, r5                @ invalid processor (r5=0)?
>> @@ -356,6 +362,12 @@ ENTRY(secondary_startup)
>>   #endif
>>       safe_svcmode_maskall r9
>>
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +    /*
>> +    * Switch to bigendian mode
>> +    */
>> +    setend    be
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>>       mrc    p15, 0, r9, c0, c0        @ get processor id
>>       bl    __lookup_processor_type
>>       movs    r10, r5                @ invalid processor?
>> @@ -427,6 +439,9 @@ __enable_mmu:
>>   #ifdef CONFIG_CPU_ICACHE_DISABLE
>>       bic    r0, r0, #CR_I
>>   #endif
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +    orr    r0, r0, #CR_EE    @ big-endian page tables
>> +#endif
>>   #ifdef CONFIG_ARM_LPAE
>>       mov    r5, #0
>>       mcrr    p15, 0, r4, r5, c2        @ load TTBR0
>> @@ -592,8 +607,14 @@ __fixup_a_pv_table:
>>       b    2f
>>   1:    add     r7, r3
>>       ldrh    ip, [r7, #2]
>> +#ifdef __ARMEB__
>> +        rev     ip, ip   @ byteswap instruction
>> +#endif /* __ARMEB__ */
>>       and    ip, 0x8f00
>>       orr    ip, r6    @ mask in offset bits 31-24
>> +#ifdef __ARMEB__
>> +        rev     ip, ip   @ byteswap instruction
>> +#endif /* __ARMEB__ */
>>       strh    ip, [r7, #2]
>>   2:    cmp    r4, r5
>>       ldrcc    r7, [r4], #4    @ use branch for delay slot
>> @@ -602,8 +623,14 @@ __fixup_a_pv_table:
>>   #else
>>       b    2f
>>   1:    ldr    ip, [r7, r3]
>> +#ifdef __ARMEB__
>> +        rev     ip, ip   @ byteswap instruction
>> +#endif /* __ARMEB__ */
>>       bic    ip, ip, #0x000000ff
>>       orr    ip, ip, r6    @ mask in offset bits 31-24
>> +#ifdef __ARMEB__
>> +        rev     ip, ip   @ byteswap instruction
>> +#endif /* __ARMEB__ */
>>       str    ip, [r7, r3]
>>   2:    cmp    r4, r5
>>       ldrcc    r7, [r4], #4    @ use branch for delay slot
>
>
> Yeah, prefer my macros for doing this.
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/kprobes.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/kprobes.c
>> +++ linux-linaro-tracking/arch/arm/kernel/kprobes.c
>> @@ -66,14 +66,24 @@ int __kprobes arch_prepare_kprobe(struct
>>       if (is_wide_instruction(insn)) {
>>           insn<<= 16;
>>           insn |= ((u16 *)addr)[1];
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +                insn = __swab32(insn); /* little endian instruction */
>> +#endif
>>           decode_insn = thumb32_kprobe_decode_insn;
>> -    } else
>> -        decode_insn = thumb16_kprobe_decode_insn;
>> +    } else {
>> +                decode_insn = thumb16_kprobe_decode_insn;
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +                insn = __swab16(insn); /* little endian instruction */
>> +#endif
>> +        }
>>   #else /* !CONFIG_THUMB2_KERNEL */
>>       thumb = false;
>>       if (addr&  0x3)
>>
>>           return -EINVAL;
>>       insn = *p->addr;
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        insn = __swab32(insn); /* little endian instruction */
>> +#endif
>>       decode_insn = arm_kprobe_decode_insn;
>>   #endif
>>
>> @@ -89,7 +99,11 @@ int __kprobes arch_prepare_kprobe(struct
>>           if (!p->ainsn.insn)
>>               return -ENOMEM;
>>           for (is = 0; is<  MAX_INSN_SIZE; ++is)
>> +#ifndef CONFIG_CPU_ENDIAN_BE8
>>               p->ainsn.insn[is] = tmp_insn[is];
>> +#else
>> +                        p->ainsn.insn[is] = __swab32(tmp_insn[is]);
>> /* little endian instruction */
>> +#endif
>>           flush_insns(p->ainsn.insn,
>>                   sizeof(p->ainsn.insn[0]) * MAX_INSN_SIZE);
>>           p->ainsn.insn_fn = (kprobe_insn_fn_t *)
>> @@ -113,10 +127,17 @@ void __kprobes arch_arm_kprobe(struct kp
>>           /* Remove any Thumb flag */
>>           addr = (void *)((uintptr_t)p->addr&  ~1);
>>
>>
>> -        if (is_wide_instruction(p->opcode))
>> +        if (is_wide_instruction(p->opcode)) {
>>               brkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
>> -        else
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +                brkp = __swab32(brkp);
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +        } else {
>>               brkp = KPROBE_THUMB16_BREAKPOINT_INSTRUCTION;
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +                brkp = __swab16(brkp);
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +            }
>>       } else {
>>           kprobe_opcode_t insn = p->opcode;
>>
>> @@ -127,6 +148,10 @@ void __kprobes arch_arm_kprobe(struct kp
>>               brkp |= 0xe0000000;  /* Unconditional instruction */
>>           else
>>               brkp |= insn&  0xf0000000;  /* Copy condition from insn */
>>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        brkp = __swab32(brkp);
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +
>>       }
>>
>>       patch_text(addr, brkp);
>> @@ -144,8 +169,12 @@ int __kprobes __arch_disarm_kprobe(void
>>   {
>>       struct kprobe *kp = p;
>>       void *addr = (void *)((uintptr_t)kp->addr&  ~1);
>>
>> +    kprobe_opcode_t insn = kp->opcode;
>>
>> -    __patch_text(addr, kp->opcode);
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        insn = __swab32(insn); /* little endian instruction */
>> +#endif
>> +    __patch_text(addr, insn);
>>
>>       return 0;
>>
>
> __patch_text already does swapping, so a little concerned that it
> is being done twice in some places.
>
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/traps.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/traps.c
>> +++ linux-linaro-tracking/arch/arm/kernel/traps.c
>> @@ -426,6 +426,10 @@ asmlinkage void __exception do_undefinst
>>           goto die_sig;
>>       }
>>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        instr = __swab32(instr); /* little endian instruction */
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +
>>       if (call_undef_hook(regs, instr) == 0)
>>           return;
>
>
> already fixed.
>
>
>> Index: linux-linaro-tracking/arch/arm/kernel/ftrace.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/ftrace.c
>> +++ linux-linaro-tracking/arch/arm/kernel/ftrace.c
>> @@ -100,10 +100,18 @@ static int ftrace_modify_code(unsigned l
>>           if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
>>               return -EFAULT;
>>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        replaced = __swab32(replaced); /* little endian instruction */
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +
>>           if (replaced != old)
>>               return -EINVAL;
>>       }
>>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +        new = __swab32(new); /* little endian instruction */
>> +#endif /* CONFIG_CPU_ENDIAN_BE8 */
>> +
>>       if (probe_kernel_write((void *)pc,&new, MCOUNT_INSN_SIZE))
>>           return -EPERM;
>
>
> Please see <asm/opcodes.h> for dealing with the op-codes like this.

Yes, agree. It is not needed any more. In kernel 3.1/3.2 there was no
asm/opcodes.h, __opcode_to_mem_arm, etc macros. So that was added. It is
incorrect now.

>
>> Index: linux-linaro-tracking/arch/arm/kernel/atags_parse.c
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/kernel/atags_parse.c
>> +++ linux-linaro-tracking/arch/arm/kernel/atags_parse.c
>> @@ -216,6 +216,10 @@ struct machine_desc * __init setup_machi
>>       if (tags->hdr.tag != ATAG_CORE)
>>           convert_to_tag_list(tags);
>>   #endif
>> +#ifdef CONFIG_LITTLE_ENDIAN_LOADER
>> +    byteswap_tags(tags);
>> +#endif /* CONFIG_LITTLE_ENDIAN_LOADER */
>> +
>>       if (tags->hdr.tag != ATAG_CORE) {
>>           early_print("Warning: Neither atags nor dtb found\n");
>>           tags = (struct tag *)&default_tags;
>> Index: linux-linaro-tracking/arch/arm/kernel/sleep.S
>
>
> I really don't like this way, it makes it difficult to deal with
> if you export this data to user-space to then do things like md5sum
> it. Also, if you're going to kexec() a new kernel, would you have
> to re-swap it back before this?

Agree that swap in place could be problematic.
I will look at this, starting with patches you've done. Will get back to you.

>> Index: linux-linaro-tracking/arch/arm/include/asm/atomic.h
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/include/asm/atomic.h
>> +++ linux-linaro-tracking/arch/arm/include/asm/atomic.h
>> @@ -301,8 +301,13 @@ static inline void atomic64_add(u64 i, a
>>
>>       __asm__ __volatile__("@ atomic64_add\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %4\n"
>>   "    adc    %H0, %H0, %H4\n"
>> +#else
>> +"    adds    %H0, %H0, %H4\n"
>> +"    adc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -320,8 +325,13 @@ static inline u64 atomic64_add_return(u6
>>
>>       __asm__ __volatile__("@ atomic64_add_return\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %4\n"
>>   "    adc    %H0, %H0, %H4\n"
>> +#else
>> +"    adds    %H0, %H0, %H4\n"
>> +"    adc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -341,8 +351,13 @@ static inline void atomic64_sub(u64 i, a
>>
>>       __asm__ __volatile__("@ atomic64_sub\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, %4\n"
>>   "    sbc    %H0, %H0, %H4\n"
>> +#else
>> +"    subs    %H0, %H0, %H4\n"
>> +"    sbc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -360,8 +375,13 @@ static inline u64 atomic64_sub_return(u6
>>
>>       __asm__ __volatile__("@ atomic64_sub_return\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, %4\n"
>>   "    sbc    %H0, %H0, %H4\n"
>> +#else
>> +"    subs    %H0, %H0, %H4\n"
>> +"    sbc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -428,9 +448,15 @@ static inline u64 atomic64_dec_if_positi
>>
>>       __asm__ __volatile__("@ atomic64_dec_if_positive\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, #1\n"
>>   "    sbc    %H0, %H0, #0\n"
>>   "    teq    %H0, #0\n"
>> +#else
>> +"    subs    %H0, %H0, #1\n"
>> +"    sbc    %0, %0, #0\n"
>> +"    teq    %0, #0\n"
>> +#endif
>>   "    bmi    2f\n"
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>> @@ -459,8 +485,13 @@ static inline int atomic64_add_unless(at
>>   "    teqeq    %H0, %H5\n"
>>   "    moveq    %1, #0\n"
>>   "    beq    2f\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %6\n"
>>   "    adc    %H0, %H0, %H6\n"
>> +#else
>> +"    adds    %H0, %H0, %H6\n"
>> +"    adc    %0, %0, %6\n"
>> +#endif
>>   "    strexd    %2, %0, %H0, [%4]\n"
>>   "    teq    %2, #0\n"
>>   "    bne    1b\n"
>
>
> I still believe that you're doing the wrong thing here
> and that these can be left well enough alone. Please give
> a concrete piece of code that can show they're actually
> doing the wrong thing.

That one is addressed in separate email.

Thanks,
Victor

>
>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
