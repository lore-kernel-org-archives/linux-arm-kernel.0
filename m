From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2018 17:25:32 +0100
Subject: [PATCH v3] arm64: signal: Report signal frame size to userspace
 via auxv
In-Reply-To: <1526571941-9816-1-git-send-email-Dave.Martin@arm.com>
References: <1526571941-9816-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180517162532.GE17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 04:45:41PM +0100, Dave Martin wrote:
> Stateful CPU architecture extensions may require the signal frame
> to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> However, changing this #define is an ABI break.
> 
> To allow userspace the option of determining the signal frame size
> in a more forwards-compatible way, this patch adds a new auxv entry
> tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> size that the process can observe during its lifetime.
> 
> If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> a consistent interface with older kernels that do not provide
> AT_MINSIGSTKSZ.
> 
> The idea is that libc could expose this via sysconf() or some
> similar mechanism.
> 
> There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> about userspace's own stack overheads and should not pretend to
> know.

I'm really not sure I follow your logic here.

POSIX requirements are here:

http://pubs.opengroup.org/onlinepubs/000095399/functions/sigaltstack.html

and the requirement there is that the MINSIGSTKSZ constant is defined
in signal.h to indicate to user programs the minimum signal stack size
that the system requires.

I don't see how passing the minimum signal stack size via AT_MINSIGSTKSZ
helps in any way, since you propose to make programs use a sysconf()
call to get that, and that is not covered by POSIX.  So you're asking
programs to do something special for ARM64.

Simply increasing MINSIGSTKSZ doesn't cause an ABI break - new programs
built against an increased MINSIGSTKSZ results in more stack being
allocated, which doesn't break the ABI in any way.  The problem comes
when old programs built with the old MINSIGSTKSZ are run against a
kernel requiring a larger MINSIGSTKSZ.  It's almost the reverse problem
- the kernel needs to know the MINSIGSTKSZ value that the problem was
built with, but we don't have that facility either.

> For arm64:
> 
> The primary motivation for this interface is the Scalable Vector
> Extension, which can require at least 4KB or so of extra space
> in the signal frame for the largest hardware implementations.

Presumably you only include the SVE state if the application makes use
of SVE?  Otherwise, you'd be saving and restoring a lot of state for
features that are not being used.

I suppose part of the issue is that SVE is supported but MINSIGSTKSZ
is incorrect if this state has to be saved and restored, so there's
apps out there using SVE with the too-small MINSIGSTKSZ value?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
