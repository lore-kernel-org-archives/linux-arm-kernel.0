From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Aug 2010 11:56:56 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100828074304.GA2183@osiris.boeblingen.de.ibm.com>
References: <4C61EE55.5030506@codeaurora.org> <4C7867D4.10404@codeaurora.org>
	<20100828074304.GA2183@osiris.boeblingen.de.ibm.com>
Message-ID: <201008281156.56958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 August 2010 09:43:04 Heiko Carstens wrote:
> In function 'copy_from_user',
>     inlined from '__tun_chr_ioctl' at drivers/net/tun.c:1200:
> /linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct

I wrote this one, and I can't think of an easy way to do fix
it without increasing the code complexity or size.

> In function 'copy_from_user',
>     inlined from 'write_file_bool' at fs/debugfs/file.c:434:
> /linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
> In function 'copy_from_user',
>     inlined from 'packet_getsockopt' at net/packet/af_packet.c:2123:
> /linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct

These look like the compiler is not smart enough. Both make sure
that we copy at most the size of the object, or less if the user
didn't pass all of it.

> In function 'copy_from_user',
>     inlined from 'compat_sys_socketcall' at net/compat.c:783:
> /linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct

I don't think the compiler has a chance to figure this one out.
However, I don't see the warning on x86. Maybe x86-gcc has
a bug.

	Arnd
