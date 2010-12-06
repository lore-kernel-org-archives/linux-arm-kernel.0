From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 6 Dec 2010 11:07:05 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <4CFBAC6D.5060507@codesourcery.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101203165105.GD30898@n2100.arm.linux.org.uk>
	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
	<4CFBAC6D.5060507@codesourcery.com>
Message-ID: <AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 5, 2010 at 3:14 PM, Mark Mitchell <mark@codesourcery.com> wrote:
> On 12/3/2010 11:35 AM, Dave Martin wrote:
>
>> What you describe is one of two mechanisms currently in use--- the
>> other is for a single library to contain two implementations of
>> certain functions and to choose between them based on the hwcaps.
>> Typically, one set of functions is chosen a library initialisation
>> time. ?Some libraries, such as libpixman, are implementated this way;
>> and it's often preferable since the the proportion of functions in a
>> library which get significant benefit from special instruction set
>> extensions is often pretty small.
>
> I've believed for a long time that we should try to encourage this
> approach. ?The current approach (different libraries for each hardware
> configuration) is prevalent, both in the toolchain ("multilibs") and in
> other libraries -- but it seems to me premised on the idea that one is
> building everything from source for one's particular hardware. ?In the
> earlier days of FOSS, the typical installation model was to download a
> source tarball, build it, and install it on your local machine. ?In that
> context, tuning the library "just so" for your machine made sense. ?But,
> to enable binary distribution, having to have N copies of a library (let
> alone an application) for N different ARM core variants just doesn't
> make sense to me.

Just so, and as discussed before improvements to package managers
could help here to avoid installing duplicate libraries.  (I believe
that rpm may have some capability here (?) but deb does not at
present).

> So, I certainly think that things like STT_GNU_IFUNC (which enable
> determination of which routine to use at application start-up) make a
> lot of sense.
>
> I think your idea of exposing whether a unit is "ready", to allow even
> more fine-grained choices as an application runs, is clever. ?I don't
> really know enough to say whether most applications could take advantage
> of that. ?One of the problems I see is that you need global information,
> not local information. ?In particular, if I'm using NEON to implement
> the inner loop of some performance-critical application, then when the
> unit is not ready, I want the kernel to wake it up already! ?But, if I'm
> just using NEON to do some random computation off the critical path, I'm
> probably happy to do it slowly if that's more efficient than waking up
> the NEON unit. ?But, which of these cases I'm in isn't always locally
> known at the point I'm doing the computation; the computation may be
> buried in a small library routine.

That's a fair concern -- I haven't explored the policy aspect much.
One possibility is that if the kernel sees system load nearing 100%,
it turns NEON on regardless.  But that's a pretty crude lever, and
might not bring a benefit if the software isn't able to use NEON.
Subtler approaches might involve the kernel collecting statistics on
applications' use of functional units, or some participation from
applications with realtime requirements.  Obviously, this is a but
fuzzy for now...

>
> Do we have good examples of applications that could profit from this
> capability?

Currently, I don't have many examples-- the main one is related to the
discussions aroung using NEON for memcpy().  This can be a performance
win on some platforms, but except when the system is heavily loaded,
or when NEON happens to be turned on anyway, it may not be
advantageous for the user or overall system performance.

Cheers
---Dave
