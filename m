From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 22 Apr 2011 18:21:26 -0700
Subject: Common clock and dvfs
In-Reply-To: <alpine.LFD.2.02.1104222039330.3323@ionos>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<alpine.LFD.2.02.1104222039330.3323@ionos>
Message-ID: <4DB22996.8020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2011 12:37 PM, Thomas Gleixner wrote:
> On Fri, 22 Apr 2011, Colin Cross wrote:
>
>> Is the clock api the right place to do dvfs, or should the clock api
>> be kept simple, and more complicated operations like dvfs be kept
>> outside?
>
> I think it's an orthogonal issue which can be solved once we have
> generic implementations in place for clk_ functions which result in
> DFVS relevant changes.
>
> clk_prepare()
> {
> 	lock_tree();
> 	if (dvfs_validate())
> 		return -ECRAP;
> 	prepare();
> 	unlock_tree();
> }
>
> clk_unprepare()
> {
> 	lock_tree();
> 	unprepare();
> 	dvfs_recalc();
> 	unlock_tree();
> }
>
> clk_set_rate()
> {
> 	lock_tree();
>
> 	if (rate>  clk->rate&&  dvfs_prevalidate(rate))
> 		return -ECRAP;
>
> 	set_and_propagate_rate();
>
> 	if (rate<  old->rate)
> 	   dvfs_recalc();
>
> 	unlock_tree();
> }

I understand that this is just some example code, but I'm not sure how 
accurate you were trying to be. So, I will assume the worst.

I really don't like this lock the whole clock tree approach for DVFS. I 
think a better approach would be something like this:

struct dvfs_tuple {
	long	max_rate; /* Max rate for this DVFS level. */
	int	dvfs_level;
};

/* Yeah, bad name. pick what you like. */
struct dvfs_class {
	int 	*level_cnt;
	int 	num_levels;
	int (*dvfs_update) (int level);
	mutex	lock;
}

stuct clk {
	...
	/* Last entry would have {LONG_MAX, highest level in dvfs}, */
	struct	dvfs_tuple *dvfs_list;
	struct  dvfs_class *dvfs_class;
}

Then

clk_prepare() {
	for each dvfs tuple {
		if current_rate <= max_rate; {
			level = dvfs_level;
			break;
		}
	}

	lock(dvfs_class->mutex);

	clk->dvfs_class->level_cnt[level]++;
	/* Find highest level in this dvfs class with non-zero count */
	if(clk->dvfs_class->update(highest_level))
		return -ECRAP;
	/* Yes, I see locking err, but you get the point */
	unlock(dvfs_class->mutex);
	
	clk->ops->prepare(clk);
}

I did some crappy factorization of functions, returning -ECRAP without 
unlocking, etc, but you get the point.

Whether the "level" translates to controlling power supply A or B or A & 
B is upto the implementation of dvfs_class->dvfs_update() which is per 
SOC/mach/arch.

This will keep the dvfs data structure common for all clocks, remove the 
need to traverse the entire tree and keep the generic code agnostic of 
1-1 vs. many-1 vs many-many.

> We can put the dvfs functions into the propagation code as well and
> back out there when dvfs tells us. That probably works nicely for
> prepare and unprepare, but might be complex for set_rate in the actual
> set_rate propagation (except when the rate is less than the original
> one).

For set rate, you lock the dvfs class, increment the count for the new 
rate's dvfs_level, decrement it for the previous dvfs level, and then 
call dvfs_update() with the max level in that class, unlock dvfs_class.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
