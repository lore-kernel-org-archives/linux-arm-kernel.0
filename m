From: mark@codesourcery.com (Mark Mitchell)
Date: Sun, 05 Dec 2010 09:14:53 -0600
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>	<20101203165105.GD30898@n2100.arm.linux.org.uk>
	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
Message-ID: <4CFBAC6D.5060507@codesourcery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/3/2010 11:35 AM, Dave Martin wrote:

> What you describe is one of two mechanisms currently in use--- the
> other is for a single library to contain two implementations of
> certain functions and to choose between them based on the hwcaps.
> Typically, one set of functions is chosen a library initialisation
> time.  Some libraries, such as libpixman, are implementated this way;
> and it's often preferable since the the proportion of functions in a
> library which get significant benefit from special instruction set
> extensions is often pretty small.

I've believed for a long time that we should try to encourage this
approach.  The current approach (different libraries for each hardware
configuration) is prevalent, both in the toolchain ("multilibs") and in
other libraries -- but it seems to me premised on the idea that one is
building everything from source for one's particular hardware.  In the
earlier days of FOSS, the typical installation model was to download a
source tarball, build it, and install it on your local machine.  In that
context, tuning the library "just so" for your machine made sense.  But,
to enable binary distribution, having to have N copies of a library (let
alone an application) for N different ARM core variants just doesn't
make sense to me.

So, I certainly think that things like STT_GNU_IFUNC (which enable
determination of which routine to use at application start-up) make a
lot of sense.

I think your idea of exposing whether a unit is "ready", to allow even
more fine-grained choices as an application runs, is clever.  I don't
really know enough to say whether most applications could take advantage
of that.  One of the problems I see is that you need global information,
not local information.  In particular, if I'm using NEON to implement
the inner loop of some performance-critical application, then when the
unit is not ready, I want the kernel to wake it up already!  But, if I'm
just using NEON to do some random computation off the critical path, I'm
probably happy to do it slowly if that's more efficient than waking up
the NEON unit.  But, which of these cases I'm in isn't always locally
known at the point I'm doing the computation; the computation may be
buried in a small library routine.

Do we have good examples of applications that could profit from this
capability?

-- 
Mark Mitchell
CodeSourcery
mark at codesourcery.com
(650) 331-3385 x713
