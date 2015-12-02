From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 02 Dec 2015 09:04:09 +0000
Subject: [BISECTED] rcu_sched self-detected stall since 3.17
In-Reply-To: <20151201130404.GL3816@twins.programming.kicks-ass.net>
References: <564F3DCA.1080907@arm.com>
 <20151201130404.GL3816@twins.programming.kicks-ass.net>
Message-ID: <565EB409.3090202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 13:04, Peter Zijlstra wrote:
> Sorry for the delay and thanks for the reminder!
> 
> On Fri, Nov 20, 2015 at 03:35:38PM +0000, Vladimir Murzin wrote:
>> commit 743162013d40ca612b4cb53d3a200dff2d9ab26e
>> Author: NeilBrown <neilb@suse.de>
>> Date:   Mon Jul 7 15:16:04 2014 +1000
>>
>>     sched: Remove proliferation of wait_on_bit() action functions
>>
>> The only change I noticed is from (mm/filemap.c)
>>
>> 	io_schedule();
>> 	fatal_signal_pending(current)
>>
>> to (kernel/sched/wait.c)
>>
>> 	signal_pending_state(current->state, current)
>> 	io_schedule();
>>
>> and if I apply following diff I don't see stalls anymore.
>>
>> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
>> index a104879..2d68cdb 100644
>> --- a/kernel/sched/wait.c
>> +++ b/kernel/sched/wait.c
>> @@ -514,9 +514,10 @@ EXPORT_SYMBOL(bit_wait);
>>
>>  __sched int bit_wait_io(void *word)
>>  {
>> +       io_schedule();
>> +
>>         if (signal_pending_state(current->state, current))
>>                 return 1;
>> -       io_schedule();
>>         return 0;
>>  }
>>  EXPORT_SYMBOL(bit_wait_io);
>>
>> Any ideas why it might happen and why diff above helps?
> 
> Yes, the code as presented is simply wrong. And in fact most of the code
> it replaced was of the right form (with a few exceptions which would
> indeed have been subject to the same problem you've observed.
> 
> Note how the late:
> 
>   - cifs_sb_tcon_pending_wait
>   - fscache_wait_bit_interruptible
>   - sleep_on_page_killable
>   - wait_inquiry
>   - key_wait_bit_intr
> 
> All check the signal state _after_ calling schedule().
> 
> As opposed to:
> 
>   - gfs2_journalid_wait
> 
> which follows the broken pattern.
> 
> Further notice that most expect a return of -EINTR, which also seems
> correct given that this is a signal, those that do not return -EINTR
> only check for a !0 return value so would work equally well with -EINTR.
> 
> The reason this is broken is that schedule() will no-op when there is a
> pending signal, while raising a signal will also issue a wakeup.
> 

Glad to hear confirmation on a problem. Thanks for detailed answer!

> Thus the right thing to do is check for the signal state after, that way
> you handle both cases:
> 
>  - calling schedule() with a signal pending
>  - receiving a signal while sleeping
> 
> As such, I would propose the below patch. Oleg, do you concur?
> 
> ---
> Subject: sched,wait: Fix signal handling in bit wait helpers
> 
> Vladimir reported getting RCU stall warnings and bisected it back to
> commit 743162013d40. That commit inadvertently reversed the calls to
> schedule() and signal_pending(), thereby not handling the case where the
> signal receives while we sleep.
> 
> Fixes: 743162013d40 ("sched: Remove proliferation of wait_on_bit() action functions")
> Fixes: cbbce8220949 ("SCHED: add some "wait..on_bit...timeout()" interfaces.")
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/wait.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 052e02672d12..f10bd873e684 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -583,18 +583,18 @@ EXPORT_SYMBOL(wake_up_atomic_t);
>  
>  __sched int bit_wait(struct wait_bit_key *word)
>  {
> -	if (signal_pending_state(current->state, current))
> -		return 1;
>  	schedule();
> +	if (signal_pending(current))
> +		return -EINTR;
>  	return 0;
>  }
>  EXPORT_SYMBOL(bit_wait);
>  
>  __sched int bit_wait_io(struct wait_bit_key *word)
>  {
> -	if (signal_pending_state(current->state, current))
> -		return 1;
>  	io_schedule();
> +	if (signal_pending(current))
> +		return -EINTR;
>  	return 0;
>  }
>  EXPORT_SYMBOL(bit_wait_io);
> @@ -602,11 +602,11 @@ EXPORT_SYMBOL(bit_wait_io);
>  __sched int bit_wait_timeout(struct wait_bit_key *word)
>  {
>  	unsigned long now = READ_ONCE(jiffies);
> -	if (signal_pending_state(current->state, current))
> -		return 1;
>  	if (time_after_eq(now, word->timeout))
>  		return -EAGAIN;
>  	schedule_timeout(word->timeout - now);
> +	if (signal_pending(current))
> +		return -EINTR;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bit_wait_timeout);
> @@ -614,11 +614,11 @@ EXPORT_SYMBOL_GPL(bit_wait_timeout);
>  __sched int bit_wait_io_timeout(struct wait_bit_key *word)
>  {
>  	unsigned long now = READ_ONCE(jiffies);
> -	if (signal_pending_state(current->state, current))
> -		return 1;
>  	if (time_after_eq(now, word->timeout))
>  		return -EAGAIN;
>  	io_schedule_timeout(word->timeout - now);
> +	if (signal_pending(current))
> +		return -EINTR;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bit_wait_io_timeout);
> 

I run it overnight on top of 4.3 and didn't see stalls. So in case it helps

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
