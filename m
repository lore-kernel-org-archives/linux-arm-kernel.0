From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 14:11:54 -0800
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <20131125185925.GC2293@e103592.cambridge.arm.com>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
 <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
 <alpine.LFD.2.10.1311251259400.9667@knanqh.ubzr>
 <CAOesGMgVud7hX-wDtywt9_gkCDcuCgyXbm+CQG1kxjfCthLK2w@mail.gmail.com>
 <20131125185925.GC2293@e103592.cambridge.arm.com>
Message-ID: <20131125221154.GB18001@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 06:59:25PM +0000, Dave P Martin wrote:
> On Mon, Nov 25, 2013 at 06:26:46PM +0000, Olof Johansson wrote:
> > On Mon, Nov 25, 2013 at 10:02 AM, Nicolas Pitre
> > <nicolas.pitre@linaro.org> wrote:
> > > On Mon, 25 Nov 2013, Olof Johansson wrote:
> > >
> > >> Hi,
> > >>
> > >> > Since v3.13-rc1, mcpm backends must implement an additional method which
> > >> > the vexpress TC2 implementation doesn't have upstream, resulting in an
> > >> > ugly WARN_ON() during hotplug and kexec operations
> > >>
> > >> Please be more specific here. Which change in the 3.13 merge window caused this?
> > >
> > > Commit 0de0d6467525.
> > >
> > > The corresponding change to tc2-pm.c was initially posted at about the
> > > same time i.e. before the merge window, but it somehow fell into a
> > > crack.
> > 
> > Thanks, I'll add that reference to the patch description when I apply.
> 
> The issue here was that the two patches were developed together and to
> some extent validate each other, but one is an arch change and the other
> is not.  Expecting Russell to accept random board changes through his
> tree seemed a bit cheeky at this point, but I was slow sorting this out
> before the merge window opened.
>
> Is there a good way to accelerate synchronisation of dependent patches
> that must be merged through different trees?  It seemed most reliable to
> wait for the mcpm patch to appear in Russell's public tree before posting
> the dependent TC2 patch for merging -- the intent was to avoid grief for
> maintainers, but this can backfire by causing delays.

I think it might be easier to work on git branches in those cases, since it's
easy for us to share a pull request from you guys (and we'd do the vexpress
piece on top). Without that it becomes more work for Russell to apply the patch
on a stable branch himself, us finding out what the branch is, etc.

> If you can handle patches with a dependency that is in-flight via another
> maintainer, then I'm happy to send such patches earlier in future, before
> the dependency lands (with details about where to watch for it,
> obviously).

I think doing a shared branch is by far the easiest way to do this. We want to
avoid pulling in someone elses "main" development branch and keep shared code
to a minimum, since it reduces the merge order dependencies upstream (not
technical merge order, but to avoid us merging the feature from the other
tree).

> > Looks like the MCPM-side patch was posted already back in Oct 1. I'm
> > not going to flame anyone over this, but it'd be nice if we could find
> > out about these things sooner, ideally when breakage hits -next. Dave,
> > next time I think I'd prefer to hear about it even if it is during the
> > merge window. :-)
> 
> OK, noted.  Different people's opinions differ on that sometimes, but
> I'll make sure you get the heads-up if a similar situation arises in
> the future.

Sure. I think a heads up is always OK, btw -- it's just that some maintainers
might choose not to act on it during the merge window.

> > Anyway, obviously it's needed and I'll apply it.
> 
> Thanks.  The kernel "works" without it in practice, though theoretically
> it's not 100% safe, and I want to set the right example.
> 
> I'll try harder to avoid this kind of huccup another time.

No worries. MCPM+TC2 is hairy since half of it turns out to be core code, half
board code.


-Olof
