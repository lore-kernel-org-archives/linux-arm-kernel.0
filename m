From: david.jander@protonic.nl (David Jander)
Date: Tue, 11 Sep 2012 11:31:39 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911084853.GT24458@pengutronix.de>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20120911084853.GT24458@pengutronix.de>
Message-ID: <20120911113139.3b7b879f@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012 10:48:53 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Tue, Sep 11, 2012 at 09:27:53AM +0200, David Jander wrote:
> > 
> > Hi Matt,
> > 
> > >         @ Function supports interworking.
> > >         @ args = 0, pretend = 0, frame = 0
> > >         @ frame_needed = 0, uses_anonymous_args = 0
> > >         @ link register save eliminated.
> > >         cmp     r0, #9
> > >         mov     r3, #0
> > >         str     r3, [r1, #0]
> > >         mov     r0, #0
> > >         strgt   r3, [r1, #4]
> > >         bx      lr
> > >         .size   flexcan_chip_start, .-flexcan_chip_start
> > >         .ident  "GCC: (GNU) 4.3.3"
> > >         .section        .note.GNU-stack,"",%progbits
> > > 
> > > I think this looks correct. Perhaps you could try the angstrom arm5te
> > > toolchain and see if it's a toolchain issue?
> > 
> > Yes, this looks a lot better, and is exactly what I get when I compile this
> > code with CodeSourcery GCC-4.4.1
> > 
> > I have tries building gcc-4.6.3 also with OSELAS/PTXdist, and it gives the
> > same (wrong) result as with gcc-4.6.2
> 
> AFAIK our OSELAS/PTXdist Toolchains use Linaro patches, this would
> explain why both have the same result.

It would indeed, if I had just used OSELAS as-is, but I didn't ;-)
I made a copy of
arm-v5te-linux-gnueabi_gcc-4.6.2_glibc-2.14.1_binutils-2.21.1a_kernel-2.6.39-sanitized.ptxconfig
and replaced the version string 4.6.2 with 4.6.3. AFAIK, this way PTXdist will
download pristine gcc-4.6.3 sources and not apply any patches, since there is
no directory named patches/gcc-4.6.3, right? Can I assume that I have an
unpatched version of gcc-4.6.3 then?

Btw, Here's what I get from it:

flexcan_chip_start:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        mov     r3, #0
        cmp     r0, #9
        str     r3, [r1, #0]
        ldrle   r3, [r1, #4]
        mov     r0, #0
        str     r3, [r1, #4]
        bx      lr
        .size   flexcan_chip_start, .-flexcan_chip_start
        .ident  "GCC: (OSELAS.Toolchain-2011.11.1) 4.6.3"
        .section        .note.GNU-stack,"",%progbits

Wrong code.
See the version string? It is clearly not an existing OSELAS version.

Best regards,

-- 
David Jander
Protonic Holland.
