From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 17:58:09 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <CALCETrV5C2JosC_rtucQVg+U0bm8hFQFBTv3dz0it0a8iMCyrQ@mail.gmail.com>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <CALCETrV5C2JosC_rtucQVg+U0bm8hFQFBTv3dz0it0a8iMCyrQ@mail.gmail.com>
Message-ID: <20140627215809.GD16724@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 02:47:38PM -0700, Andy Lutomirski wrote:
> >> > Due to that, any ARMv5 or earlier CPU will always have the kuser helper
> >> > page.  ARMv6 and later may or may not have the kuser helper page, but
> >> > there you're really building for a different ABI anyway (VFP-based) and
> >> > you also know that you have the thread registers.
> >>
> >> so is it expected that the libc makes no attempt to provide
> >> portable binary interface for armv5 and armv6?
> >
> > The libc interface that applications make use should not have any
> > dependence on whether KUSER_HELPERS is enabled or disabled, the
> > presence of that page should be totally invisible to applications.
> 
> As of right now, an x86_64 libc can have good performance on any
> recent kernel and will work correctly on any kernel.  From what you're
> saying, it sounds impossible to implement such a thing on ARM without
> fiddling with /proc.

Indeed. I wasn't even aware of the legacy vsyscall mess for x86_64,
and we're not using it in musl. Keeping it around seems like just a
matter of maintaining API/ABI compatibility with legacy versions of
glibc that are using it. On the other hand, the kuser helper page is
the ONLY way for a libc that's compatible with pre-v6 arm to get
working atomics and TLS.

Rich
