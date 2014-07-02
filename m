From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Jul 2014 19:18:32 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140702164147.GQ32514@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <20140702191832.5e9f35fc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 2 Jul 2014 17:41:47 +0100, Russell King - ARM Linux wrote:

> > I believe you have seen the on-going discussion with Russell on how to
> > ensure that the relevant requirements for hardware I/O coherency are
> > meant in non-SMP situations. Since it appears it will take quite a bit
> > of time to find a proper solution to this problem, this patch series
> > proposes to simply disable hardware I/O coherency in problematic
> > configurations.
> 
> It is unfortunate, but I do feel that there's been something of an
> excessive amount of pressure here - it seems to me that the I/O
> coherency as merged and enabled, without thinking about the consequences.
> When it was then realised that some fundamental core changes were
> needed, it's somehow been turned into my fault that this stuff doesn't
> work, and my problem to solve.

Oh, really, not all. This patch series is absolutely not an attempt at
putting any pressure on you, or on anybody else. Really, really, really
not.

We (me, Gregory, Ezequiel, and other Marvell folks) completely
overlooked the core requirements of hardware I/O coherency when we
initially merged the support for this feature. And only recently,
thanks to the work of Simon Guinot and other folks at LaCie, we
realized our mistake. So, I started working with you on a solution
acceptable upstream to meet the requirement for I/O coherency, and it
clearly turns out that the solution for that is not going to be simple
and easy.

So, this patch series is not an attempt to put any sort of pressure on
you. It is merely a recognition of something we (me, Gregory, Ezequiel
and other Marvell folks) did wrong, and the realization that since the
proper fix to this issue is going to take some time, it is better not
to let users with a known-broken kernel.

Actually, what prompted the posting of this patch series is the fact
that I received a private e-mail from a user of the mainline Linux
kernel on Armada 370 who was worried about our discussion around I/O
coherency and data corruption. This patch series is intended to
temporarily revert back to a situation where I/O coherency is not used
in situations where we know it isn't safe, just to ensure that users
don't fall into troubles.

And then it gives us all the time we need to work out together the
appropriate solution to ultimately re-enable I/O coherency on these
problematic configuration.

So really, Russell, trust me about the intention of this patch series:
there is no intent to put pressure on anyone, only a temporary solution
to make the kernel sane today, and give us time to work out the
long-term solution. I would even rather say that it actually *reduces*
the pressure on solving the initial problem :-)

> While it /is/ my problem to solve (or rather, ensure that it does get
> solved in a way which is compliant with the architecture) I'm also
> juggling several other things which leaves me not enough time to look
> at this right now.
> 
> It seems that people think that I have oodles of spare time to be able
> to jump onto their problem at a moments notice.  I don't.

See above. I'm definitely not throwing the problem at you. I believe
that despite my lack of deep knowledge of the ARM core code base, I've
made several attempts at proposing some solutions, and trying to work
out with you some solutions that might be appropriate. So I am clearly
not trying to put all the work on you.

The insistent e-mails from the past days/weeks on getting an answer
where not calls for you to do the coding work, but only calls for you
to give me a little bit of guidance in the direction to follow to make
progress with this problem. Nothing more.

> I've already said that device tree and single zImage makes solving your
> problem /much/ harder than it otherwise was.  Right now, I don't have
> any solution to it in mind that would both satisfy the requirements of
> the architecture _and_ allow the coherency stuff to operate as Marvell
> wants it to.
> 
> Before device tree, we had the atags and the machine ID, with the
> machine_desc discovered in the early boot code.  This would have
> allowed us to add a hook there which identified your coherent platform
> and adjusted the page tables appropriately to ensure that the coherency
> stuff worked as intended.
> 
> We don't have that anymore (not even in non-device tree mode), and
> device tree doesn't offer any replacement for it.
> 
> As I've frequently said, device tree is great for some things, but it
> makes solving other problems insanely more difficult.  This is one of
> those which is insanely more difficult because it just doesn't fit
> the device tree model.

Yes, I do understand. In the mean time, I've asked Marvell internally
to see if there is a CP15-based way of differentiating their I/O
coherency capable Cortex-A9 from the usual Cortex-A9.

> While it's regrettable to have to disable the coherency support, I think
> that's the best way to proceed at the moment until we're able to find
> some kind of solution.

Sure, see above :)

> The most important first step in that is working out how, in the early
> assembly code, we can identify these Armada SoCs.  That's a task I
> can't undertake because I know next to nothing about the SoCs you're
> dealing with.  Yes, I know that Marvell released a TRM a short while
> back, which is great, but not everyone has time to go around reading
> every TRM which every silicon vendor releases into the public domain.

Absolutely.

> If it /is/ possible to detect the Armada SoCs in the early assembly,
> then we can start to solve this.

I think there are confusions about several problems here:

 1) The Armada 370 and Armada XP are perfectly detectable in the early
    assembly, since they have different values in the main
    identification register (they use PJ4B and PJ4B-MP cores). But for
    the Armada 370/XP, there is still the open question on whether the
    TTB flags should match the PMD flags in terms of caching policy
    attribute and shareability attribute. That's *completely* unrelated
    to detecting the SoC in the early assembly, and having the answer
    to this question would allow us to potentially re-enable I/O
    coherency on Armada 370 (both CONFIG_SMP and !CONFIG_SMP) and Armada
    XP (for !CONFIG_SMP)

 2) The Armada 375 and 38x are Cortex-A9, so it's only for those SoCs
    that we have the potential issue of differentiating those
    I/O-coherency capable A9 from the non-I/O-coherency capable A9 in
    the early assembly code.

If we could first make progress about problem (1), it would be great.
Then we can have a look about problem (2).

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
