From: mmarek@suse.com (Michal Marek)
Date: Tue, 24 Nov 2015 11:20:43 +0100
Subject: [PATCH] Kbuild: disable 'maybe-uninitialized' warning for
 CONFIG_PROFILE_ALL_BRANCHES
In-Reply-To: <3799453.oCg1CdOrtm@wuerfel>
References: <3799453.oCg1CdOrtm@wuerfel>
Message-ID: <565439FB.6050800@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-23 17:26, Arnd Bergmann wrote:
> These are all false positives that either rob someone's time when trying
> to figure out whether they are real, or they get people to send wrong
> patches to shut up the warnings.
[...]
> diff --git a/Makefile b/Makefile
> index 5e01a416c6e4..f8b921658f29 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,11 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
>  else
> -KBUILD_CFLAGS	+= -O2
> +ifdef CONFIG_PROFILE_ALL_BRANCHES
> +KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
> +else
> +KBUILD_CFLAGS   += -O2
> +endif

Does it only happen with -O2? Normally, we would add it outside the
ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.

Michal
