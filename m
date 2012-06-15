From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 09:13:57 -0300
Subject: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
In-Reply-To: <201206151349.27261.marex@denx.de>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
 <1339759950-5507-2-git-send-email-festevam@gmail.com>
 <201206151349.27261.marex@denx.de>
Message-ID: <CAOMZO5BKKwg-E3=vx8C3GKD7NbwZKBfy8SBZBU-W3vYuU4sAJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 8:49 AM, Marek Vasut <marex@denx.de> wrote:

>> +/*
>> + * This function returns 1 if pdev isn't a device instatiated by dt, 0 if
>> it + * could successfully get all information from dt or a negative errno.
>> + */
>> +static int serial_mxs_probe_dt(struct mxs_auart_port *s,
>> + ? ? ? ? ? ? struct platform_device *pdev)
>> +{
>> + ? ? struct device_node *np = pdev->dev.of_node;
>> + ? ? int ret;
>> +
>> + ? ? if (!np)
>> + ? ? ? ? ? ? /* no device tree device */
>> + ? ? ? ? ? ? return 1;
>> +
>> + ? ? ret = of_alias_get_id(np, "serial");
>> + ? ? if (ret < 0) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
>> + ? ? ? ? ? ? return ret;
>> + ? ? }
>> + ? ? s->port.line = ret;
>> +
>> + ? ? return 0;
>> +}
>> +#else
>> +static inline int serial_mxs_probe_dt(struct mxs_auart_port *s,
>> + ? ? ? ? ? ? struct platform_device *pdev)
>> +{
>> + ? ? return 1;
>> +}
>> +#endif
>
> So drop this whole ifdef stuff ...

Yes, you are right. We can safely remove it. Just tested and it worked fine.

I will drop the ifdef in the next revision.

Thanks,

Fabio Estevam
