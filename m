From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Mar 2013 09:47:16 -0700
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <alpine.LFD.2.02.1303271209490.22263@ionos>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1303271209490.22263@ionos>
Message-ID: <20130327164716.4014.97638@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thomas Gleixner (2013-03-27 04:24:12)
> On Wed, 27 Mar 2013, Mike Turquette wrote:
> > +/***  locking & reentrancy ***/
> > +
> > +static void clk_fwk_lock(void)
> 
> This function name sucks as much as the whole implementation does.
> 
> > +{
> > +     /* hold the framework-wide lock, context == NULL */
> > +     mutex_lock(&prepare_lock);
> > +
> > +     /* set context for any reentrant calls */
> > +     atomic_set(&prepare_context, (int) get_current());
> 
> And what's the point of the atomic here? There is no need for an
> atomic if you hold the lock. Neither here nor on the reader side.
> 

I had wondered about that.  So the barriers in mutex_lock and
spin_lock_irqsave are sufficient such that the (unprotected) read-side
will always see the correct data?  That makes sense to me since accesses
to the clock tree are still serialized.

> Aside of that, the cast to (int) and the one below to (void *) are
> blantantly wrong on 64 bit.
> 

Since the atomic type is no longer required (based on the above
assumption) then this problem goes away.  Each context is just a global
pointer.

> > +}
> > +
> > +static void clk_fwk_unlock(void)
> > +{
> > +     /* clear the context */
> > +     atomic_set(&prepare_context, 0);
> > +
> > +     /* release the framework-wide lock, context == NULL */
> > +     mutex_unlock(&prepare_lock);
> > +}
> > +
> > +static bool clk_is_reentrant(void)
> > +{
> > +     if (mutex_is_locked(&prepare_lock))
> > +             if ((void *) atomic_read(&prepare_context) == get_current())
> 
> Mooo.

Woof?

> 
> > +                     return true;
> > +
> > +     return false;
> > +}
> 
> Why the heck do you need this function?
> 
> Just to sprinkle all these ugly constructs into the code:
> 
> > -     mutex_lock(&prepare_lock);
> > +     /* re-enter if call is from the same context */
> > +     if (clk_is_reentrant()) {
> > +             __clk_unprepare(clk);
> > +             return;
> > +     }
> 
> Sigh. Why not doing the obvious?
> 
> Step 1/2: Wrap locking in helper functions
> 
> +static void clk_prepare_lock(void)
> +{
> +       mutex_lock(&prepare_lock);
> +}
> +
> +static void clk_prepare_unlock(void)
> +{
> +       mutex_unlock(&prepare_lock);
> +}
> 
> That way the whole change in the existing code boils down to:
> 
> -       mutex_lock(&prepare_lock);
> +       clk_prepare_lock();
> ...
> -       mutex_unlock(&prepare_lock);
> +       clk_prepare_unlock();
> 
> Ditto for the spinlock.
> 
> And there is no pointless reshuffling of functions required.
> 
> 
> Step 2/2: Implement reentrancy
> 
> +static struct task_struct *prepare_owner;
> +static int prepare_refcnt;
> 
> static void clk_prepare_lock()
> {
> -       mutex_lock(&prepare_lock);
> +       if (!mutex_trylock(&prepare_lock)) {
> +               if (prepare_owner == current) {
> +                       prepare_refcnt++;
> +                       return;
> +               }
> +               mutex_lock(&prepare_lock);
> +       }
> +       WARN_ON_ONCE(prepare_owner != NULL);
> +       WARN_ON_ONCE(prepare_refcnt != 0);
> +       prepare_owner = current;
> +       prepare_refcnt = 1;
> }
> 
> static void clk_prepare_unlock(void)
> {
> -       mutex_unlock(&prepare_lock);
> +       WARN_ON_ONCE(prepare_owner != current);
> +       WARN_ON_ONCE(prepare_refcnt == 0);
> +
> +       if (--prepare_refcnt)
> +               return;
> +       prepare_owner = NULL;
> +       mutex_unlock(&prepare_lock);
> }
> 
> Ditto for the spinlock.
> 
> That step requires ZERO change to the functions. They simply work and
> you don't need all this ugly reentrancy hackery.
> 

Thanks for the review Thomas.  I will steal your code and call it my own
in the next version.  In particular getting rid of the atomics makes
things much nicer.

Regards,
Mike

> Thanks,
> 
>         tglx
