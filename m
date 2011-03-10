From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Thu, 10 Mar 2011 10:58:36 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110309174752.GC1225@sirena.org.uk>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110309174752.GC1225@sirena.org.uk>
Message-ID: <4D78A0CC.1030705@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 06:47 PM, Mark Brown wrote:
> On Wed, Mar 09, 2011 at 05:59:20PM +0100, Maxime Coquelin wrote:
>
>> +config SYS_SOC
>> +	bool "Export SoC specific informations"
>> +	depends on EMBEDDED
>> +
>>   endmenu
> Would it not be better for this to depend on a symbol that systems can
> select when they add useful output?  If there's nothing that generates
> information for it on a given platform there's no point in enabling it.
>

It is deactivated by default when "default" parameter is not mentioned.

>> +static ssize_t show_info(struct sysdev_class *class,
>> +				struct sysdev_class_attribute *attr, char *buf)
>> +{
>> +	struct sys_soc_info *si = container_of(attr,
>> +			struct sys_soc_info, attr);
>> +
>> +	if (si->info)
>> +		return sprintf(buf, "%s\n", si->info);
>> +	else if (si->get_info)
>> +		return sprintf(buf, "%s\n", si->get_info(si));
> It seems like it'd be easier to pass the output buffer directly to
> get_info(), otherwise the get_info() implementation will have to figure
> out a buffer to return data from.

You're right, I will propose a path with passing the output buffer directly.

Regards,
Maxime
