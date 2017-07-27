From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 27 Jul 2017 10:08:30 +0800
Subject: ARM64 board Hikey960 boot failure due to f2545b2d4ce1
 (jump_label: Reorder hotplug lock and jump_label_lock)
In-Reply-To: <7e5cfa7c-b7a0-12bc-dad6-4355f23b5f21@arm.com>
References: <20170724143417.GA12788@leoy-ThinkPad-T440>
 <7e5cfa7c-b7a0-12bc-dad6-4355f23b5f21@arm.com>
Message-ID: <20170727020830.GG2902@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 04:13:49PM +0100, Marc Zyngier wrote:
> [+Mark]
> 
> Hi Leo,
> 
> On 24/07/17 15:34, Leo Yan wrote:
> > Hi all,
> > 
> > We found the mainline arm64 kernel boot failure on Hikey960 board,
> > this is caused by patch f2545b2d4ce1 (jump_label: Reorder hotplug lock
> > and jump_label_lock), this patch adds locking cpus_read_lock() in
> > function static_key_slow_inc() and introduce the dead lock issue by
> > acquiring lock twice. Below are detailed flow:
> > 
> > arch_timer_register()
> >  `> cpuhp_setup_state()
> >      `> __cpuhp_setup_state()
> >         cpus_read_lock()
> >          `> __cpuhp_setup_state_cpuslocked()
> >              `> cpuhp_issue_call()
> >                  `> arch_timer_starting_cpu()
> >                      `> __arch_timer_setup()
> >                          `> arch_timer_check_ool_workaround()
> >                              `> arch_timer_enable_workaround()
> >                                  `> static_branch_enable()
> >                                      `> static_key_enable()
> >                                          `> static_key_slow_inc()
> >                                              `> cpus_read_lock()
> > 
> > So finally there have called cpus_read_lock() twice, and kernel report
> > log as below. So I am not sure what's the best way to fix this issue,
> > could you give some suggestion for this? Thanks.
> 
> [...]
> 
> Thanks for this. Unfortunately, there is no easy fix for this.
> Can you give the patch below a go and let us know if that solves
> the issue you observed? I only tested in on a model...
> 
> Should this be considered an acceptable solution, I'll split that
> into individual patches and repost it as a proper series.

Thanks, Marc.

I confirm below patch can fix the booting failure issue on Hikey960;
after generate formal patch set, also welcome to send me for testing.

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index aae87c4c546e..44232f378543 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -455,7 +455,11 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>  			per_cpu(timer_unstable_counter_workaround, i) = wa;
>  	}
>  
> -	static_branch_enable(&arch_timer_read_ool_enabled);
> +	/*
> +	 * Use the _locked version, as we're called from the CPU
> +	 * hotplug framework. Otherwise, we end-up in deadlock-land.
> +	 */
> +	static_branch_enable_locked(&arch_timer_read_ool_enabled);
>  
>  	/*
>  	 * Don't use the vdso fastpath if errata require using the
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 2afd74b9d844..5cfbf9ff3fe8 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -159,10 +159,14 @@ extern void arch_jump_label_transform_static(struct jump_entry *entry,
>  extern int jump_label_text_reserved(void *start, void *end);
>  extern void static_key_slow_inc(struct static_key *key);
>  extern void static_key_slow_dec(struct static_key *key);
> +extern void static_key_slow_inc_locked(struct static_key *key);
> +extern void static_key_slow_dec_locked(struct static_key *key);
>  extern void jump_label_apply_nops(struct module *mod);
>  extern int static_key_count(struct static_key *key);
>  extern void static_key_enable(struct static_key *key);
>  extern void static_key_disable(struct static_key *key);
> +extern void static_key_enable_locked(struct static_key *key);
> +extern void static_key_disable_locked(struct static_key *key);
>  
>  /*
>   * We should be using ATOMIC_INIT() for initializing .enabled, but
> @@ -213,12 +217,16 @@ static inline void static_key_slow_inc(struct static_key *key)
>  	atomic_inc(&key->enabled);
>  }
>  
> +#define static_key_slow_inc_locked(k)	static_key_slow_inc((k))
> +
>  static inline void static_key_slow_dec(struct static_key *key)
>  {
>  	STATIC_KEY_CHECK_USE();
>  	atomic_dec(&key->enabled);
>  }
>  
> +#define static_key_slow_dec_locked(k)	static_key_slow_inc((k))
> +
>  static inline int jump_label_text_reserved(void *start, void *end)
>  {
>  	return 0;
> @@ -415,6 +423,8 @@ extern bool ____wrong_branch_error(void);
>  
>  #define static_branch_enable(x)		static_key_enable(&(x)->key)
>  #define static_branch_disable(x)	static_key_disable(&(x)->key)
> +#define static_branch_enable_locked(x)	static_key_enable_locked(&(x)->key)
> +#define static_branch_disable_locked(x)	static_key_disable_locked(&(x)->key)
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d11c506a6ac3..f543f765a738 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -57,6 +57,11 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>  }
>  
>  static void jump_label_update(struct static_key *key);
> +static void static_key_slow_inc_with_lock(struct static_key *key, bool lock);
> +static void __static_key_slow_dec_with_lock(struct static_key *key,
> +					    bool lock,
> +					    unsigned long rate_limit,
> +					    struct delayed_work *work);
>  
>  /*
>   * There are similar definitions for the !HAVE_JUMP_LABEL case in jump_label.h.
> @@ -79,29 +84,53 @@ int static_key_count(struct static_key *key)
>  }
>  EXPORT_SYMBOL_GPL(static_key_count);
>  
> -void static_key_enable(struct static_key *key)
> +static void static_key_enable_with_lock(struct static_key *key, bool lock)
>  {
>  	int count = static_key_count(key);
>  
>  	WARN_ON_ONCE(count < 0 || count > 1);
>  
>  	if (!count)
> -		static_key_slow_inc(key);
> +		static_key_slow_inc_with_lock(key, lock);
> +}
> +
> +void static_key_enable(struct static_key *key)
> +{
> +	static_key_enable_with_lock(key, true);
>  }
>  EXPORT_SYMBOL_GPL(static_key_enable);
>  
> -void static_key_disable(struct static_key *key)
> +void static_key_enable_locked(struct static_key *key)
> +{
> +	lockdep_assert_cpus_held();
> +	static_key_enable_with_lock(key, false);
> +}
> +EXPORT_SYMBOL_GPL(static_key_enable_locked);
> +
> +static void static_key_disable_with_lock(struct static_key *key, bool lock)
>  {
>  	int count = static_key_count(key);
>  
>  	WARN_ON_ONCE(count < 0 || count > 1);
>  
>  	if (count)
> -		static_key_slow_dec(key);
> +		__static_key_slow_dec_with_lock(key, lock, 0, NULL);
> +}
> +
> +void static_key_disable(struct static_key *key)
> +{
> +	static_key_disable_with_lock(key, true);
>  }
>  EXPORT_SYMBOL_GPL(static_key_disable);
>  
> -void static_key_slow_inc(struct static_key *key)
> +void static_key_disable_locked(struct static_key *key)
> +{
> +	lockdep_assert_cpus_held();
> +	static_key_disable_with_lock(key, false);
> +}
> +EXPORT_SYMBOL_GPL(static_key_disable_locked);
> +
> +static void static_key_slow_inc_with_lock(struct static_key *key, bool lock)
>  {
>  	int v, v1;
>  
> @@ -125,7 +154,8 @@ void static_key_slow_inc(struct static_key *key)
>  			return;
>  	}
>  
> -	cpus_read_lock();
> +	if (lock)
> +		cpus_read_lock();
>  	jump_label_lock();
>  	if (atomic_read(&key->enabled) == 0) {
>  		atomic_set(&key->enabled, -1);
> @@ -135,14 +165,30 @@ void static_key_slow_inc(struct static_key *key)
>  		atomic_inc(&key->enabled);
>  	}
>  	jump_label_unlock();
> -	cpus_read_unlock();
> +	if (lock)
> +		cpus_read_unlock();
> +}
> +
> +void static_key_slow_inc(struct static_key *key)
> +{
> +	static_key_slow_inc_with_lock(key, true);
>  }
>  EXPORT_SYMBOL_GPL(static_key_slow_inc);
>  
> -static void __static_key_slow_dec(struct static_key *key,
> -		unsigned long rate_limit, struct delayed_work *work)
> +void static_key_slow_inc_locked(struct static_key *key)
>  {
> -	cpus_read_lock();
> +	lockdep_assert_cpus_held();
> +	static_key_slow_inc_with_lock(key, false);
> +}
> +EXPORT_SYMBOL_GPL(static_key_slow_inc_locked);
> +
> +static void __static_key_slow_dec_with_lock(struct static_key *key,
> +					    bool lock,
> +					    unsigned long rate_limit,
> +					    struct delayed_work *work)
> +{
> +	if (lock)
> +		cpus_read_lock();
>  	/*
>  	 * The negative count check is valid even when a negative
>  	 * key->enabled is in use by static_key_slow_inc(); a
> @@ -153,7 +199,8 @@ static void __static_key_slow_dec(struct static_key *key,
>  	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
>  		WARN(atomic_read(&key->enabled) < 0,
>  		     "jump label: negative count!\n");
> -		cpus_read_unlock();
> +		if (lock)
> +			cpus_read_unlock();
>  		return;
>  	}
>  
> @@ -164,27 +211,36 @@ static void __static_key_slow_dec(struct static_key *key,
>  		jump_label_update(key);
>  	}
>  	jump_label_unlock();
> -	cpus_read_unlock();
> +	if (lock)
> +		cpus_read_unlock();
>  }
>  
>  static void jump_label_update_timeout(struct work_struct *work)
>  {
>  	struct static_key_deferred *key =
>  		container_of(work, struct static_key_deferred, work.work);
> -	__static_key_slow_dec(&key->key, 0, NULL);
> +	__static_key_slow_dec_with_lock(&key->key, true, 0, NULL);
>  }
>  
>  void static_key_slow_dec(struct static_key *key)
>  {
>  	STATIC_KEY_CHECK_USE();
> -	__static_key_slow_dec(key, 0, NULL);
> +	__static_key_slow_dec_with_lock(key, true, 0, NULL);
>  }
>  EXPORT_SYMBOL_GPL(static_key_slow_dec);
>  
> +void static_key_slow_dec_locked(struct static_key *key)
> +{
> +	lockdep_assert_cpus_held();
> +	STATIC_KEY_CHECK_USE();
> +	__static_key_slow_dec_with_lock(key, false, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(static_key_slow_dec_locked);
> +
>  void static_key_slow_dec_deferred(struct static_key_deferred *key)
>  {
>  	STATIC_KEY_CHECK_USE();
> -	__static_key_slow_dec(&key->key, key->timeout, &key->work);
> +	__static_key_slow_dec_with_lock(&key->key, true, key->timeout, &key->work);
>  }
>  EXPORT_SYMBOL_GPL(static_key_slow_dec_deferred);
>  
> 
> -- 
> Jazz is not dead. It just smells funny...
