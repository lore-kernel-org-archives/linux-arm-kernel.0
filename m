From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 7 Mar 2018 11:27:37 +0800
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180305130859.GB17802@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com> <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
Message-ID: <1cd025d0-b456-f7bf-e282-d076eb530fac@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> But really, I don't see this need as all ARM devices that I know of that
>>> are stuck on 4.9.y are already using the android-common tree.  Same for
>>> 4.4.y.  Do you know of any that are not, and that can not just use
>>> 4.14.y instead?
>>
>> There's way more to ARM than just Android systems, assuming that getting
>> things into the Android kernel is enough is like assuming that x86 is
>> covered since the distros have their own backports - it covers a lot of
>> users but not everyone.  Off the top of my head there's things like
>> routers, NASs, cameras, IoT, radio systems, industrial appliances, set
>> top boxes and these days even servers.  Most of these segments are just
>> as conservative about taking new kernel versions on shipping product as
>> the phone vendors are, the practices that make people relucant to take
>> bigger updates in production are general engineering practices common
>> across industry.
> 
> I know there is lots more than Android to ARM, but the huge majority by
> quantity is Android.
> 
> What I'm saying here is look at all of the backports that were required
> to get this working in the android tree.  It was non-trivial by a long
> shot, and based on that work, this series feels really "small" and I'm
> really worried that it's not really working or solving the problem here.>
> There are major features that were backported to the android trees for
> ARM that the upstream features for Spectre and Meltdown built on top of
> to get their solution.  To not backport all of that is a huge risk,
> right?

Thanks for response!

Yes, that is problem I concern, current android is far from enough to
protect it self form these two bugs. There are lots of fix missed. like
the main fix patch from upstream isn't included:
 arm64: Add skeleton to harden the branch predictor against aliasing attacks
    commit 0f15adbb2861 upstream.

BTW, The concept of 2 bugs mitigation is relatively simple, and current
backporting include everything that arm did to mitigate them.

> 
> So that's why I keep pointing people at the android trees.  Look at what
> they did there.  There's nothing stoping anyone who is really insistant
> on staying on these old kernel versions from pulling from those branches
> to get these bugfixes in a known stable, and tested, implementation.
> That's why I point people there[1].  To do all of the backporting and
> add the new features feels _way_ beyond what I should be taking into the
> stable kernels.  We didn't do it for x86, why should we do it for ARM?

Thanks for your effort! That's the reason, LTS need spectre/meltdown fix
on ARM, people like to keep using them system with a simple
kernel/fireware update, instead of whole system update with whole system
retesting.

> 
> Yes, we did a horrid hack for the x86 backports (with the known issues
> that it has, and people seem to keep ignoring, which is crazy), and I
> would suggest NOT doing that same type of hack for ARM, but go grab a
> tree that we all know to work correctly if you are suck with these old
> kernels!

We know things aren't perfect in urgency fix, that's a reason for x86
story. but for arm side, arm had 3 versions fix, and do update 2 times
on them website, we did 2 times backport too for their fix. Obviously
arm get more time and take more lesson from x86 story for their fix.

> 
> Or just move to 4.14.y.  Seriously, that's probably the safest thing in
> the long run for anyone here.  And when you realize you can't do that,
> go yell at your SoC for forcing you into the nightmare that they conned
> you into by their 3+ million lines added to their kernel tree.  You were
> always living on borowed time, and it looks like that time is finally
> up...

yes, that's true. But compare to x86 market, backport to old stable
kernel would save much time for arm vendors and free them to more
new/upstream work instead.

> 
> thanks,
> 
> greg k-h
> 
> [1] It's also why I keep doing the LTS merges into the android-common
>     trees within days of the upstream LTS release (today being an
>     exception).  That way once you do a pull/merge, you can just keep
>     always merging to keep a secure device that is always up to date
>     with the latest LTS releases in a simple way.  How much easier can I
>     make it for the ARM ecosystem here, really?
> 
>     Oh, I know, get the SoC vendors to merge from the android-common
>     trees into their trees.  Look, that's already happening today for at
>     least 3 major SoCs!  So just go pull the update from your SoC today,
>     for your chip, and it automatically has all of these fixes in it
>     already!  If you know a SoC that is not pulling these updates
>     regularly, let me know and I'll work with them to resolve that[2].
> 
> [2] I have offered to do that merge myself, from the android-common
>     trees into any "internal" tree, so that future merges happen cleanly
>     and automatically, for any company that asks for it.  So far only
>     one company has taken me up on it, and it only took me a week to get
>     it all up and working properly.  It took a ton of "fun" quilt and
>     git work, but in the end, it all worked, and has worked cleanly
>     since then, showing it can be done.
> 
