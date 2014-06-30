From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 09:43:26 +0200
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140628094219.GB32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <53ADA358.7000305@mentor.com> <20140628094219.GB32514@n2100.arm.linux.org.uk>
Message-ID: <5093993.PR3K0Jp7Pk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 June 2014 10:42:19 Russell King - ARM Linux wrote:
> What's happening is if you try and rebuild a kernel with these patches
> applied, you already have an arch/arm/include/generated/asm/auxvec.h
> which points at the empty asm-generic version.  This remains after
> these patches are applied, so the new include of asm/auxvec.h in
> asm/elf.h picks up on the empty version, not the newly introduced
> version.

One more piece of the puzzle: the top-level Makefile always includes
the headers from the source tree before generated headers, so in theory
this should not be happening. However, for some reason this ends up
as arch/arm/include/generated/asm/auxvec.h rather than
arch/arm/include/generated/uapi/asm/auxvec.h, and the kernel-only
headers get included before any of the uapi headers.

An easy workaround would probably be to add an
arch/arm/include/asm/auxvec.h file that contains only

#include <uapi/asm/auxvec.h>

	Arnd
