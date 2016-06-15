From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jun 2016 00:13:03 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
 <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
Message-ID: <20160615231303.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 03:54:38PM -0700, Kees Cook wrote:
> On Wed, Jun 15, 2016 at 3:42 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > In fact, the apparent confusion over this reinforces my belief that we
> > should _not_ give the size of the uncompressed image at all.
> >
> > The boot environment must be setup such that there is room for the
> > uncompressed image (aligned currently to 256 bytes) followed by the
> > size of the compressed image, with any appended DTBs included.
> > Anything which is located below that is likely to get trampled by
> > the decompressor.
> 
> Okay, sounds reasonable to me. :)

I should point out that this method should work for a zImage without
an appended DTB, and we have no way to update this header block for
the appended DTB case.

So, an alternative standpoint is that we supply only the uncompressed
image size.  Then, the boot environment needs to understand that they
must allow for the compressed image and any appended DTB on top of that
(which it would see as one - the size of the combined image.)

However, while that may sound like a good idea, we're falling into the
same trap that we've fallen into at the beginning of this thread: the
boot environment has to understand how the decompressor currently works,
and if we were to change that, this we're back to the calculation which
the boot environment is using not matching reality.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
