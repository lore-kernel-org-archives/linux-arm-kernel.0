From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Mar 2013 20:00:38 -0700
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <20130327225610.GR4977@n2100.arm.linux.org.uk>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <20130327225610.GR4977@n2100.arm.linux.org.uk>
Message-ID: <20130328030038.5161.14912@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2013-03-27 15:56:10)
> On Wed, Mar 27, 2013 at 12:09:43AM -0700, Mike Turquette wrote:
> > +     /* set context for any reentrant calls */
> > +     atomic_set(&prepare_context, (int) get_current());
> ...
> > +     if (mutex_is_locked(&prepare_lock))
> > +             if ((void *) atomic_read(&prepare_context) == get_current())
> > +                     return true;
> 
> If you really want to do it like this, then the _correct_ way to do it
> is:
> 
>                 if (atomic_read(&prepare_context) == (int)get_current())
> 
> So that any effects from the cast are the same in both parts.  Otherwise,
> you will be running into the possibility that a cast could do something
> like truncate the returned value, resulting in the test condition using
> pointers always being false.
> 
> It's not that much of a problem on ARM, but it's a matter of good
> programming discpline that such issues are avoided.
> 
> Even better would be to cast it to unsigned long - this is the value
> which the atomic types use, and that is less likely to be truncated.
> It also helps to avoid the possibility of compilers complaining about
> a narrowing cast too - especially as the entire Linux kernel assumes
> that pointers can be cast to unsigned long and back again with no loss.

The atomics and casts will go away in the next version but the insights
are useful.  Thanks for the review.

Regards,
Mike
