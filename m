From: rob@landley.net (Rob Landley)
Date: Sat, 25 May 2013 19:27:52 -0500
Subject: [PATCH] ARM: document the bigger pagetables needed for LPAE
In-Reply-To: <1369410236-22398-1-git-send-email-javi.merino@arm.com> (from
 javi.merino@arm.com on Fri May 24 10:43:56 2013)
Message-ID: <1369528072.2776.26@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2013 10:43:56 AM, Javi Merino wrote:
> The Booting documentation assumes that the initial pagetables are
> 16KiB but since 1b6ba46 (ARM: LPAE: MMU setup for the 3-level page
> table format) they are 20KiB for LPAE kernels.  Thus, the
> recommendation to put atags or the dtb in the first 16KiB is wrong,
> there's only 12KiB of space there in LPAE kernels, so update the
> documentation accordingly.
> ---
>  Documentation/arm/Booting |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Rob Landley <rob@landley.net>

With one comment:

> diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
> index 0c1f475..f6f9cd8 100644
> --- a/Documentation/arm/Booting
> +++ b/Documentation/arm/Booting
> @@ -105,7 +105,7 @@ The tagged list should be stored in system RAM.
> 
>  The tagged list must be placed in a region of memory where neither
>  the kernel decompressor nor initrd 'bootp' program will overwrite
> -it.  The recommended placement is in the first 16KiB of RAM.
> +it.  The recommended placement is in the first 12KiB of RAM.
> 
>  4b. Setup the device tree
>  -------------------------
> @@ -120,7 +120,7 @@ tagged list.
>  The boot loader must pass at a minimum the size and location of the
>  system memory, and the root filesystem location.  The dtb must be
>  placed in a region of memory where the kernel decompressor will not
> -overwrite it.  The recommended placement is in the first 16KiB of RAM
> +overwrite it.  The recommended placement is in the first 12KiB of RAM
>  with the caveat that it may not be located at physical address 0  
> since
>  the kernel interprets a value of 0 in r2 to mean neither a tagged  
> list
>  nor a dtb were passed.
> @@ -137,8 +137,9 @@ then it is legal for the boot loader to call the  
> zImage in flash
>  directly.
> 
>  The zImage may also be placed in system RAM (at any location) and
> -called there.  Note that the kernel uses 16K of RAM below the image
> -to store page tables.  The recommended placement is 32KiB into RAM.
> +called there.  Note that the kernel may use up to 20KiB of RAM below
> +the image to store page tables.  The recommended placement is 32KiB
> +into RAM.

Now that we have three memory entires, possibly some sort of memory  
layout would be in order?

    0k-12k   boot data (tagged list or device tree)
   12k-32k   page tables
   32k-xxx   kernel image

Perhaps at the end of section 4's introduction? It's not quite obvious  
from the document...

Rob
