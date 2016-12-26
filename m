From: nm@ti.com (Nishanth Menon)
Date: Mon, 26 Dec 2016 12:46:58 -0600
Subject: v4.10-rc1 - build failure arm64?
In-Reply-To: <9e720e28-469f-6a06-a97c-9d52ce951bfb@ti.com>
References: <9e720e28-469f-6a06-a97c-9d52ce951bfb@ti.com>
Message-ID: <e47e230c-4e76-a7b7-a408-ada809a3b1b8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2016 12:30 PM, Nishanth Menon wrote:
> Hi,
> Not sure if this was already reported (but searching linux-arm and
> linux-next MLs did not quickly show something)
>
> * master 7ce7d89f4883 Linux 4.10-rc1
> -> http://pastebin.ubuntu.com/23689404/
>
> Backtracking:
> next-20161224, next-20161223, next-20161222->
> http://pastebin.ubuntu.com/23689415/ (different from master)
>
> next-20161221 -> Builds fine (last clean build)
>
> GCC:
> https://releases.linaro.org/components/toolchain/binaries/latest-6/aarch64-linux-gnu/
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016
> Copyright (C) 2016 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
>
> Reproduction steps:
>
> $ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 defconfig
> $ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 Image
>
>
A bit of bisect later, looks like reverting the following commit 
allows the build to proceed. -> note: there is no fail on 
multi_v7_defconfig or omap2plus_defconfig even without the revert.

commit 7c0f6ba682b9c7632072ffbedf8d328c8f3c42ba
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Dec 24 11:46:01 2016 -0800

     Replace <asm/uaccess.h> with <linux/uaccess.h> globally

     This was entirely automated, using the script by Al:

       PATT='^[[:blank:]]*#[[:blank:]]*include[[:blank:]]*<asm/uaccess.h>'
       sed -i -e "s!$PATT!#include <linux/uaccess.h>!" \
             $(git grep -l "$PATT"|grep -v ^include/linux/uaccess.h)

     to do the replacement at the end of the merge window.

     Requested-by: Al Viro <viro@zeniv.linux.org.uk>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


-- 
Regards,
Nishanth Menon
