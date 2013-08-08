From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Aug 2013 22:54:29 +0100
Subject: [PATCH v2] arm: update advice on kernel, initramfs and FDT load
 address.
In-Reply-To: <1375974974-31603-1-git-send-email-ian.campbell@citrix.com>
References: <1375974974-31603-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20130808215429.GG19383@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 04:16:14PM +0100, Ian Campbell wrote:
> diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
> index 0c1f475..6fcd45e 100644
> --- a/Documentation/arm/Booting
> +++ b/Documentation/arm/Booting
> @@ -18,7 +18,8 @@ following:
>  2. Initialise one serial port.
>  3. Detect the machine type.
>  4. Setup the kernel tagged list.
> -5. Call the kernel image.
> +5. Load initramfs.
> +6. Call the kernel image.
>  
>  
>  1. Setup and initialise RAM
> @@ -120,12 +121,27 @@ tagged list.
>  The boot loader must pass at a minimum the size and location of the
>  system memory, and the root filesystem location.  The dtb must be
>  placed in a region of memory where the kernel decompressor will not
> -overwrite it.  The recommended placement is in the first 16KiB of RAM
> -with the caveat that it may not be located at physical address 0 since
> -the kernel interprets a value of 0 in r2 to mean neither a tagged list
> -nor a dtb were passed.
> +overwrite it while also with the region which will be covered by the
> +kernel's low-memory mapping.

s/with/within/ ?

> -5. Calling the kernel image
> +A safe location is just above the 128MiB boundary from start of RAM.
> +
> +5. Load initramfs.
> +------------------
> +
> +Existing boot loaders:		OPTIONAL
> +New boot loaders:		OPTIONAL
> +
> +If an initramfs is in use then, as with the dtb, it must be placed in
> +a region of memory where the kernel decompressor will not overwrite it
> +while also with the region which will be covered by the kernel's

Hmm, same thing here. Maybe `...will not overwrite it, whilst remaining in the
region...'?

Will
