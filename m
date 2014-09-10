From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 18:10:14 +0100
Subject: [PATCH v9 4/6] ARM: add vdso user-space code
In-Reply-To: <CALCETrUKcH11nL4peq5=t0TFMKeY8h-d5kbq1+VV9ujAzYpd-Q@mail.gmail.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <1408744351-7814-5-git-send-email-nathan_lynch@mentor.com>
 <20140910164755.GC1710@arm.com>
 <CALCETrUKcH11nL4peq5=t0TFMKeY8h-d5kbq1+VV9ujAzYpd-Q@mail.gmail.com>
Message-ID: <20140910171014.GF1710@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 05:52:39PM +0100, Andy Lutomirski wrote:
> On Wed, Sep 10, 2014 at 9:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Aug 22, 2014 at 10:52:29PM +0100, Nathan Lynch wrote:
> >> Place vdso-related user-space code in arch/arm/kernel/vdso/.
> >>
> >> It is almost completely written in C with some assembly helpers to
> >> load the data page address, sample the counter, and fall back to
> >> system calls when necessary.
> >
> > I'm still a bit puzzled as to how we can implement a compat version of this
> > for a 32-bit userspace running under a 64-bit kernel. Maybe the answer is
> > that we don't care enough (programs will still work fine without it), but if
> > we did want to then we're going to need to build the kernel with two
> > toolchains and it gets really horrible.
> >
> > Do you have any ideas?
> 
> Convince the gcc and binutils people to add a-m32 option to aarch64?
> That's how x86_64 pulls this off :)  Or you could require a
> cross-compiler to be available to enable this particular feature.

The compilers have two separate backends, so I think I'll know what they
say. I guess it's either overhauling kbuild to support two cross compilers,
or have some shell script to accept an option we make up.

> I have no further bright ideas, unless aarch64 and arm assembly are
> miraculously nearly compatible, in which case you could do something
> like what x32 does (build 64-bit and then use objcopy to turn the
> result into an x32 object).

The assembler is pretty different, so I'd be pretty uneasy about trying to
do that.

Will
