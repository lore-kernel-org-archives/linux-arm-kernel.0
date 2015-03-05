From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 5 Mar 2015 09:53:06 +0800
Subject: [PATCH 3/3] early kprobes: x86: don't try to recover ftraced
 instruction before ftrace get ready.
In-Reply-To: <54F72438.3010405@hitachi.com>
References: <54F69F45.3000704@hitachi.com>
 <1425468122-54515-1-git-send-email-wangnan0@huawei.com>
 <54F72438.3010405@hitachi.com>
Message-ID: <54F7B702.2000403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to your reply. I have some inline comment. Please see below.

By the way, as you suggested me to fold my patches up, will you review my v4
series? Or do you want to start looking at early kprobe after I merge small patch pieces
together? Then I can decide whether to post a v5 series with only patch merging
and cleanups before receiving your comments.

On 2015/3/4 23:26, Masami Hiramatsu wrote:
> Hi Wang,
> 
> (2015/03/04 20:22), Wang Nan wrote:
>> Hi Masami,
>>
>> Following your advise, I adjusted early kprobe patches, added a
>> kprobes_init_stage var to indicate the initiaization progress of
>> kprobes. It has following avaliable values:
>>
>>  typedef enum {
>>  	/* kprobe initialization is error. */
>>  	KP_STG_ERR = -1,
> 
> Eventually, all the negative values should be handled as an error,
> then we can store an encoded error reason or location on it.
> Anyway, at this point we don't need it.
> 
>>  	/* kprobe is not ready. */
>>  	KP_STG_NONE,
> 
> Please put the comment on the same line, as below.
> 
> 	KP_STG_ERR = -1,	/* kprobe initialization is error. */
> 	KP_STG_NONE,		/* kprobe is not ready. */
> 	...
> 
>>  	/* kprobe is available. */
>>  	KP_STG_AVAIL,
> 
>  KP_STG_EARLY is better, isn't it? :)

Sure. I will change it.

> 
>>  	/* Ftrace initialize is ready */
>>  	KP_STG_FTRACE_READY,
>>  	/* All resources are ready */
>>  	KP_STG_FULL,
>>  /*
>>   * Since memory system is ready before ftrace, after ftrace inited we
>>   * are able to alloc normal kprobes.
>>   */
>>  #define KP_STG_NORMAL KP_STG_FTRACE_READY
> 
> No need to use macro, you can directly define enum symbol.
> 	KP_STG_NORMAL = KP_STG_FTRACE_READY
> 
> BTW, what's the difference of FULL and NORMAL?
> 

Please see patch 4/34 and 7/34. Since populate_kprobe_blacklist() is the only part which
is unable to be called before memory system is ready, I leave it at its original place
(init_kprobes), and introduces a within_kprobe_blacklist_early() which is slow but doesn't
require populate_kprobe_blacklist(). KP_STG_FULL now is used to indicate whether
populate_kprobe_blacklist() is ready. When init progress goes to KP_STG_NORMAL, there's
no need to allocate statically allocated slots, but still require calling within_kprobe_blacklist_early().

In fact, it is possible to make memory system notifying kprobes like what ftrace does, and set
KP_STG_NORMAL to something like KP_STG_MEMORY_READY. populate_kprobe_blacklist() can be done when
get notified from memory system. Then init_kprobes() can be totally trimed. Howver, if we want
to do something on early kprobes before whole system booted (currently I don't do that), we still
need init_kprobes() and a KP_STG_FULL init stage.

>>  } kprobes_init_stage_t;
>>
>> And kprobes_is_early becomes:
>>
>>  static inline bool kprobes_is_early(void)
>>  {
>>  	return (kprobes_init_stage < KP_STG_NORMAL);
>>  }
>>
>> A helper function is add to make progress:
>>
>>  static void kprobes_update_init_stage(kprobes_init_stage_t s)
>>  {
>>  	BUG_ON((kprobes_init_stage == KP_STG_ERR) ||
>>  			((s <= kprobes_init_stage) && (s != KP_STG_ERR)));
>>  	kprobes_init_stage = s;
>>  }
> 
> Good! this serializes the initialization stage :)
> 
>>
>> Original kprobes_initialized, kprobes_blacklist_initialized
>> kprobes_on_ftrace_initialized are all removed, replaced by:
>>
>>   kprobes_initialized --> (kprobes_init_stage >= KP_STG_AVAIL)
>>   kprobes_blacklist_initialized --> (kprobes_init_stage >= KP_STG_FULL)
>>   kprobes_on_ftrace_initialized --> (kprobes_init_stage >= KP_STG_FTRACE_READY)
>>
>> respectively.
> 
> Yes, that is what I want.
> 
>>
>> Following patch is extracted from my WIP v5 series and will be distributed
>> into separated patches.
>>
>> (Please note that it is edited manually and unable to be applied directly.)
>>
>> Do you have any futher suggestion?
> 
> Sorry, I have still not reviewed your series yet, but it seems that your
> patches are chopped to smaller pieces. I recommend you to fold them up to
> better granularity, like
>  - Each patch can be compiled without warnings.
>  - If you introduce new functions, it should be called from somewhere in
>    the same patch. (no orphaned functions, except for module APIs)

It may mix arch and arch-dependent code together. I'll try it in v5 series.

>  - Bugfix, cleanup, and enhance it.
> 
> And now I'm considering that the early kprobe should be started as an
> independent series from ftrace. For example, we can configure early_kprobe
> only when KPROBE_ON_FTRACE=n. That will make it simpler and we can focus
> on what we basically need to do.
> 

Yes, this is what I did in v4 series. Patch 'early kprobes: add CONFIG_EARLY_KPROBES option.'
only enables it for ARM. After solving KPROBES_ON_FTRACE, an 'early kprobes: enable early kprobes for x86.'
enables it for x86.

Thank you.

> Thank you,
> 
>>
>> Thank you!
>>
>> ---
>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
>> index 87beb64..f8b7dcb 100644
>> --- a/arch/x86/kernel/kprobes/core.c
>> +++ b/arch/x86/kernel/kprobes/core.c
>> @@ -234,6 +234,20 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>>  	 */
>>  	if (WARN_ON(faddr && faddr != addr))
>>  		return 0UL;
>> +
>> +	/*
>> +	 * If ftrace is not ready yet, pretend this is not an ftrace
>> +	 * location, because currently the target instruction has not
>> +	 * been replaced by a NOP yet. When ftrace trying to convert
>> +	 * it to NOP, kprobe should be notified and the kprobe data
>> +	 * should be fixed at that time.
>> +	 *
>> +	 * Since it is possible that an early kprobe already on that
>> +	 * place, don't return addr directly.
>> +	 */
>> +	if (unlikely(kprobes_init_stage < KP_STG_FTRACE_READY))
>> +		faddr = 0UL;
>> +
>>  	/*
>>  	 * Use the current code if it is not modified by Kprobe
>>  	 * and it cannot be modified by ftrace.
>> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
>> index 2d78bbb..04b97ec 100644
>> --- a/include/linux/kprobes.h
>> +++ b/include/linux/kprobes.h
>> @@ -50,7 +50,31 @@
>>  #define KPROBE_REENTER		0x00000004
>>  #define KPROBE_HIT_SSDONE	0x00000008
>>  
>> -extern bool kprobes_is_early(void);
>> +/* Initialization state of kprobe */
>> +typedef enum {
>> +	/* kprobe initialization is error. */
>> +	KP_STG_ERR = -1,
>> +	/* kprobe is not ready. */
>> +	KP_STG_NONE,
>> +	/* kprobe is available. */
>> +	KP_STG_AVAIL,
>> +	/* Ftrace initialize is ready */
>> +	KP_STG_FTRACE_READY,
>> +	/* All resources are ready */
>> +	KP_STG_FULL,
>> +/*
>> + * Since memory system is ready before ftrace, after ftrace inited we
>> + * are able to alloc normal kprobes.
>> + */
>> +#define KP_STG_NORMAL KP_STG_FTRACE_READY
>> +} kprobes_init_stage_t;
>> +
>> +extern kprobes_init_stage_t kprobes_init_stage;
>> +
>> +static inline bool kprobes_is_early(void)
>> +{
>> +	return (kprobes_init_stage < KP_STG_NORMAL);
>> +}
>>  
>>  #else /* CONFIG_KPROBES */
>>  typedef int kprobe_opcode_t;
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 1ec8e6e..f4d9fca 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -67,17 +67,14 @@
>>  	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
>>  #endif
>>  
>> -static int kprobes_initialized;
>> -static int kprobes_blacklist_initialized;
>> -#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
>> -static bool kprobes_on_ftrace_initialized __read_mostly = false;
>> -#else
>> -# define kprobes_on_ftrace_initialized	false
>> -#endif
>> +kprobes_init_stage_t kprobes_init_stage __read_mostly = KP_STG_NONE;
>> +#define kprobes_initialized	(kprobes_init_stage >= KP_STG_AVAIL)
>>  
>> -bool kprobes_is_early(void)
>> +static void kprobes_update_init_stage(kprobes_init_stage_t s)
>>  {
>> -	return !(kprobes_initialized && kprobes_blacklist_initialized);
>> +	BUG_ON((kprobes_init_stage == KP_STG_ERR) ||
>> +			((s <= kprobes_init_stage) && (s != KP_STG_ERR)));
>> +	kprobes_init_stage = s;
>>  }
>>  
>>  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
>> @@ -1416,7 +1415,7 @@ static bool within_kprobe_blacklist(unsigned long addr)
>>  		return true;
>>  #endif
>>  
>> -	if (!kprobes_blacklist_initialized)
>> +	if (kprobes_init_stage < KP_STG_FULL)
>>  		return within_kprobe_blacklist_early(addr);
>>  
>>  	/*
>> @@ -1502,7 +1501,7 @@ int __weak arch_check_ftrace_location(struct kprobe *p)
>>  		/* Given address is not on the instruction boundary */
>>  		if ((unsigned long)p->addr != ftrace_addr)
>>  			return -EILSEQ;
>> -		if (unlikely(!kprobes_on_ftrace_initialized))
>> +		if (unlikely(kprobes_init_stage < KP_STG_FTRACE_READY))
>>  			p->flags |= KPROBE_FLAG_FTRACE_EARLY;
>>  		else
>>  			p->flags |= KPROBE_FLAG_FTRACE;
>> @@ -1569,10 +1568,8 @@ int register_kprobe(struct kprobe *p)
>>  	struct module *probed_mod;
>>  	kprobe_opcode_t *addr;
>>  
>> -#ifndef CONFIG_EARLY_KPROBES
>> -	if (kprobes_is_early())
>> -		return -EAGAIN;
>> -#endif
>> +	if (kprobes_init_stage < KP_STG_AVAIL)
>> +		return -ENOSYS;
>>  
>>  	/* Adjust probe address from symbol */
>>  	addr = kprobe_addr(p);
>> @@ -2271,7 +2286,8 @@ void init_kprobes_early(void)
>>  	if (!err)
>>  		err = register_module_notifier(&kprobe_module_nb);
>>  
>> -	kprobes_initialized = (err == 0);
>> +	kprobes_update_init_stage(err == 0 ? KP_STG_AVAIL : KP_STG_ERR);
>> +
>>  #ifdef CONFIG_EARLY_KPROBES
>>  	if (!err)
>>  		init_test_probes();
>> @@ -2301,9 +2317,7 @@ static int __init init_kprobes(void)
>>  		pr_err("kprobes: failed to populate blacklist: %d\n", err);
>>  		pr_err("Please take care of using kprobes.\n");
>>  	}
>> -	kprobes_blacklist_initialized = (err == 0);
>> -
>> -	err = kprobes_is_early() ? -ENOSYS : 0;
>> +	kprobes_update_init_stage(err == 0 ? KP_STG_FULL : KP_STG_ERR);
>>  
>>  	/* TODO: deal with early kprobes. */
>>  
>> @@ -2607,7 +2621,7 @@ bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec)
>>  	int optimized;
>>  	void *addr;
>>  
>> -	if (kprobes_on_ftrace_initialized)
>> +	if (kprobes_init_stage >= KP_STG_FTRACE_READY)
>>  		return false;
>>  
>>  	addr = (void *)rec->ip;
>> @@ -2731,15 +2745,20 @@ static void convert_early_kprobes_on_ftrace(void)
>>  			}
>>  		}
>>  	}
>> -	mutex_unlock(&kprobe_mutex);
>>  }
>> +#else
>> +static inline void convert_early_kprobes_on_ftrace(void)
>> +{
>> +}
>> +#endif // CONFIG_KPROBES_ON_FTRACE && CONFIG_EARLY_KPROBES
>>  
>>  void init_kprobes_on_ftrace(void)
>>  {
>> -	kprobes_on_ftrace_initialized = true;
>> +	mutex_lock(&kprobe_mutex);
>> +	kprobes_update_init_stage(KP_STG_FTRACE_READY);
>>  	convert_early_kprobes_on_ftrace();
>> +	mutex_unlock(&kprobe_mutex);
>>  }
>> -#endif
>>  
>>  #ifdef CONFIG_EARLY_KPROBES
>>  static int early_kprobe_pre_handler(struct kprobe *p, struct pt_regs *regs)
>>
> 
> 
