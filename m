From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 12 Apr 2013 16:50:34 +0100
Subject: [PATCH] arm64: remove PSR bit macros from uapi
In-Reply-To: <20130412151835.GK12363@mudshark.cambridge.arm.com>
References: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
 <20130412151835.GK12363@mudshark.cambridge.arm.com>
Message-ID: <1365781834.15783.107.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-12 at 16:18 +0100, Will Deacon wrote:
> Hi Ian,
> 
> On Fri, Apr 12, 2013 at 04:09:59PM +0100, Ian Campbell wrote:
> > Exposing these in ptrace.h ends up polluting the namespace for user
> > applications which include headers such as <signal.h>, e.g. when building Xen
> > userspace tools on arm64:
> > 
> > tools/include/xen/arch-arm.h:229:0: error: "PSR_MODE_EL0t" redefined [-Werror]
> > In file included from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/user.h:25:0,
> >                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/procfs.h:34,
> >                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/ucontext.h:26,
> >                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/signal.h:360,
> >                  from xentrace.c:21:
> > /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/asm/ptrace.h:30:0: note: this is the location of the previous definition
> 
> Strange... I don't see the PSR definitions in any headers other than
> ptrace.h for my aarch64 toolchain.

It's the definition in ptrace.h which is the problem, since it conflicts
with the application's own definitions (Xen userspace in this case). The
names are in the "applications" namespace (i.e. not prefixed with _) and
it hasn't included any headers which are defined to cause those names to
be used.

I'm not sure which (if any) spec includes ptrace.h but signal.h isn't
defined to #define PSR_FOO. Maybe the real bug is the signal.h ends up
including ptrace.h at all?

>  Which tools are you using?

Ubuntu Raring multiarch cross thing, which is gcc 4.7.2-22ubuntu3 and
glibc 2.17-0ubuntu4.

Ian.
