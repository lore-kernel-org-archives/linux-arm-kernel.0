From: trong@android.com (Tri Vo)
Date: Fri, 10 Aug 2018 15:04:55 -0700
Subject: [RFC PATCH] arm64: lse: use register variables instead of
 -ffixed, -fcall flags
In-Reply-To: <20180810094611.GA12273@arm.com>
References: <20180810020751.44859-1-trong@android.com>
 <20180810094611.GA12273@arm.com>
Message-ID: <CANA+-vDPp=tSBq_2U7T1RD8BpDs6DWm=pkVp73HGdehbhcc-tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 2:46 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Aug 09, 2018 at 07:07:51PM -0700, Tri Vo wrote:
>> -ffixed, -fcall-used, -fcall-saved flags are used to build LL/SC
>> fallback atomic implementations in such a way that:
>> 1. LSE implementations only assume x16, x17, x30 to be clobbered by a
>> function call to LL/SC fallbacks.
>> 2. LL/SC fallbacks are responsible for saving/restoring the rest of the
>> GPRs.
>> 3. LL/SC fallbacks always prefer to allocate in x16, x17 since there is
>> no need to save/restore them.
>>
>> Same result can be achieved without -ffixed, -fcall-used, -fcall-saved
>> flags by explicitly telling the compiler where to allocate each variable
>> in LL/SC atomic implementations. This patch makes all functions use x16,
>> x17 registers. 'fetch' variants of the functions need one more scratch
>> register, so we allocate one from the PCS's set of callee-saved
>> registers (in this case x19).
>>
>> With this patch:
>> 1. the desired register allocation is reflected in the code rather than
>> in compiler flags.
>> 2. LSE atomic support can be built with both clang and gcc.
>> 3. Number of preserved registers in LL/SC fallbacks is unchanged.
>>
>> The tradeoff is that the compiler loses flexibility in allocating
>> registers for inline LL/SC atomic implementations.
>
> This impacts the atomics code when !CONFIG_LSE, and causes the fetch*
> variants to spill x19 in most cases.

Is it OK if I wrap that x19 register variable in an #ifdef so it's
only allocated to x19 when CONFIG_LSE and is allocated normally for
!CONFIG_LSE? That should keep the number of spills unchanged for both
inline and out-of-line implementations.
>
> Please just fix clang, or augment the lseinstr check in our Makefile to
> check for ffixed support as well.
>
> Thanks,
>
> Will
