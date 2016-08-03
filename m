From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 3 Aug 2016 10:39:03 +0200
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <20160803082855.GA32280@kroah.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803081140.GA7833@gmail.com>
 <20160803082855.GA32280@kroah.com>
Message-ID: <20160803083902.GA3643@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Aug 03, 2016 at 10:11:40AM +0200, Ingo Molnar wrote:
> > An added advantage would be that during review it would stick out like a sore 
> > thumb if anyone used a 'weird' permission variant.
> > 
> > For example, if you saw these lines in a driver patch:
> > 
> > +	__ATTR(l1, 0444, driver_show_l4, NULL);
> > +		__ATTR(l3, 0446, driver_show_l4, NULL);
> > +			__ATTR(l2, 04444, driver_show_l4, NULL);
> > +		__ATTR(l4, 0444, driver_show_l4, NULL);
> > 
> > ... would you notice it at a glance that it contains two security holes?
> 
> I've tried to deal with that in the past with the __ATTR_RW() and
> __ATTR_RO() and __ATTR_WO() macros that more should be using.  I swept
> the tree a few years ago to try to fix up most of them, but I know I
> didn't catch them all, and more files have been added since then.
> 
> > While the weird permissions in this:
> > 
> > +		__ATTR(l1, PERM_r__r__r__,  driver_show_l4, NULL);
> > +		__ATTR(l3, PERM_r__r__rw_,  driver_show_l4, NULL);
> > +		__ATTR(l2, PERM_sr__r__r__, driver_show_l4, NULL);
> > +		__ATTR(l4, PERM_r__r__r__,  driver_show_l4, NULL);
> > 
> > Wouln't even build, because the dangerous patterns of PERM_r__r__rw_ or 
> > PERM_sr__r__r__ are not defined to begin with.
> 
> Because of that, odds are people will just stick to the octal numbers,
> because they think they want something other than the ones you defined
> for foolish reasons :)

For code I maintain I'd insist on contributors using the human readable versions, 
because in the past I've mixed up octals (and the symbolic helpers we have today) 
myself and I find the 'ls -l' format much easier to read because that's the 
primary file permission format I see every day working on code.

> That being said, I do like them much better than the macros we have today, which 
> I always have to go and look up every time I see them...

Same here!

I'm sure core VFS developers know all of the octals and the helpers by heart, but 
the set of maintainers accepting debugfs and sysfs file permission patches is much 
wider than that, so every little bit of clarity helps.

Thanks,

	Ingo
