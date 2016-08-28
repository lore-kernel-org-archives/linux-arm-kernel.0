From: jolsa@redhat.com (Jiri Olsa)
Date: Sun, 28 Aug 2016 16:16:11 +0200
Subject: [PATCH V6 1/5] perf tools: making coresight PMU listable
In-Reply-To: <1472156445-24283-2-git-send-email-mathieu.poirier@linaro.org>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
 <1472156445-24283-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160828141611.GA32293@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:20:41PM -0600, Mathieu Poirier wrote:

SNIP

>  ARM/CORGI MACHINE SUPPORT
>  M:	Richard Purdie <rpurdie@rpsys.net>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 24803c58049a..72edf83d76b7 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -746,10 +746,13 @@ ifdef LIBBABELTRACE
>  endif
>  
>  ifndef NO_AUXTRACE
> -  ifeq ($(feature-get_cpuid), 0)
> -    msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
> -    NO_AUXTRACE := 1
> -  else
> +  ifeq ($(ARCH),x86)
> +    ifeq ($(feature-get_cpuid), 0)
> +      msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
> +      NO_AUXTRACE := 1
> +    endif
> +  endif
> +  ifndef NO_AUXTRACE

hum, how's this hunk connected to the issue described in changelog?

thanks,
jirka

>      $(call detected,CONFIG_AUXTRACE)
>      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
>    endif

SNIP
