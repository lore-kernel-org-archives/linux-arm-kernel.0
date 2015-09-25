From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 Sep 2015 11:47:41 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1443202945.2161.8.camel@sipsolutions.net>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1443202945.2161.8.camel@sipsolutions.net>
Message-ID: <20150925184741.GF5951@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-09-15, 19:42, Johannes Berg wrote:
> On Fri, 2015-09-25 at 09:41 -0700, Viresh Kumar wrote:
> 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V3->V4:
> > - Create a local variable instead of changing type of global_lock
> >   (Rafael)
> 
> Err, surely that wasn't what Rafael meant, since it's clearly
> impossible to use a pointer to the stack, assign to it once, and the
> expect anything to wkr at all ...

Sorry, I am not sure on what wouldn't work with this patch but this is
what Rafael said, and I don't think I wrote it differently :)

Rafael wrote:
> Actually, what about adding a local u32 variable, say val, here and doing
> 
> >  	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
> >  		goto error;
> >  	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
> > -				 (u32 *)&first_ec->global_lock))
> > +				 &first_ec->global_lock))
> 
> 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir, &val))
> 
> >  		goto error;
> 
> 	first_ec->global_lock = val;
> 
> And then you can turn val into bool just fine without changing the structure
> definition.

-- 
viresh
