From: dalias@libc.org (Rich Felker)
Date: Fri, 13 Feb 2015 13:37:07 -0500
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150213173345.GA26217@e104818-lin.cambridge.arm.com>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211192118.GC23507@brightrain.aerifal.cx>
 <20150212181735.GF25491@e104818-lin.cambridge.arm.com>
 <501530245.495972.1423767564997.JavaMail.open-xchange@oxbaltgw04.schlund.de>
 <20150213133355.GD3508@e104818-lin.cambridge.arm.com>
 <20150213163013.GE23507@brightrain.aerifal.cx>
 <20150213173345.GA26217@e104818-lin.cambridge.arm.com>
Message-ID: <20150213183706.GF23507@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 05:33:46PM +0000, Catalin Marinas wrote:
> > > > The data structure definition is a little bit fragile, as it depends on
> > > > user space not using the __BIT_ENDIAN symbol in a conflicting way. So
> > > > far we have managed to keep that outside of general purpose headers, but
> > > > it should at least blow up in an obvious way if it does, rather than
> > > > breaking silently.
> > > > 
> > > > I still think it's more practical to keep the zeroing in user space though.
> > > > In that case, we keep defining __kernel_timespec64 with a 'typedef long
> > > > long __kernel_snseconds_t', and it's up to the libc to either use
> > > > __kernel_timespec64 as its timespec, or to define a C11-compliant
> > > > timespec itself and zero out the bits before passing the data to the kernel.
> > > 
> > > The problem with doing this in user space is syscall(2). If we don't
> > > allow it, then it's fine to do the padding in libc.
> > 
> > It's already the case that callers have to tiptoe around syscall(2)
> > usage on a per-arch basis for silly things like the convention for
> > passing 64-bit arguments on 32-bit archs, different arg orders to work
> > around 64-bit alignment and issues with too many args, and various
> > legacy issues. So I think manual use of syscall(2) is a less-critical
> > issue, though of course from a libc perspective I would very much like
> > for the kernel to handle it right.
> 
> I think there is another problem with sign-extending tv_nsec in libc.
> The prototype for functions like clock_settime(2) take a const struct
> timespec *. There isn't anything to prevent such structure being in a
> read-only section, even though it is unlikely. So libc would have to
> duplicate the structure rather than just sign-extending tv_nsec in
> place.

Yes, we already have to do this for x32 in musl. I'd rather not have
to do the same for aarch64-ILP32.

Rich
