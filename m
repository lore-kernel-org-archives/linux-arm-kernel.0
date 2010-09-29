From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Sep 2010 16:42:49 +0100
Subject: [PATCH 1/2] ARM: add memory types for the TCMs
In-Reply-To: <1278623805-17027-1-git-send-email-linus.walleij@stericsson.com>
References: <1278623805-17027-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100929154249.GA24118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 08, 2010 at 11:16:45PM +0200, Linus Walleij wrote:
> I'm especially in the dark about the usage of the L_PTE_* stuff,
> and when to use DOMAIN_KERNEL, DOMAIN_USER and DOMAIN_IO. For
> example: does DOMAIN_KERNEL imply kernel usage? DOMAIN_KERNEL
> for ITCM makes the code non-executable. Does DOMAIN_USER imply
> that L_PTE_USER shall also be set?

Sorry, should've replied to this much earlier.  We now have a problem in
that this stuff for the ITCM entry is wrong (identified via Santosh's
MT_MEMORY problems).

L_PTE_* define what ends up in the PTE entries.  L_PTE_USER and
L_PTE_WRITE operate together:

- None set, page is read-only in SVC mode, inaccessible in user mode.
- L_PTE_WRITE, page is read-write in SVC mode, inaccessible in user mode.
- L_PTE_USER, page is read-write in SVC mode, read-only in user mode.
- L_PTE_USER|L_PTE_WRITE, page is read-write in both SVC and user mode.

The domain stuff determines how these permissions are modified when
set_fs(KERNEL_DS) is in effect.

DOMAIN_IO covers any statically allocated IO device, and is always in
client mode.  This means the permissions are never bypassed.

DOMAIN_USER covers userspace mappings, and likewise is always in client
mode.

DOMAIN_KERNEL covers the kernel direct-mapped RAM, vmalloc and ioremap
space.  This is normally in client mode when set_fs(USER_DS) is in
effect.  When set_fs(KERNEL_DS) is set (which happens when we want to
use user-accessing functions such as get_user() on data in kernel space)
this domain is switched to manager mode, thereby bypassing the normal
MMU protections.

IO stuff in kernel space should be mapped without L_PTE_USER and
DOMAIN_IO.  Everything else in kernel space should be mapped without
L_PTE_USER and DOMAIN_KERNEL, with the exception of the user-accessible
high vectors page.
