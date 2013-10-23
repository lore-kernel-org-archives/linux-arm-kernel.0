From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 11:49:04 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023080630.GA14413@netboy>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
Message-ID: <20131023094903.GD11954@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 10:06:31AM +0200, Richard Cochran wrote:
> On Tue, Oct 22, 2013 at 11:13:46AM -0600, Jason Gunthorpe wrote:
> > The question I asked last time this came up, which was left unaswered:
> > 
> >  Who does this stable DT ABI vision benifit, and how much is that
> >  benifit worth?
> 
> [Sigh]
> 
> I already answered this question more than once. I guess it doesn't
> hurt to answer it again: It helps the users. Please, don't forget
> about them.

But DT ABI stability doesn't help our users if we can't get them any new
features because we're afraid of not getting the binding perfect from
the start.

Real world example: we currently can't settle on the DT binding for
display panels, so while our users may not have to worry about having to
upgrade their DTBs, they can't use their devices because we're too
afraid of ABI stability to allow us to power up the panel. That's
ridiculous.

> If I, as an embedded developer, design my board to work with kernel
> version N and a given DTB, then I can upgrade to any kernel version
> M (where M > N) using the *same* DTB, and it still works.

I get that. I even agree that a stable DTB is a good thing to strive
for. But I also thing requiring every DTB to be stable absolutely is an
unnecessary burden. DT on ARM isn't very mature yet and I think we could
use some flexibility until we've figured a lot more of it out.

We could even add infrastructure to give people a choice. If we start
marking unstable bindings (which arguable would be the majority of the
bindings for the time being) and output a big warning when a device is
matched whose driver implements an unstable binding or which refers to
an unstable binding in the DTB, then it would discourage people from
relying on it if they don't want to be faced with the hassle of having
to update the DTB occasionally. But it also gives people the choice to
consciously ignore the warning if they prefer functionality over ABI
stability. That's nothing unheard of, we've been doing it for quite some
time using the staging tree.

If a runtime warning isn't good enough, we can easily add a Kconfig
option too. If people want to test-drive new functionality and accept
that they might have to update the DTB even on a regular basis, they
could activate that option and use all supported devices, even those
with experimental bindings. Such an option could default to n, upon
which the OF core just wouldn't match anything that carries the
experimental marker.

Does that sound like a good compromise?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/81451822/attachment.sig>
