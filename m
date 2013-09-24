From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 24 Sep 2013 18:30:48 +0800
Subject: [PATCH] ARM: include: asm: atomic.h: use type cast 's64' for
 the return value of atomic64_add_return().
In-Reply-To: <20130924093041.GB15119@mudshark.cambridge.arm.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
Message-ID: <524169D8.1080904@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 05:30 PM, Will Deacon wrote:
> Hello,
> 
> On Sat, Sep 21, 2013 at 12:06:47PM +0100, Chen Gang wrote:
>> The return value of atomic64_add_return() is u64 which never less than
>> zero, so need type cast 's64' for comparing in atomic64_add_negative().
>>
>> The related error: (allmodconfig for S5PV210, with "EXTRA_CFLAGS=-W"):
>>
>>   kernel/events/core.c:5404:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/include/asm/atomic.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
>> index da1c77d..8cf005d 100644
>> --- a/arch/arm/include/asm/atomic.h
>> +++ b/arch/arm/include/asm/atomic.h
>> @@ -475,7 +475,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>>  	return ret;
>>  }
>>  
>> -#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
>> +#define atomic64_add_negative(a, v)	((s64)atomic64_add_return((a), (v)) < 0)
>>  #define atomic64_inc(v)			atomic64_add(1LL, (v))
>>  #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
>>  #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
> 
> Is this the right fix? It looks more like atomic[64]_t should be signed, but
> some 32-bit architectures (ARM, x86, tile) are actually implementing
> atomic64_t as u64. Furthermore, there are discrepencies in the operands to
> the various atomic64_* function (long long vs u64) which probably need
> sorting out.
> 
> Since the 32-bit interface is well defined (Documentation/atomic_ops.txt),
> I think we should just follow the same signedness rules for the 64-bit
> versions.
> 

That sounds reasonable, excluding arm and tile_32, all are defined as
signed (even for related 32-bits functions, arm and tile are also use
signed).

For atomic64_add_negative(), like arm, tile also has the same issue
(unsigned type is never less than zero).

Tomorrow, I will send patch v2 for arm, and another fix patch for tile.
:-)

Thanks.


The related search:

  arm/include/asm/atomic.h:314:static inline u64 atomic64_add_return(u64 i, atomic64_t *v) 
  tile/include/asm/atomic_32.h:123:static inline u64 atomic64_add_return(u64 i, atomic64_t *v) 

  ia64/include/asm/atomic.h:137:#define atomic64_add_return(i,v)                                  \   

  alpha/include/asm/atomic.h:115:static __inline__ long atomic64_add_return(long i, atomic64_t * v)
  arm64/include/asm/atomic.h:194:static inline long atomic64_add_return(long i, atomic64_t *v) 
  frv/include/asm/atomic.h:152:extern long long atomic64_add_return(long long i, atomic64_t *v);
  mips/include/asm/atomic.h:499:static __inline__ long atomic64_add_return(long i, atomic64_t * v)
  parisc/include/asm/atomic.h:156:__atomic64_add_return(s64 i, atomic64_t *v) 
  parisc/include/asm/atomic.h:190:#define atomic64_add_return(i,v)        (__atomic64_add_return( ((s64)(i)),(v)))
  powerpc/include/asm/atomic.h:310:static __inline__ long atomic64_add_return(long a, atomic64_t *v) 
  s390/include/asm/atomic.h:199:static inline long long atomic64_add_return(long long i, atomic64_t *v) 
  s390/include/asm/atomic.h:284:static inline long long atomic64_add_return(long long i, atomic64_t *v) 
  sparc/include/asm/atomic_64.h:42:#define atomic64_add_return(i, v) atomic64_add_ret(i, v)
  tile/include/asm/atomic_64.h:73:static inline long atomic64_add_return(long i, atomic64_t *v) 
  x86/include/asm/atomic64_32.h:134:static inline long long atomic64_add_return(long long i, atomic64_t *v) 
  x86/include/asm/atomic64_64.h:171:static inline long atomic64_add_return(long i, atomic64_t *v) 


> Will
> 
> 

Thanks
-- 
Chen Gang
