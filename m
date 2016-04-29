From: panand@redhat.com (Pratyush Anand)
Date: Fri, 29 Apr 2016 20:27:43 +0530
Subject: [PATCH 09/12] kexec: ensure user memory sizes do not wrap
In-Reply-To: <E1aviFK-0000jY-1S@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFK-0000jY-1S@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHB_GupLrhak5CrTQE9976Pq0RFRaXWf5r--rjKmnBNU1oyK9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 2:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Ensure that user memory sizes do not wrap around when validating the
> user input, which can lead to the following input validation working
> incorrectly.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 8d34308ea449..d719a4d0ef55 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
>
>                 mstart = image->segment[i].mem;
>                 mend   = mstart + image->segment[i].memsz;
> +               if (mstart > mend)
> +                       return result;
>                 if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
>                         return result;
>                 if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)

Reviewed-by: Pratyush Anand <panand@redhat.com>
