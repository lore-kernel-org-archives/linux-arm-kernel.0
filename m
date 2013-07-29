From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jul 2013 14:50:01 +0100
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20130729135000.GK32383@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

/me plays English teacher :)

On Mon, Jul 29, 2013 at 01:56:18PM +0100, Ian Campbell wrote:
> Based on the discussion in [0]:
>   - Recommend that the kernel be placed under 128MiB ("for automatic RAM
>     location to work", says Nico)
>   - Recommend that DTB larger than ~16KiB be placed after the 128MiB boundary
>     (in order to avoid conflicting with the kernel decompressor, kernel is at
>     most 32MiB) and within the lowmem region. Somewhat arbitrarily recommend
>     placement below the 256MiB boundary, the real lowmem limit is likely up
>     around 600-800MiB but varies.
> 
> [0] http://article.gmane.org/gmane.linux.ports.arm.kernel/254538
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  Documentation/arm/Booting |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
> index 0c1f475..72c035e 100644
> --- a/Documentation/arm/Booting
> +++ b/Documentation/arm/Booting
> @@ -125,6 +125,13 @@ with the caveat that it may not be located at physical address 0 since
>  the kernel interprets a value of 0 in r2 to mean neither a tagged list
>  nor a dtb were passed.
>  
> +If the DTB is larger than ~16KiB, such that placement in the first
> +16KiB would lead to a conflict with the kernel loaded at 32KiB (as
> +recommended below) which uses the memory between 16KiB-32KiB itself,
> +then the DTB should be placed after the first 128MiB of RAM in order
> +to avoid conflicting with the kernel decompressor. The recommnded

recommended

It also looks like you're repeating part of what is said later regarding the
16k of page tables below the image. Also, we use 20k with LPAE.

> +placement in this case just below the 256MiB boundary.
> +
>  5. Calling the kernel image
>  ---------------------------
>  
> @@ -136,9 +143,10 @@ is stored in flash, and is linked correctly to be run from flash,
>  then it is legal for the boot loader to call the zImage in flash
>  directly.
>  
> -The zImage may also be placed in system RAM (at any location) and
> -called there.  Note that the kernel uses 16K of RAM below the image
> -to store page tables.  The recommended placement is 32KiB into RAM.
> +The zImage may also be placed in system RAM and called there.  The
> +kernel should be placed in the first 128MiB of RAM. Note that the
> +kernel uses 16KiB of RAM below the image to store page tables.  The
> +recommended placement is 32KiB into RAM.

This is a bit clunky since you say that the zImage may be placed in system
RAM, then restrict that in the next sentence.

Will
