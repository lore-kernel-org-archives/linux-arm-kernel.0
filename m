From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 8 Dec 2016 10:59:45 +0000
Subject: [RFC PATCH v3 07/11] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <87r35jmv3e.fsf@wedge.i-did-not-set--mail-host-address--so-tickle-me>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
 <20161206160353.14581-8-kevin.brodsky@arm.com>
 <87r35jmv3e.fsf@wedge.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <0707aecb-6638-2447-cf4a-9c30fc08dae5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/16 18:51, Nathan Lynch wrote:
> Hi Kevin,

Hi Nathan,

Thanks for taking a look at these patches!

> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
>> new file mode 100644
>> index 000000000000..53c3d1f82b26
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
> As I said at LPC last month, I'm not excited to have arch/arm's
> vgettimeofday.c copied into arch/arm64 and tweaked; I'd rather see this
> part of the implementation shared between arch/arm and arch/arm64
> somehow, even if there's not an elegant way to do so.
>
> The situation which must be avoided is one where the arch/arm64 compat
> VDSO incompatibly diverges from the arch/arm VDSO.  That becomes much
> less likely if there's only one copy of the userspace-exposed code to
> maintain.

I still agree this is very suboptimal. However, I also think this is by far the most 
straightforward solution, and I would like to stick to it *as a first step*. If you 
diff this "tweaked" vgettimeofday.c with the original one, you'll see that it is 
really not obvious to share even parts of vgettimeofday.c in the current state of arm 
and arm64. Besides, arm's vDSO hasn't changed much since it has been introduced last 
year, and vgettimeofday.c hasn't changed at all, so I think it's fair to say 
divergences are unlikely to happen in the near future.

Nevertheless, I completely agree this is not a good situation in the long run, and I 
am not happy with leaving things in this state. After this series is merged, my plan 
is to try and align arm and arm64 both in terms of vDSO features and kernel-vDSO 
interface. This would notably involve:
* Aligning the vDSO data struct's (especially vdso_data's member names), so that 
vgettimeofday.c can be (mostly) shared.
* Non-trivial Makefile work to share the same one between the arm and arm64 compat 
vDSOs. The refactoring I did in v3 is a first step, as not using top-level flags 
makes it more feasible to share the same Makefile.
* Adding support for CLOCK_MONOTONIC_RAW, as I did in the 64-bit vDSO.
* Moving arm's sigreturn trampolines to its vDSO (if enabled), and convince glibc to 
use the kernel's trampolines like on arm64.

This represents a substantial amount of work, which I think should be in a separate 
series (this one has already grown bigger than I expected).

The final step would be to investigate whether the 64-bit vDSO could reasonably move 
to a C implementation, and if it is the case unify the 3 vDSOs.

> [...]
>
>> +/*
>> + * We use the hidden visibility to prevent the compiler from generating a GOT
>> + * relocation. Not only is going through a GOT useless (the entry couldn't and
>> + * musn't be overridden by another library), it does not even work: the linker
>> + * cannot generate an absolute address to the data page.
>> + *
>> + * With the hidden visibility, the compiler simply generates a PC-relative
>> + * relocation (R_ARM_REL32), and this is what we need.
>> + */
>> +extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
>> +
>> +static inline const struct vdso_data *get_vdso_data(void)
>> +{
>> +	const struct vdso_data *ret;
>> +	/*
>> +	 * This simply puts &_vdso_data into ret. The reason why we don't use
>> +	 * `ret = &_vdso_data` is that the compiler tends to optimise this in a
>> +	 * very suboptimal way: instead of keeping &_vdso_data in a register,
>> +	 * it goes through a relocation almost every time _vdso_data must be
>> +	 * accessed (even in subfunctions). This is both time and space
>> +	 * consuming: each relocation uses a word in the code section, and it
>> +	 * has to be loaded at runtime.
>> +	 *
>> +	 * This trick hides the assignment from the compiler. Since it cannot
>> +	 * track where the pointer comes from, it will only use one relocation
>> +	 * where get_vdso_data() is called, and then keep the result in a
>> +	 * register.
>> +	 */
>> +	asm("mov %0, %1" : "=r"(ret) : "r"(&_vdso_data));
>> +	return ret;
>> +}
> I think this is an instructive case: this code looks like an improvement
> over how the arch/arm VDSO accesses the data page.  Enhancements like
> this (not to mention fixes) shouldn't require a patch-per-architecture;
> things inevitably get out of sync and it's more of a maintenance burden
> in the long term.

What arm does is suboptimal indeed, as it uses a whole function to derive vdso_data's 
address instead of a simple relocation. However both methods are functionally 
equivalent. The approach I used here is simply consistent with how vdso_data is 
accessed in the 64-bit vDSO (with those two tricks because of both an assembler 
difference and the fact we are using C here, and GCC is not being smart). Again, I 
agree the arm vDSO should use the same approach, but unification requires other 
changes beyond the scope of this first series.

Thanks,
Kevin
