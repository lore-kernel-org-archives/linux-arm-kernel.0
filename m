From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 21:04:29 +0100
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423200429.GF5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:21:57AM -0500, Nicolas Pitre wrote:
> This is version 4 of the patch series required to safely power up
> and down CPUs in a cluster as can be found in b.L systems.  If nothing
> major is reported, I'll send a pull request to Russell for this set
> very soon.

Okay, so from spending an hour or so quickly scanning these patches,
on the face of it there are only a few comments I have which I'm very
surprised that your exhaustive team of apparant reviewers didn't
already catch.

The biggest disappointment so far in this patch set is finding the
re-use of the repeated cache handling stuff - when I've already made
my feelings _well_ known towards re-using existing cache APIs (which
are designed to handle a _purpose_) for different purposes "just
because" they appear to do what you need on a particular CPU.  I've
stated my objection to this kind of behaviour many times in the past,
I've even _purposely_ broken stuff (mtd stuff) when that's happened in
the past, and I've not changed my views on this one bit.  It's really
surprising to me that someone who has been around for such a long time,
and who knows my views on this, is pushing a patch set which goes
against that, and somehow thinks that I won't have a problem with
it... really?

What I suggest for the time being is to provide new inline function(s)
in arch/arm/include/cacheflush.h which are purposed for your application,
document them in that file, and call the implementation you're currently
using.  That means if we do have to change it in the future (for example,
we don't need to do anything in the dcache flushing stuff) we don't have
to hunt through all the code to find _your_ different use of that function
and fix it - we can just fix it in one place and we have the reference
there for what your code expects.

Again, this is nothing new - I've made my position on this kind of stuff
_exceedingly_ plain in the past.


That all said, my biggest concern so far from this set is the independent
issue of moving the cache handling into generic code, so that we avoid
the existing problem where every platform ends up implementing that stuff
time and time again - and the impact that will have on this MCPM code.

Currently as I see it, the two things are mutually incompatible with
each other - and having discussed with Will, we'd come to the conclusion
that I'd merge what I had because the comments alone on how the cpu
hotplug stuff is supposed to work are a valuable improvement, even
though the code changes don't completely solve all the issues.

However, MCPMm gets in the way of that.  So... that presents a dilema...
it's a case of this or that but not both.  Or do you think MCPM can
survive with additional LOUIS flushing before the cpu die callback is
called?
