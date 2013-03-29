From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Mar 2013 23:18:14 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <CAOesGMj5yN_-Xvks=tYqYw1M1mre-uKQFCTXOe_gPE=abqF_GA@mail.gmail.com>
References: <20130307144506.GB7344@amd.pavel.ucw.cz>
 <5138FDAE.8060202@wwwdotorg.org>
 <20130311050546.GA21863@quad.lixom.net>
 <CACxGe6vkC7fjzf1-+K8O81+w=jQ63PvuTEhSPyitEBA9XiKYnw@mail.gmail.com>
 <20130328092916.GA11187@amd.pavel.ucw.cz>
 <51545870.4010209@wwwdotorg.org>
 <20130328193323.GA25166@amd.pavel.ucw.cz>
 <20130328195456.GA22527@quad.lixom.net>
 <5155C9C6.4070702@wwwdotorg.org>
 <CAOesGMj5yN_-Xvks=tYqYw1M1mre-uKQFCTXOe_gPE=abqF_GA@mail.gmail.com>
Message-ID: <20130329221814.GA6606@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> This takes care of the "make dtbs" case (or just "make" case), but not
> >> when you build a specific target.
> >
> > I guess to really solve this, we need the following changes:
> >
> > In the all kernels:
> >
> > For both arch/*/boot and arch/*/boot/dts: clean removes *.dtb
> >
> > In kernels that build *.dtb in the new location:
> >
> > make dtbs and make foo.dtb both rm ../*.dtb
> 
> I don't think this is useful. If you're building a specific dtb
> target, there should be no expectation that other dtb files should
> automatically be removed.

So... how do the scripts find that script location changed?

You do make foo.dtb.

There's nice foo.dtb waiting in arch/arm/boot/, only that it is
outdated. You use it, and it does not work.

> The original complaint was that make clean didn't remove the old dtb
> files. That's been resolved with the provided patch.

No, original complaint was that it is very very easy to use stale
files. "make clean" not removing them is just a part of problem.

> > In kernels that build *.dtb in the old location:
> >
> > make dtbs and make foo.dtb both rm dts/*.dtb
> >
> > Is that too much to retrofit into all the stable kernels?
> 
> I also don't think this is worth the effort. If you're going to check
> out old and new kernels in the same tree, you should probably get into
> the habit of using git clean.

Since when? make is expected to handle build dependencies. If you are
doing git bisect, make clean is going to slow you down, escpecially at
the end of cycle.

> Perhaps we need a "dtb_install" target instead, so people stop copying
> from the source directories.

dtb_install would be nice. But it will not help with current
problem...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
