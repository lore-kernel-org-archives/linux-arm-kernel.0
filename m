From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Nov 2018 12:04:04 +0100 (CET)
Subject: [PATCH 8/9] drm: remove no longer needed drm-get-put coccinelle
 script
In-Reply-To: <20181115221634.22715-9-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-9-greenfoo@gluegarage.com>
Message-ID: <alpine.DEB.2.21.1811181203410.3530@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 15 Nov 2018, Fernando Ramos wrote:

> The coccinelle script was used to rename some (deprecated) functions
> which no longer exist now.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  scripts/coccinelle/api/drm-get-put.cocci | 78 ------------------------
>  1 file changed, 78 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/drm-get-put.cocci
>
> diff --git a/scripts/coccinelle/api/drm-get-put.cocci b/scripts/coccinelle/api/drm-get-put.cocci
> deleted file mode 100644
> index 3a09c97ad87d..000000000000
> --- a/scripts/coccinelle/api/drm-get-put.cocci
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -///
> -/// Use drm_*_get() and drm_*_put() helpers instead of drm_*_reference() and
> -/// drm_*_unreference() helpers.
> -///
> -// Confidence: High
> -// Copyright: (C) 2017 NVIDIA Corporation
> -// Options: --no-includes --include-headers
> -//
> -
> -virtual patch
> -virtual report
> -
> - at depends on patch@
> -expression object;
> -@@
> -
> -(
> -- drm_connector_reference(object)
> -+ drm_connector_get(object)
> -|
> -- drm_connector_unreference(object)
> -+ drm_connector_put(object)
> -|
> -- drm_framebuffer_reference(object)
> -+ drm_framebuffer_get(object)
> -|
> -- drm_framebuffer_unreference(object)
> -+ drm_framebuffer_put(object)
> -|
> -- drm_gem_object_reference(object)
> -+ drm_gem_object_get(object)
> -|
> -- drm_gem_object_unreference(object)
> -+ drm_gem_object_put(object)
> -|
> -- __drm_gem_object_unreference(object)
> -+ __drm_gem_object_put(object)
> -|
> -- drm_gem_object_unreference_unlocked(object)
> -+ drm_gem_object_put_unlocked(object)
> -|
> -- drm_dev_unref(object)
> -+ drm_dev_put(object)
> -)
> -
> - at r depends on report@
> -expression object;
> -position p;
> -@@
> -
> -(
> -drm_connector_unreference at p(object)
> -|
> -drm_connector_reference at p(object)
> -|
> -drm_framebuffer_unreference at p(object)
> -|
> -drm_framebuffer_reference at p(object)
> -|
> -drm_gem_object_unreference at p(object)
> -|
> -drm_gem_object_reference at p(object)
> -|
> -__drm_gem_object_unreference(object)
> -|
> -drm_gem_object_unreference_unlocked(object)
> -|
> -drm_dev_unref at p(object)
> -)
> -
> - at script:python depends on report@
> -object << r.object;
> -p << r.p;
> -@@
> -
> -msg="WARNING: use get/put helpers to reference and dereference %s" % (object)
> -coccilib.report.print_report(p[0], msg)
> --
> 2.19.1
>
>
