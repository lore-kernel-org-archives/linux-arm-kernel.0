From: dsahern@gmail.com (David Ahern)
Date: Wed, 21 Jan 2015 17:53:47 -0700
Subject: [PATCH 2/2] perf symbols: debuglink should take symfs option
 into account
In-Reply-To: <CAA3XUr0uXykCTVuw-sYmkhsFZ-cimeuJkXTXNdJyhJh7976xEQ@mail.gmail.com>
References: <1421168344-5363-1-git-send-email-victor.kamensky@linaro.org>	<1421168344-5363-2-git-send-email-victor.kamensky@linaro.org>	<CAA3XUr1BnS=8RTVyxtVOm4Ahb2DQXUuJJQC1w2SvT5fycjRcEQ@mail.gmail.com>	<54C0216F.3080404@gmail.com>
 <CAA3XUr0uXykCTVuw-sYmkhsFZ-cimeuJkXTXNdJyhJh7976xEQ@mail.gmail.com>
Message-ID: <54C04A1B.8040408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/21/15 5:34 PM, Victor Kamensky wrote:
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 45be944..ca8d8d5 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -45,13 +45,13 @@ int dso__read_binary_type_filename(const struct dso *dso,
>       case DSO_BINARY_TYPE__DEBUGLINK: {
>           char *debuglink;
>
> -        strncpy(filename, dso->long_name, size);
> -        debuglink = filename + dso->long_name_len;
> +        len = __symbol__join_symfs(filename, size, dso->long_name);
> +        debuglink = filename + len;
>           while (debuglink != filename && *debuglink != '/')
>               debuglink--;
>           if (*debuglink == '/')
>               debuglink++;
> -        ret = filename__read_debuglink(dso->long_name, debuglink,
> +        ret = filename__read_debuglink(filename, debuglink,
>                              size - (debuglink - filename));
>           }
>           break;
>

I do not see any reason this will not work. Essentially after 
filename__read_debuglink filename contains symfs + dso path + debuglink 
read from .gnu_debuglink section which is what is wanted.

Thanks for the example. I used it with both a symfs and non-symfs 
example and both times this change worked properly -- the correct 
hang.debug file is read.

Arnaldo?

David
