From: jiri@resnulli.us (Jiri Pirko)
Date: Tue, 13 Jan 2015 15:36:35 +0100
Subject: [PATCH] rocker: fix harmless warning on 32-bit machines
In-Reply-To: <4047824.AYNhYQQ6UI@wuerfel>
References: <4047824.AYNhYQQ6UI@wuerfel>
Message-ID: <20150113143635.GB1839@nanopsycho.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, Jan 13, 2015 at 03:23:52PM CET, arnd at arndb.de wrote:
>The rocker driver tries to assign a pointer to a 64-bit integer
>and then back to a pointer. This is safe on all architectures,
>but causes a compiler warning when pointers are shorter than
>64-bit:
>
>rocker/rocker.c: In function 'rocker_desc_cookie_ptr_get':
>rocker/rocker.c:809:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  return (void *) desc_info->desc->cookie;
>         ^
>
>This adds another cast to uintptr_t to tell the compiler
>that it's safe.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Acked-by: Jiri Pirko <jiri@resnulli.us>

>
>diff --git a/drivers/net/ethernet/rocker/rocker.c b/drivers/net/ethernet/rocker/rocker.c
>index 2f398fa4b9e6..cad8cf962cdf 100644
>--- a/drivers/net/ethernet/rocker/rocker.c
>+++ b/drivers/net/ethernet/rocker/rocker.c
>@@ -806,13 +806,13 @@ static bool rocker_desc_gen(struct rocker_desc_info *desc_info)
> 
> static void *rocker_desc_cookie_ptr_get(struct rocker_desc_info *desc_info)
> {
>-	return (void *) desc_info->desc->cookie;
>+	return (void *)(uintptr_t)desc_info->desc->cookie;
> }
> 
> static void rocker_desc_cookie_ptr_set(struct rocker_desc_info *desc_info,
> 				       void *ptr)
> {
>-	desc_info->desc->cookie = (long) ptr;
>+	desc_info->desc->cookie = (uintptr_t) ptr;
> }
> 
> static struct rocker_desc_info *
>
