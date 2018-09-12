From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Sep 2018 14:11:56 +0100
Subject: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
In-Reply-To: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180912131156.GC29880@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

[+ more people from get_maintainers.pl]

On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
> This is a resend of:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html
> 
> now based on 4.19-rc2.
> 
> The Debian folks have observed a failure in the 32-bit arm glibc testsuite
> when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
> enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
> which is higher for native arm64 tasks than compat 32-bit tasks.
> 
> These patches resolve the issue by allowing an architecture to define
> COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
> checking code.
> 
> Feedback welcome,

Any comments on this, please? I'd really like to get this fixed, since
Debian have an outstanding issue without these patches merged. I'm happy
to take them via arm64, but would really like an Ack on the changes to
signal.c first...

Thanks,

Will

> Will Deacon (2):
>   signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
>   arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
> 
>  arch/arm64/include/asm/compat.h |  1 +
>  include/linux/compat.h          |  3 +++
>  kernel/signal.c                 | 14 +++++++++-----
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.1.4
> 
