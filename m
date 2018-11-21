From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 21 Nov 2018 14:34:08 -0800
Subject: [PATCHv3 1/6] atomics: add common header generation files
In-Reply-To: <20181116025112.xhbfei677awm77ji@blommer>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20180904104830.2975-2-mark.rutland@arm.com>
 <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
 <20181116025112.xhbfei677awm77ji@blommer>
Message-ID: <20181121143408.b91c15aff4206a162f9650f6@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 02:51:21 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Andrew,
> 
> On Thu, Nov 15, 2018 at 03:10:48PM -0800, Andrew Morton wrote:
> > On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > To minimize repetition, to allow for future rework, and to ensure
> > > regularity of the various atomic APIs, we'd like to automatically
> > > generate (the bulk of) a number of headers related to atomics.
> > > 
> > > This patch adds the infrastructure to do so, leaving actual conversion
> > > of headers to subsequent patches.
> > 
> > This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
> > takes 8 seconds on a machine which builds an allnoconfig kernel in 30
> > seconds.
> 
> Hmm... on my laptop it's less than half that, and allnoconfig takes ~35s, so
> clearly there's a major difference between our setups.

check-atomics.sh is (was) single-threaded, so the relative pain factor
will increase with the number of cores.

> For reference, which distro are you using, and what is /bin/sh on your box?

I forget :) - I can't get at that machine from here.  Recentish
Ubuntu(ish) on a 12-core.

It seems to be partially fixed in today's linux-next?  On this 12-core
Ubuntu 17.10 bash-4.4-5ubuntu1 box the delta is 25.9s -> 27.2s.

But my one-liner remains cruelly unapplied so the build still generates
errors.  All that seems to have changed today is that the -EPERM is simply
dropped on the floor rather than terminating the build.
