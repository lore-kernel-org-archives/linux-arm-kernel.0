From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 29 Nov 2017 16:30:33 -0800
Subject: [PATCH 6/7] arm64: explicitly pass --no-fix-cortex-a53-843419 to
 GNU gold
In-Reply-To: <20171129234442.655-7-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-7-samitolvanen@google.com>
Message-ID: <CAKwvOdnhdHKvkLsG+3D5KDJ+jzXeWFPd9X+eDphA4xf5NZoDnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 3:44 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> @@ -26,10 +26,19 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
>    ifeq ($(call ld-option, --fix-cortex-a53-843419),)
>  $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
>    else
> +    ifeq ($(call gold-ifversion, -lt, 114000000, y), y)
> +$(warning This version of GNU gold may generate incorrect code with --fix-cortex-a53-843419;\
> +       see https://sourceware.org/bugzilla/show_bug.cgi?id=21491)
> +    endif
>  LDFLAGS_vmlinux        += --fix-cortex-a53-843419
>    endif
>  endif
>
> +ifeq ($(CONFIG_ARM64_ERRATUM_843419),)
> +# https://sourceware.org/bugzilla/show_bug.cgi?id=21491
> +LDFLAGS_GOLD   += --no-fix-cortex-a53-843419
> +endif
> +

Rather than:

if CONFIG_ARM64_ERRATUM_843419 == y:
  ...
if CONFIG_ARM64_ERRATUM_843419 == '':
  ...

could this be:

if CONFIG_ARM64_ERRATUM_843419 == y:
  ...
else
  ...

?
