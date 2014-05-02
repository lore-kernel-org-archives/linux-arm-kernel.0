From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 2 May 2014 20:44:11 +0200
Subject: [PATCH] ARM: Fix non-uapi types.h export
In-Reply-To: <1399030220-13628-1-git-send-email-james.hogan@imgtec.com>
References: <1399030220-13628-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <CAKv+Gu8fxci_-Q0ys0L4FFPFeSYYoQGPCKgZK5972xG5ArhnvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 May 2014 13:30, James Hogan <james.hogan@imgtec.com> wrote:
> The arch/arm/include/asm/types.h is being apparently unintentionally
> exported in the kernel headers since commit 262576fffe42 (ARM: 7843/1:
> drop asm/types.h from generic-y) which dropped the generic-y += types.h.
> This happens because Makefile.headersinst still checks the old asm/
> directory if the specified header doesn't exist in the uapi directory.
>
> As far as I can tell the definitions in this file are intended only for
> use in the kernel, so add back the generic-y += types.h so that the
> generic asm/types.h is exported in kernel headers, but add it to the
> uapi Kbuild file to make it clearer what its purpose is.
>
> Also make the asm/types.h file include the generated <uapi/asm/types.h>
> rather than <asm-generic/int-ll64.h>, so that the use of int-ll64.h
> isn't duplicated between the asm-generic/types.h (for exported headers)
> and asm/types.h (for the kernel build).
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
> AFAICT the previously exported asm/types.h seemed to include definitions
> that changed the behaviour of <inttypes.h> (I could have misunderstood
> though). I presume it wasn't intended to be exported in kernel headers?

No it wasn't. The point of the change is to remove subtle
inconsistencies between kernels built with bare metal toolchains and
kernels built with glibc targeted toolchains, and this is hardly
something you want to expose externally.

> The comment suggests that this patch would change / fix the behaviour of
> userland code which includes the kernel headers and <inttypes.h>. I
> don't know enough about it to be sure of that though.

No it does not apply to userland code, only to kernel code that
[indirectly] includes <stdint.h>.

Regards,
Ard.
