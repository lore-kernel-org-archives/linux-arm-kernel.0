From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 16 Feb 2011 14:06:03 +0100
Subject: [PATCH] collie: do actually pass locomo_info to locomo driver
In-Reply-To: <1296775934-9903-1-git-send-email-dbaryshkov@gmail.com>
References: <1296775934-9903-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <AANLkTi=AC+ZB1z=u2eduk8_ayCMs3XTAUHw1tmhiM6bT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 12:32 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> locomo_info isn't actually used as a platform_data on collie platform:
> ?arm/mach-sa1100/collie.c:237: warning: ?locomo_info? defined but not used
>
> So locomo driver doesn't setup IRQs correctly. Pass locomo_info to the
> driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: stable at kernel.org
> ---
> ?arch/arm/mach-sa1100/collie.c | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index d43c5ef..bd3e1bf 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -241,6 +241,9 @@ static struct locomo_platform_data locomo_info = {
> ?struct platform_device collie_locomo_device = {
> ? ? ? ?.name ? ? ? ? ? = "locomo",
> ? ? ? ?.id ? ? ? ? ? ? = 0,
> + ? ? ? .dev ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &locomo_info,
> + ? ? ? },
> ? ? ? ?.num_resources ?= ARRAY_SIZE(locomo_resources),
> ? ? ? ?.resource ? ? ? = locomo_resources,
> ?};
> --
> 1.7.2.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
The issue is confirmed (see log   http://pastebin.com/se3BMrmU )

#locomokbd: Can't get irq for keyboard
#locomokbd: probe of locomo-keyboard failed with error -22

Please apply this trivial fix, thx.
Tested on real hw by OpenEmbedded developers.

Regards

Andrea
