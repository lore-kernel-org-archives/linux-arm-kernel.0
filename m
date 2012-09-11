From: mol@pengutronix.de (Michael Olbrich)
Date: Tue, 11 Sep 2012 15:07:34 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911124226.27fa248b@archvile>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20120911084853.GT24458@pengutronix.de>
 <20120911113139.3b7b879f@archvile>
 <20120911102905.GC14994@pengutronix.de>
 <20120911124226.27fa248b@archvile>
Message-ID: <20120911130734.GD14994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 12:42:26PM +0200, David Jander wrote:
> On Tue, 11 Sep 2012 12:29:05 +0200
> Michael Olbrich <mol@pengutronix.de> wrote:
> 
> > On Tue, Sep 11, 2012 at 11:31:39AM +0200, David Jander wrote:
> > > On Tue, 11 Sep 2012 10:48:53 +0200
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > 
> > > > On Tue, Sep 11, 2012 at 09:27:53AM +0200, David Jander wrote:
> > > > > 
> > > > > Hi Matt,
> > > > > 
> > > > > >         @ Function supports interworking.
> > > > > >         @ args = 0, pretend = 0, frame = 0
> > > > > >         @ frame_needed = 0, uses_anonymous_args = 0
> > > > > >         @ link register save eliminated.
> > > > > >         cmp     r0, #9
> > > > > >         mov     r3, #0
> > > > > >         str     r3, [r1, #0]
> > > > > >         mov     r0, #0
> > > > > >         strgt   r3, [r1, #4]
> > > > > >         bx      lr
> > > > > >         .size   flexcan_chip_start, .-flexcan_chip_start
> > > > > >         .ident  "GCC: (GNU) 4.3.3"
> > > > > >         .section        .note.GNU-stack,"",%progbits
> > > > > > 
> > > > > > I think this looks correct. Perhaps you could try the angstrom arm5te
> > > > > > toolchain and see if it's a toolchain issue?
> > > > > 
> > > > > Yes, this looks a lot better, and is exactly what I get when I compile this
> > > > > code with CodeSourcery GCC-4.4.1
> > > > > 
> > > > > I have tries building gcc-4.6.3 also with OSELAS/PTXdist, and it gives the
> > > > > same (wrong) result as with gcc-4.6.2
> > > > 
> > > > AFAIK our OSELAS/PTXdist Toolchains use Linaro patches, this would
> > > > explain why both have the same result.
> > 
> > No, OSELAS Toolchains only uses the Linaro GCC for Cortex-A8/-A9
> > 
> > > It would indeed, if I had just used OSELAS as-is, but I didn't ;-)
> > > I made a copy of
> > > arm-v5te-linux-gnueabi_gcc-4.6.2_glibc-2.14.1_binutils-2.21.1a_kernel-2.6.39-sanitized.ptxconfig
> > > and replaced the version string 4.6.2 with 4.6.3. AFAIK, this way PTXdist will
> > > download pristine gcc-4.6.3 sources and not apply any patches, since there is
> > > no directory named patches/gcc-4.6.3, right? Can I assume that I have an
> > > unpatched version of gcc-4.6.3 then?
> > 
> > Correct. This way you'll get gcc-4.6.3 without any patches.
> > 
> > > Btw, Here's what I get from it:
> > > 
> > > flexcan_chip_start:
> > >         @ args = 0, pretend = 0, frame = 0
> > >         @ frame_needed = 0, uses_anonymous_args = 0
> > >         @ link register save eliminated.
> > >         mov     r3, #0
> > >         cmp     r0, #9
> > >         str     r3, [r1, #0]
> > >         ldrle   r3, [r1, #4]
> > >         mov     r0, #0
> > >         str     r3, [r1, #4]
> > >         bx      lr
> > >         .size   flexcan_chip_start, .-flexcan_chip_start
> > >         .ident  "GCC: (OSELAS.Toolchain-2011.11.1) 4.6.3"
> > >         .section        .note.GNU-stack,"",%progbits
> > 
> > How can I reproduce this output? I'd like to test this with different
> > toolchain versions.
> 
> I basically do this:
> 
> $ /opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/bin/arm-v5te-linux-gnueabi-gcc-4.6.3 -Os -S -o - -x c -
> 
> struct flexcan_regs {
>         unsigned int mcr;
>         unsigned int rxfgmask;
> };
> 
> #define flexcan_read(a) (*(volatile unsigned int *)(a))
> #define flexcan_write(v,a)      (*(volatile unsigned int *)(a) = (v))
> 
> int flexcan_chip_start(int ver, struct flexcan_regs *regs)
> {
>         flexcan_write(0, &regs->mcr);
> 
>         if (ver >= 10)
>                 flexcan_write(0, &regs->rxfgmask);
> 
>         return 0;
> }
> 
> > > Wrong code.
> > > See the version string? It is clearly not an existing OSELAS version.
> > 
> > Hmmm, so far it seems all tested gcc-4.6.x versions produce wrong code,
> > correct?
> 
> Looks like that, yes.

Including the Linaro gcc releases it seems. I rebuilt the toolchain with
Linaro GCC 4.6-2012.08 and the result is the same.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
