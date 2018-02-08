From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:54:59 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135459.GF10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

>  /* Call func with each event in the json file */
>  int json_events(const char *fn,
>  	  int (*func)(void *data, char *name, char *event, char *desc,
> @@ -442,6 +550,7 @@ int json_events(const char *fn,
>  		char *metric_expr = NULL;
>  		char *metric_name = NULL;
>  		char *metric_group = NULL;
> +		char *arch_std = NULL;
>  		unsigned long long eventcode = 0;
>  		struct msrmap *msr = NULL;
>  		jsmntok_t *msrval = NULL;
> @@ -527,6 +636,10 @@ int json_events(const char *fn,
>  				addfield(map, &metric_expr, "", "", val);
>  				for (s = metric_expr; *s; s++)
>  					*s = tolower(*s);
> +			} else if (json_streq(map, field, "ArchStdEvent")) {
> +				addfield(map, &arch_std, "", "", val);
> +				for (s = arch_std; *s; s++)
> +					*s = tolower(*s);
>  			}
>  			/* ignore unknown fields */
>  		}
> @@ -538,7 +651,7 @@ int json_events(const char *fn,
>  				addfield(map, &extra_desc, " ",
>  						"(Precise event)", NULL);
>  		}
> -		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
> +		snprintf(buf, sizeof(buf), "%s%#llx", EVENT_PREFIX, eventcode);
>  		addfield(map, &event, ",", buf, NULL);
>  		if (desc && extra_desc)
>  			addfield(map, &desc, " ", extra_desc, NULL);
> @@ -550,9 +663,21 @@ int json_events(const char *fn,
>  			addfield(map, &event, ",", msr->pname, msrval);
>  		if (name)
>  			fixname(name);
> -
> -		err = func(data, name, real_event(name, event), desc, long_desc,
> -			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
> +		err = 0;
> +		if (arch_std) {
> +			/*
> +			 * An arch standard event is referenced, so try to
> +			 * fixup any unassigned values.
> +			 */
> +			err = try_fixup(fn, arch_std, &event, &desc, &name,
> +					&long_desc, &pmu, &filter, &perpkg,
> +					&unit, &metric_expr, &metric_name,
> +					&metric_group);
> +		}
> +		if (!err)
> +			err = func(data, name, real_event(name, event), desc,
> +				   long_desc, pmu, unit, perpkg, metric_expr,
> +				   metric_name, metric_group);
>  		free(event);
>  		free(desc);
>  		free(name);
> @@ -565,6 +690,7 @@ int json_events(const char *fn,
>  		free(metric_expr);
>  		free(metric_name);
>  		free(metric_group);
> +

should you call free(arch_std) in here?

jirka
