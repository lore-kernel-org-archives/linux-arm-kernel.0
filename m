From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 12:15:32 +0000
Subject: [GIT PULL] at91 first cleanup series for 3.4
In-Reply-To: <4F4DF2AB.6060403@atmel.com>
References: <4F4674F2.8090603@atmel.com> <201202281218.39428.arnd@arndb.de>
 <4F4DF2AB.6060403@atmel.com>
Message-ID: <201202291215.32801.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Nicolas Ferre wrote:
> On 02/28/2012 01:18 PM, Arnd Bergmann :
> > On Tuesday 28 February 2012, Nicolas Ferre wrote:

> > Hmm I think I missed that part. My point was that we try to reduce the number
> > of instances of __raw_readl. These patches spread them to more places that
> > will require cleaning up later. I can see how you want to keep the two changes
> > (__raw_readl -> readl_relaxed and at91_sys_xxx -> at91_yyy_xxx) separate, but
> > it would be less churn to add one patch first that converts at91_sys_xxx
> > to use readl_relaxed and then spread that out than converting them all after
> > the fact.
> 
> Yes, indeed that would have been a good way to proceed but
> unfortunately, this at91_sys_xxx() removal action has begun a while ago
> (mainline patches that I can link to this action are from Sept. 2011).
> We did not have in mind this move from __raw_xxxx() to xxxx_relaxed() at
> that time. Jean-Christophe wanted and still want to finish this action
> before switching to those new functions and I agree with him.
> 
> We discussed together and decided to move to xxxx_relaxed() in the core
> AT91 for early 3.5 development cycle. There will be more to convert, but
> it will be safer at that time.

Ok, sounds good.

> > These can no longer get reordered when I do that, but any other branches are
> > still independent of these and can be arbitrarily moved around anywhere after
> > next/cleanup2.
> 
> Ok, I understand your point and all the implications. But the problem
> with at91/9x5 branch is that it is a product introduction and it is our
> responsibility to no leave it on the side. This material represents in
> fact a kind of "base" for our 3.4 development (second step "base" actually).
> 
> So if you can create this next/cleanup2, please do: it will help us a
> lot. I have created a rebased branch which only relies on
> at91/pm_cleanup and at91/9x5 here:
> 
> git://github.com/at91linux/linux-at91.git at91-3.4-for_cleanup2

Ok.

> (do you want me to send you another pull request?)

No, I'll just upgrade the staging branch into a proper one.

> > We can easily put the irqdomain tree into one of the next/* branches as a
> > dependency, which causes that particular branch to get delayed until Grant
> > has got his patches upstream. If you send me a series for next/boards that
> > depend on irqdomain, I would probably put that into a next/boards2 branch
> > or into a next/irqdomain branch in case I get similar things from multiple
> > people. If Grant's patches are already upstream by the time I get to send
> > out the next/boards branch to Linus, I would probably merge next/boards2
> > into next/boards and send all of it together.
> 
> Ok, we will be able to give you AT91 subsequent development based on
> both next/cleanup2 and the future next/irqdomain. So you can forget the
> other pull request I have sent some days ago:
> "[GIT PULL] at91: irqdomain and device tree for AIC and GPIO"
> I will rebase it once you will publish the two branches cited above.

Hmm, incidentally I had already forgotten about that one ;-)

FWIW, I think it's better not to pull the branches from arm-soc.git
back into your own tree, just base your future pull requests on the
branches that you sent me earlier. Otherwise we just get extra
merge commits into the history that don't add any information like you
have here:

11a25ea Merge remote-tracking branch 'armsoc/at91/9x5' into at91-3.4-base2
9acacb1 Merge remote-tracking branch 'armsoc/at91/device-board' into at91-3.4-base2
76e8057 Merge branch 'at91-3.4-base+9x5' of git://github.com/at91linux/linux-at91 into at91/9x5
018b5e1 Merge branch 'at91-3.4-base+pm_cleanup' of git://github.com/at91linux/linux-at91 into at91/pm_cleanup
92b0b63 Merge branch 'at91-3.4-base+device_board' of git://github.com/at91linux/linux-at91 into at91/device-board
6848523 Merge branch 'at91-3.4-base' of git://github.com/at91linux/linux-at91 into at91/base

The lower four merges may or may not make sense for the branch, but the
most recent two are rather pointless here.

	Arnd
