From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 20:03:48 +0100
Subject: [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the
 system-controller driver
In-Reply-To: <20140210184857.GT8533@titan.lakedaemon.net>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173957.GS8533@titan.lakedaemon.net>
 <20140210184726.2a787050@skate>
 <20140210184857.GT8533@titan.lakedaemon.net>
Message-ID: <20140210200348.26b48bdf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 10 Feb 2014 13:48:57 -0500, Jason Cooper wrote:

> > This doesn't work really well: if an user keeps an old DTB around,
> > which uses the old compatible string, then you're screwed because
> > there's no way a new kernel version can make the distinction between
> > Armada 370/XP and Armada 380/385. 
> 
> devicetree is designed to handle this.  The dtb is _supposed_ to be
> separate from the kernel.

Exactly. Which is the whole point why your strategy doesn't work. Since
the DTB is supposed to be separate from the kernel, we have no
guarantee that the user will update the DTB when updating the kernel.
Therefore, we have to keep compatibility for old DTBs, which forces us
to be extra cautious when choosing compatible strings.

> > If we discover than Armada 380/385 need a special quirk to really work
> > reliably for example, but that this quirk doesn't apply to Armada
> > 370/XP, then you have a serious problem.
> 
> No, you don't.  It's the responsibility of the driver author to _not_
> make incompatible changes and to sanely fall back to default behavior.

This is not always possible. If we discover that the 38x system
controller has a bug that needs to be worked around in a way that isn't
suitable for Armada 370/XP, then there is *no* way for the driver
author to keep backward compatibility.

> Right now there are no differences, and both SoCs work with the same
> compatible string.  If later there is support added for a feature for
> one of them, we add a compatible string to differentiate the two.  When
> the driver encounters a potentially old dtb, it defaults to behaving as
> it does today.  iow, no new feature.

This only works if you *add* new features. Not if you have to get back
to existing features and make changes that have to be different between
the SOCs to fix bugs for existing features.

> In this situation, the driver or SoC code could see the root compatible
> node is marvell,armada385 with a sys-con node using
> marvell,armada-370-xp-sys-con.  It could then print a warning about
> potentially old dtb.  Depending on the severity of the bug (which
> couldn't be too severe, otherwise you'd have code here today ;) ), you
> could even override the compatible string in the SoC code.

This seems overly complicated compared to the simple usage of different
compatible strings per-SoC.

At least, I'd like your policy to be baked by statements from the DT
maintainers because I am not sure this policy is universally accepted.

> > Therefore, I would like to really insist to have separate compatible
> > strings for different SOCs. As an example, we used to have the same
> > compatible string for the timer between Armada 370 and Armada XP, and
> > later discovered that it was not possible due to a bug affecting only
> > one of the two SOCs. Our experience clearly shows that sharing
> > compatible strings is a bad idea, and having separate compatible
> > strings from the beginning doesn't cost anything, and offers higher
> > flexibility for the future.
> 
> Your argument is tempting, but I see a lot of over-quantization with
> little to no measurable gain other than "just in case."

Did you see the very real example of "just in case" I described in the
paragraph just above, with the Armada 370/XP timer? This "just in case"
lead us to break compatibility with old DTs, and have a broken kernel
until -rc4 or -rc5, due to issues in merging the necessary DT changes
and driver changes.

To me, your policy is simply ignoring the experience.

> If I follow your logic and refer to the i2c transaction generator
> problem, should we go back and add compatible strings for all on-die IP
> blocks for every SoC and SoC revision?  Even though we only wish we had
> something once?  Can we anticipate every possible way an IP block will
> be broken?

Hard to anticipate all the cases, but when we can, we should do it.
Armada 370/XP and Armada 38x are *very* different SOCs. They don't use
the same CPU core, the same cache controller, the same interrupt
controller, a large number of peripherals have changed. The likely-hood
of discovering differences is fairly high.

> Ultimately, what I'm saying is that the devicetree process should be
> able to handle this kind of situation.  And if it can't, the process is
> broken.  No amount of bubblewrap and safety helmets will save us then.
> 
> Now, wrt marvell,armada-38x-system-controller, if you can point out
> specific features you know about *today* that are different from the
> 370/xp sys-con, please spell them out at least in the commit log.  I'm
> fine with just mentioning the features at this point, since we're
> dealing with initial SoC support.  But "...we may in the future discover
> differences between..." doesn't inspire confidence.

Have you ever had a look at a very early datasheet? It seems like not.
The datasheet details at this stage of the SoC development are very
limited as the datasheet is still being written. Remember that we are
talking about a SoC that has not even been announced publicly on the
SoC vendor web site.

We had to get back to Marvell many, many times to have enough details
to understand various aspects of the SoC. So yes, we may very well
discover differences in the future, simply because we have no way,
today, to have a clear view of all aspects of the SoC.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
