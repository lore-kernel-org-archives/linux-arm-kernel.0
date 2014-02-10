From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Feb 2014 13:48:57 -0500
Subject: [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the
 system-controller driver
In-Reply-To: <20140210184726.2a787050@skate>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173957.GS8533@titan.lakedaemon.net>
 <20140210184726.2a787050@skate>
Message-ID: <20140210184857.GT8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:47:26PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Mon, 10 Feb 2014 12:39:57 -0500, Jason Cooper wrote:
> 
> > > Note that we intentionally do not use the same compatible string as
> > > Armada 370/XP, as the current system-controller driver is far from
> > > exploiting all the possibilities of the hardware, and we may in the
> > > future discover differences between Armada 370/XP and Armada 380/385.
> > 
> > I'd much prefer to add a new compatible string iff it accompanies
> > incompatible changes.
> > 
> > For now, I think it's best to use 'marvell,armada-370-xp-system-controller'
> > in the dtsi file and change it when you introduce the incompatible
> > features.
> 
> This doesn't work really well: if an user keeps an old DTB around,
> which uses the old compatible string, then you're screwed because
> there's no way a new kernel version can make the distinction between
> Armada 370/XP and Armada 380/385. 

devicetree is designed to handle this.  The dtb is _supposed_ to be
separate from the kernel.

> If we discover than Armada 380/385 need a special quirk to really work
> reliably for example, but that this quirk doesn't apply to Armada
> 370/XP, then you have a serious problem.

No, you don't.  It's the responsibility of the driver author to _not_
make incompatible changes and to sanely fall back to default behavior.

Right now there are no differences, and both SoCs work with the same
compatible string.  If later there is support added for a feature for
one of them, we add a compatible string to differentiate the two.  When
the driver encounters a potentially old dtb, it defaults to behaving as
it does today.  iow, no new feature.

In this situation, the driver or SoC code could see the root compatible
node is marvell,armada385 with a sys-con node using
marvell,armada-370-xp-sys-con.  It could then print a warning about
potentially old dtb.  Depending on the severity of the bug (which
couldn't be too severe, otherwise you'd have code here today ;) ), you
could even override the compatible string in the SoC code.

> Therefore, I would like to really insist to have separate compatible
> strings for different SOCs. As an example, we used to have the same
> compatible string for the timer between Armada 370 and Armada XP, and
> later discovered that it was not possible due to a bug affecting only
> one of the two SOCs. Our experience clearly shows that sharing
> compatible strings is a bad idea, and having separate compatible
> strings from the beginning doesn't cost anything, and offers higher
> flexibility for the future.

Your argument is tempting, but I see a lot of over-quantization with
little to no measurable gain other than "just in case."

If I follow your logic and refer to the i2c transaction generator
problem, should we go back and add compatible strings for all on-die IP
blocks for every SoC and SoC revision?  Even though we only wish we had
something once?  Can we anticipate every possible way an IP block will
be broken?

Ultimately, what I'm saying is that the devicetree process should be
able to handle this kind of situation.  And if it can't, the process is
broken.  No amount of bubblewrap and safety helmets will save us then.

Now, wrt marvell,armada-38x-system-controller, if you can point out
specific features you know about *today* that are different from the
370/xp sys-con, please spell them out at least in the commit log.  I'm
fine with just mentioning the features at this point, since we're
dealing with initial SoC support.  But "...we may in the future discover
differences between..." doesn't inspire confidence.

thx,

Jason.
