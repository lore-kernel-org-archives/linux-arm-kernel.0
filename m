From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 21 Jul 2016 09:47:31 +0200
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160721074731.GC7192@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 02:38:17PM -0600, Mathieu Poirier wrote:

SNIP

> +static int get_config_terms(struct list_head *head_config,
> +			    struct list_head *head_terms)
> +{
>  	struct parse_events_term *term;
>  
>  	list_for_each_entry(term, head_config, list) {
>  		switch (term->type_term) {
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
> +			ADD_CONFIG_TERM(PERIOD, period,
> +					term->val.num, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
> +			ADD_CONFIG_TERM(FREQ, freq, term->val.num, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_TIME:
> -			ADD_CONFIG_TERM(TIME, time, term->val.num);
> +			ADD_CONFIG_TERM(TIME, time, term->val.num, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
> +			ADD_CONFIG_TERM(CALLGRAPH, callgraph,
> +					term->val.str, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
> +			ADD_CONFIG_TERM(STACK_USER, stack_user,
> +					term->val.num, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM(INHERIT, inherit,
> +					term->val.num ? 1 : 0, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM(INHERIT, inherit,
> +					term->val.num ? 0 : 1, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
> +			ADD_CONFIG_TERM(MAX_STACK, max_stack,
> +					term->val.num, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM(OVERWRITE, overwrite,
> +					term->val.num ? 1 : 0, head_terms);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM(OVERWRITE, overwrite,
> +					term->val.num ? 0 : 1, head_terms);
>  			break;

I think it'd be better to have all terms altogether,
and handle the 'case PARSE_EVENTS__TERM_TYPE_DRV_CFG:'
in here, rather than in separate function

also ADD_CONFIG_TERM macro could stay local to the
function with no need of adding new head arguments

thanks,
jirka

>  		default:
>  			break;
> @@ -1142,6 +1158,21 @@ do {								\
>  	return 0;
>  }
>  
> +static int get_drv_config_terms(struct list_head *head_config,
> +				struct list_head *head_terms)
> +{
> +	struct parse_events_term *term;
> +
> +	list_for_each_entry(term, head_config, list) {
> +		if (term->type_term != PARSE_EVENTS__TERM_TYPE_DRV_CFG)
> +			continue;
> +
> +		ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str, head_terms);
> +	}
> +
> +	return 0;
> +}

SNIP
