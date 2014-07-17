From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 10:07:58 +0100
Subject: [PATCH] arm64: Refactor compat.h into compat-types.h
In-Reply-To: <1405579538-17724-1-git-send-email-ijc@hellion.org.uk>
References: <1405579538-17724-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <20140717090758.GB21153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 07:45:38AM +0100, Ian Campbell wrote:
> This reduces the complexity of the includes needed for linux/stat.h and removes
> some possibilities for causing include loops.
> 
> One such issue was exposed by the Debian kernel's application of the aufs
> patches which led to:
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
> This is due to an extra fs.h include added to mm.h leading to a loop in the
> includes. Splitting out the type defintions from compat.h into compat-types.h
> allows asm/stat.h to only include the types header and avoids the loop.
> 
> Full logs in http://buildd.debian-ports.org/status/fetch.php?pkg=linux&arch=arm64&ver=3.14.12-1&stamp=1405234443
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: debian-kernel at lists.debian.org

Looks good to me, but I note Arnd's prior comment about mm.h including fs.h
being a bug. If that's true, then this patch isn't needed at all and aufs
should be fixed instead.

Will
