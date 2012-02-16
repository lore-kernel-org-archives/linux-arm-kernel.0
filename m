From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 16 Feb 2012 12:44:52 -0500 (EST)
Subject: [PATCH 1/2] ARM: remove memmove from boot/compressed/string.c
In-Reply-To: <1329404057-26346-2-git-send-email-michael.opdenacker@free-electrons.com>
References: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
 <1329404057-26346-2-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <alpine.LFD.2.02.1202161226580.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Feb 2012, Michael Opdenacker wrote:

> This patch removes the memmove function from boot/compressed/string.c

... breaking CONFIG_ARM_ATAG_DTB_COMPAT.

> - This definition conflicts with the one in lib/decompress_unxz.c
>   This change is required to support xz compression on ARM.

No, it's the decompress_unxz.c code which is wrong.

To work around it, just do:

#define memmove memmove

before including lib/decompress_unxz.c.

> - memmove is not used in any of the other decompressors
>   in lib/decompress_*.c

Doesn't mean it isn't used at all.

Here's a trick.  Next time you can do:

	git blame arch/arm/boot/compressed/string.c

That will list all the file content, annotated with references to the 
commits that brought them there.

Looking for memmove() you'll see that commit df4879fa260 is responsible 
for it. Its commit log says:

    ARM: zImage: gather some string functions into string.c

    This is a small subset of string functions needed by commits to 
    come.

OK, doing a full 'git log' and searching for that commit, just to back 
up to the next one you'll see:

    ARM: zImage: allow supplementing appended DTB with traditional ATAG  data

That explains why memmove() is required, and by which code.


Nicolas
