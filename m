From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Aug 2016 10:49:40 +0100
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic
In-Reply-To: <CAKv+Gu-+ib-XuQfg8ZL4D7nSk5YRSYaCQyf+UdZPmg+5CxPmJw@mail.gmail.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160803181739.GL1041@n2100.armlinux.org.uk>
 <CAKv+Gu-+ib-XuQfg8ZL4D7nSk5YRSYaCQyf+UdZPmg+5CxPmJw@mail.gmail.com>
Message-ID: <20160804094940.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 09:17:04AM +0200, Ard Biesheuvel wrote:
> On 3 August 2016 at 20:17, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > I don't buy that argument, sorry, and the argument is actually wrong.
> > No, we're _not_ letting the linker do the calculations for us, we're
> > letting the linker do _some_ of the calculation, but not all.
> >
> > What you're replacing the above with is stuff like (I guess, because
> > I've no idea what this :pc_g0: notation is):
> >
> >         add     rX, pc, #(sym - . - 8) & 0xff
> >         add     rX, rX, #(sym - . - 4) & 0xff00
> >         add     rX, rX, #(sym - .) & 0xff0000
> >
> > which I think is a more complex (and less obvious) way to calculate it.
> > It's also buggy when we end up with a relative offset greater than 16MB,
> > which we have in multi-zImage kernels.
> >
> 
> Even if you think this is a more complex way to calculate it, at least
> it is encapsulated in a single macro instead of having similar but not
> identical open coded instances all over the place.

... and, it may come as a shocker, but I don't have a problem with
that.

> As for the range: the ldr/str variants have 28 bits of range (2x
> scaled 8 bit immediate for the adds and a single unscaled 12 bit
> immediate for the ldr/str). The adr variant has 26 bits (3x scaled
> immediate counting from bit 2) range for word aligned symbols, which
> gives us +/- 64 MB, which should be plenty. The only pathological
> outlier is allyesconfig, but that uses Thumb2 anyway.

Our existing code allows for a range of the full address space - the only
thing it relies upon is that the literal data is placed within reach of
the code - which it will be, because it's always placed near the code
which is using it.

> The relocations documented here
> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf

Right, so it's an EABI thing, and I guess you haven't tested OABI
builds, where I suspect these relocations aren't supported.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
