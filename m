From: j@jannau.net (Janne Grunau)
Date: Mon, 7 Jul 2014 13:59:54 +0000 (UTC)
Subject: Android and compatibility with deprecated armv7 instructions
References: <20140701234800.GA23577@sirena.org.uk>
 <4473002.jGohFvPsvi@wuerfel> <7B049AD4-78F8-4494-A2CB-57DD346107DA@arm.com>
 <201407061739.22152.arnd@arndb.de>
Message-ID: <loom.20140707T153253-384@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd <at> arndb.de> writes:
> 
> On Saturday 05 July 2014, Catalin Marinas wrote:
> > On 5 Jul 2014, at 19:43, Arnd Bergmann <arnd <at> arndb.de> wrote:
> >
> > > I think if a there is no way to turn off a feature, we can't really
> > > treat it as "deprecated", since we are lacking the most important tool
> > > to help users migrate away from it. Do you know why the architecture
> > > folks believe it makes sense to have distinct steps 1 and 2?
> > 
> > During this phase you usually only get compiler warnings which are
> > clearly not enough for already built apps.
> > 
> > But it looks like this is changing with ARMv8. SETEND is deprecated and
> > disable bit available. IT instruction also deprecated with a disable bit
> > (basically only allowing for one subsequent conditional instruction,
> > though I don?t think we can easily get rid of this one in user space).
> 
> Ok. I can also see ways to emulate SETEND from kernel side by modifying
> the user pt_regs,

The single use of SETEND in FFmpeg/libav is not important and could easily
be disabled on ARMv8. Is there a better way than parsing AT_PLATFORM for
runtime detection of the CPU arch? A HWCAP for the missing SETEND would be
nicer. That of course doesn't fix existing binaries.

> but I don't see how we could emulate IT without anything
> short of a full interpretation of user instructions from the kernel.

Avoiding deprecated forms of IT would be harder. It's used more often in
libav (~50 times) so it should be only disabled if it's emulated or not
available using an explicit HWCAP. Not using Thumb for those functions would
be another option for libav. Again this doesn't fix existing binaries and it
doesn't fix compiled code.

Janne

-- 
libav arm/aarch64 developer
