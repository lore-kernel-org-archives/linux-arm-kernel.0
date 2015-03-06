From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 06 Mar 2015 13:11:52 -0500
Subject: [PATCH v3 2/3] of: add optional options parameter to
 of_find_node_by_path()
In-Reply-To: <20150306165253.GJ4278@bivouac.eciton.net>
References: <1417110967-16284-1-git-send-email-leif.lindholm@linaro.org>
 <1417110967-16284-3-git-send-email-leif.lindholm@linaro.org>
 <54F7287E.6060302@hurleysoftware.com>
 <20150306165253.GJ4278@bivouac.eciton.net>
Message-ID: <54F9EDE8.1090902@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2015 11:52 AM, Leif Lindholm wrote:
> Hi Peter,
> 
> On Wed, Mar 04, 2015 at 10:45:02AM -0500, Peter Hurley wrote:
>> The path parsing gets lost if the string after ':' contains '/'.
> 
> Doh!

Hardly.

I only noticed because I had to implement the corresponding algorithm
for earlycon and FDT, where the string scanning is obvious.

> Thanks for reporting (and sorry for slow response).

No worries :)

Rather, I'd like to thank you for implementing the options string so
that bootloader -> earlycon -> console works so seamlessly now.
Can't wait to see 3000000Mb/s console from boot.

And thanks for the quick patch. I'm still testing because, while there weren't
those failures, there were some other messages. So I just need to go back
and see if those are regressions.


>> The selftests below fail with:
>> [    1.365528] ### dt-test ### FAIL of_selftest_find_node_by_name():99 option path test failed
>> [    1.365610] ### dt-test ### FAIL of_selftest_find_node_by_name():115 option alias path test failed
>>
>> Regards,
>> Peter Hurley
>>
>>
>> --- >% ---
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 41a4a13..07ba5aa 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -94,6 +94,11 @@ static void __init of_selftest_find_node_by_name(void)
>>  		 "option path test failed\n");
>>  	of_node_put(np);
>>  
>> +	np = of_find_node_opts_by_path("/testcase-data:test/option", &options);
>> +	selftest(np && !strcmp("test/option", options),
>> +		 "option path test failed\n");
>> +	of_node_put(np);
>> +
>>  	np = of_find_node_opts_by_path("/testcase-data:testoption", NULL);
>>  	selftest(np, "NULL option path test failed\n");
>>  	of_node_put(np);
>> @@ -104,6 +109,12 @@ static void __init of_selftest_find_node_by_name(void)
>>  		 "option alias path test failed\n");
>>  	of_node_put(np);
>>  
>> +	np = of_find_node_opts_by_path("testcase-alias:test/alias/option",
>> +				       &options);
>> +	selftest(np && !strcmp("test/alias/option", options),
>> +		 "option alias path test failed\n");
>> +	of_node_put(np);
>> +
>>  	np = of_find_node_opts_by_path("testcase-alias:testaliasoption", NULL);
>>  	selftest(np, "NULL option alias path test failed\n");
>>  	of_node_put(np);
> 
> Could you give the below a spin, and if it works for you, send me the
> above tests as a full patch so that I can post both as a series?

Will do as soon as I finish testing.

Regards,
Peter Hurley


> From bf4ab0b2e33902ba88809a3c4a2cdf07efd02dde Mon Sep 17 00:00:00 2001
> From: Leif Lindholm <leif.lindholm@linaro.org>
> Date: Fri, 6 Mar 2015 16:38:54 +0000
> Subject: [PATCH] of: fix handling of '/' in options for of_find_node_by_path()
> 
> Ensure proper handling of paths with appended options (after ':'),
> where those options may contain a '/'.
> 
> Fixes: 7914a7c5651a ("of: support passing console options with stdout-path")
> Reported-by: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/of/base.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 0a8aeb8..8b904e5 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -714,16 +714,17 @@ static struct device_node *__of_find_node_by_path(struct device_node *parent,
>  						const char *path)
>  {
>  	struct device_node *child;
> -	int len = strchrnul(path, '/') - path;
> -	int term;
> +	int len;
> +	const char *end;
>  
> +	end = strchr(path, ':');
> +	if (!end)
> +		end = strchrnul(path, '/');
> +
> +	len = end - path;
>  	if (!len)
>  		return NULL;
>  
> -	term = strchrnul(path, ':') - path;
> -	if (term < len)
> -		len = term;
> -
>  	__for_each_child_of_node(parent, child) {
>  		const char *name = strrchr(child->full_name, '/');
>  		if (WARN(!name, "malformed device_node %s\n", child->full_name))
> @@ -768,8 +769,12 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
>  
>  	/* The path could begin with an alias */
>  	if (*path != '/') {
> -		char *p = strchrnul(path, '/');
> -		int len = separator ? separator - path : p - path;
> +		int len;
> +		const char *p = separator;
> +
> +		if (!p)
> +			p = strchrnul(path, '/');
> +		len = p - path;
>  
>  		/* of_aliases must not be NULL */
>  		if (!of_aliases)
> @@ -794,6 +799,8 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
>  		path++; /* Increment past '/' delimiter */
>  		np = __of_find_node_by_path(np, path);
>  		path = strchrnul(path, '/');
> +		if (separator && separator < path)
> +			break;
>  	}
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  	return np;
> 
