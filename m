From: schwab@suse.de (Andreas Schwab)
Date: Mon, 29 Feb 2016 17:00:29 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <208897488.c0hkBy2G1S@wuerfel> (Arnd Bergmann's message of "Fri,
 19 Feb 2016 09:23:35 +0100")
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <208897488.c0hkBy2G1S@wuerfel>
Message-ID: <mvm4mcrtski.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> In https://github.com/norov/glibc/commit/5d4290435e428267171ece871539b76e1d079d11
> you are defining a struct __kernel_stat64 in the glibc. Is this the expected
> way to do it? I would have thought you'd get the definition from the kernel
> headers.

The problem really is that struct stat64 does not match the kernel
struct stat64.  The latter uses the broken st_ino, where the 64-bit
inode is actually stored at the end of the structure, and there is
padding *before* the 32-bit inode, not after (so you cannot overlay a
64-bit inode field in little endian mode).  You need to add the attached
file as sysdeps/unix/sysv/linux/aarch64/bits/stat.h, then you can use
the user-space struct stat64 to communicate with the *stat64 syscalls,
and __kernel_stat64 is not needed any more.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: stat.h
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/6c496eb8/attachment-0001.h>
