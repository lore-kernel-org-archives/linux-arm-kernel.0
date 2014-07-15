From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Jul 2014 09:20:40 +0100
Subject: [PATCH] arm64: Move struct stat64 to uapi.
In-Reply-To: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
References: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <20140715082040.GB24269@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Tue, Jul 15, 2014 at 08:39:06AM +0100, Ian Campbell wrote:
> This struct is part of the user API for compat tasks so I think it belongs in
> uapi and should use the __uFOO types.

I don't think we should be exposing compat structures through the arm64
UAPI. Compat tasks should be built against the native arm headers and
nothing else.

What happens if you turn compat off (CONFIG_COMPAT=n)?

> This was exposed by the Debian kernel's application of the aufs patches which
> led to:
> 
> In file included from /?PKGBUILDDIR?/include/linux/mm.h:23:0,
>                  from /?PKGBUILDDIR?/include/linux/pid_namespace.h:6,
>                  from /?PKGBUILDDIR?/include/linux/ptrace.h:9,
>                  from /?PKGBUILDDIR?/arch/arm64/include/asm/compat.h:26,
>                  from /?PKGBUILDDIR?/arch/arm64/include/asm/stat.h:23,
>                  from /?PKGBUILDDIR?/include/linux/stat.h:5,
>                  from /?PKGBUILDDIR?/include/linux/module.h:10,
>                  from /?PKGBUILDDIR?/init/main.c:15:
> /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: 'struct kstat' declared inside parameter list [enabled by default]
>   int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
>                                                                 ^
> /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> 
> This is due to an extra fs.h include added to mm.h. arm64 was the only arch built by
> Debian which had an issue with this, so I think it is an issue with the arm64
> headers rather than the aufs patches.

Hmm, but struct kstat is defined in linux/stat.h so I'm not sure why this is
arm64-specific. linux/fs.h includes that on line 10.

Can you help me unconfuse myself, please?

Will
