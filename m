From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Tue, 7 Apr 2015 05:49:29 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150407031233.GA16189@earth>
References: <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com> <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
 <20150407022312.GK18048@atomide.com> <20150407031233.GA16189@earth>
Message-ID: <CAALWOA8m9Gqv2ZL6ibWrWRBGsGBG2tpbutzVrwOjRpKCQ=mXXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 April 2015 at 04:23, Tony Lindgren <tony@atomide.com> wrote:
> Oops, sorry user error.. I was trying to clear IBE as a banked register
> like L2 enable bit and of course it did not get cleared.. Clearing it
> with a smc call really clears it. And in that case my test case seems to
> work reliably on r3p2 without erratum 430973 enabled.

So if I understand correctly, you actually had crashes which only
occurred with IBE enabled and the 430973 workaround disabled?  That's
quite interesting, since it seems to me that can only be the result of
erratum 687067, which means
1. secrom indeed fails to implement the 687067 workaround.
2. "BTB invalidate by MVA" is used somewhere in the kernel.
The 430973 workaround would likely conceal this problem due to
regularly flushing the whole BTB, but I'm not sure how wise it is to
rely on that...


> I'm now thinking the kernel should just always set the 430973 specific
> cpu_v7_switch_mm for all cortex-a8 if IBE bit is set.

And simply take the performance hit if secrom bogusly sets it and the
bootloader doesn't fix it?

Sounds reasonable enough to me, given how platform-specific the
appropriate auxcr config is, as well as the means by which it can be
changed.

There's more secrom misconfiguration that the bootloader should fix
anyhow to make optimal use of the processor...


> This will work as long as we can read the aux ctrl register IBE
> bit using mrc, which I believe is the case for all cortex-a8 based
> omap variants.

Aux control is always readable, only write is an issue.

On 7 April 2015 at 05:12, Sebastian Reichel <sre@kernel.org> wrote:
> If I understood it correctly we can simply call the BTB flush on
> cortex-a8 if IBE bit is not set, since it would be translated as
> nop.

Indeed you can safely use the BTB-flushing context switch on any cortex-a8.

There's still value in checking if IBE is set on r2p1 or later, and if
so emit a warning about suboptimal performance.

> So it should be safe to include the call on all cortex-a8 based
> cpus. We may need a non-BTB-flushing function for non-cortex-a8
> based cpus, though.

I just looked it up, apparently BTB-flushing on context switch is not
needed architecturally in ARMv7 (though it was in ARMv6), so that
version should probably indeed only be used for the cortex-a8.

Matthijs
