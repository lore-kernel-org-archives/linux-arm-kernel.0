From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 12 Apr 2013 17:06:29 +0100
Subject: [Xen-devel] [PATCH] arm64: remove PSR bit macros from uapi
In-Reply-To: <1365781834.15783.107.camel@zakaz.uk.xensource.com>
References: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
 <20130412151835.GK12363@mudshark.cambridge.arm.com>
 <1365781834.15783.107.camel@zakaz.uk.xensource.com>
Message-ID: <1365782789.15783.113.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-12 at 16:50 +0100, Ian Campbell wrote:
> I'm not sure which (if any) spec includes ptrace.h but signal.h isn't
> defined to #define PSR_FOO. Maybe the real bug is the signal.h ends up
> including ptrace.h at all?

Having spoken to someone who understands this stuff better than I
(although I still reserve the right to be talking out my a**e) it
appears this is the case. ptrace.h is allowed to define whatever it
likes because it's not defined by a standard but signal.h is specified
by POSIX and is not allowed to define anything which isn't in the POSIX
reserved namespace or which isn't explicitly mentions, which PSR_* is
not.

So it seems like the bug is on the libc side for including this
particular #include chain?

On the flip side is there any reason for the Linux uapi headers to be
including architectural constants? e.g. the x86 uapi/ptrace.h doesn't
define the RFLAGS bits etc...

Ian.
