From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 17:41:47 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140702164147.GQ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 06:21:07PM +0200, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> I believe you have seen the on-going discussion with Russell on how to
> ensure that the relevant requirements for hardware I/O coherency are
> meant in non-SMP situations. Since it appears it will take quite a bit
> of time to find a proper solution to this problem, this patch series
> proposes to simply disable hardware I/O coherency in problematic
> configurations.

It is unfortunate, but I do feel that there's been something of an
excessive amount of pressure here - it seems to me that the I/O
coherency as merged and enabled, without thinking about the consequences.
When it was then realised that some fundamental core changes were
needed, it's somehow been turned into my fault that this stuff doesn't
work, and my problem to solve.

While it /is/ my problem to solve (or rather, ensure that it does get
solved in a way which is compliant with the architecture) I'm also
juggling several other things which leaves me not enough time to look
at this right now.

It seems that people think that I have oodles of spare time to be able
to jump onto their problem at a moments notice.  I don't.

I've already said that device tree and single zImage makes solving your
problem /much/ harder than it otherwise was.  Right now, I don't have
any solution to it in mind that would both satisfy the requirements of
the architecture _and_ allow the coherency stuff to operate as Marvell
wants it to.

Before device tree, we had the atags and the machine ID, with the
machine_desc discovered in the early boot code.  This would have
allowed us to add a hook there which identified your coherent platform
and adjusted the page tables appropriately to ensure that the coherency
stuff worked as intended.

We don't have that anymore (not even in non-device tree mode), and
device tree doesn't offer any replacement for it.

As I've frequently said, device tree is great for some things, but it
makes solving other problems insanely more difficult.  This is one of
those which is insanely more difficult because it just doesn't fit
the device tree model.

While it's regrettable to have to disable the coherency support, I think
that's the best way to proceed at the moment until we're able to find
some kind of solution.

The most important first step in that is working out how, in the early
assembly code, we can identify these Armada SoCs.  That's a task I
can't undertake because I know next to nothing about the SoCs you're
dealing with.  Yes, I know that Marvell released a TRM a short while
back, which is great, but not everyone has time to go around reading
every TRM which every silicon vendor releases into the public domain.

If it /is/ possible to detect the Armada SoCs in the early assembly,
then we can start to solve this.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
