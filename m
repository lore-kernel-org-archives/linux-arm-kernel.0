From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Thu, 10 Mar 2011 10:45:12 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110309173902.GD2737@pulham.picochip.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110309173902.GD2737@pulham.picochip.com>
Message-ID: <4D789DA8.7080703@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 06:39 PM, Jamie Iles wrote:
> Hi Maxime,
>
> Thanks for doing this, it looks very nice!  A couple of nitpicks, but
> I've given it a quick spin on my platform and it provides us with all of
> the hooks to export all of the information we need.
>
> Jamie

Hi Jamie,
Thanks for your review. Fine it works for you.

> +
> +static struct sysdev_class_attribute *soc_default_attrs[];
> +
> +struct sys_soc {
> +	char *mach_name;
> Can this be made const?

Yes, you're right.

>> +
>> +	if (si->info)
>> +		return sprintf(buf, "%s\n", si->info);
>> +	else if (si->get_info)
>> +		return sprintf(buf, "%s\n", si->get_info(si));
>> +	else
>> +		return sprintf(buf, "No data\n");
> Isn't this a platform error if we don't have a way to get the required
> info?  If in register_sys_soc_info() we check that one of si->info or
> si->get_info is non-NULL then we don't need this check.  If we have
> something like:
>
> static bool sys_soc_info_is_valid(struct sys_soc_info *info)
> {
> 	if ((!info->info&&  !info->get_info) ||
> 	    info->info&&  info->get_info)
> 	    return false;
>
> 	return true;
> }

Yes it is a platform error, it should be tested at registration time.

> then we can do this at registration.  Is there a valid use case where
> someone could set the static info and the dynamic get_info callback?
>

At registration, no. But in the get_info callback, we can set the info 
field in order to call the callback once if the value will never change.
However, I will remove this possibility as it is not clear.

>
> Make name const?  Also, should num be a size_t?

Fixed

> soc.mach_name = kstrdup(name, GFP_KERNEL) instead of the allocate and
> sprintf?
>

Fixed.

>> +struct sys_soc_info {
>> +	char *name;
>> +	char *info;
>> +	char *(*get_info)(struct sys_soc_info *);
> Could this return a const char* ?
>

Fixed.

>> +	struct sysdev_class_attribute attr;
>> +};
>> +
>> +/**
>> + * void register_sys_soc(char *name, struct sys_soc_info *, int num)
> I think this should be "register_sys_soc - register the soc information"
> for valid kerneldoc notation..

Fixed.

Regards,
Maxime
