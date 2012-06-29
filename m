From: andy.green@linaro.org (Andy Green)
Date: Fri, 29 Jun 2012 17:03:20 +0800
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
In-Reply-To: <201206290851.47054.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055516.11091.82899.stgit@build.warmcat.com>
 <201206290851.47054.arnd@arndb.de>
Message-ID: <4FED6F58.3090506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/12 16:51, the mail apparently from Arnd Bergmann included:
> On Friday 29 June 2012, Andy Green wrote:
>> +static int omap_panda_netdev_event(struct notifier_block *this,
>> +                                               unsigned long event, void *ptr)
>> +{
>> +       struct net_device *dev = ptr;
>> +       struct sockaddr sa;
>> +       int n;
>> +
>> +       if (event != NETDEV_REGISTER)
>> +               return NOTIFY_DONE;
>> +
>> +       n = omap_device_path_need_mac(dev->dev.parent);
>> +       if (n < 0)
>> +               return NOTIFY_DONE;
>> +
>> +       sa.sa_family = dev->type;
>> +       omap2_die_id_to_ethernet_mac(sa.sa_data, n);
>> +       dev->netdev_ops->ndo_set_mac_address(dev, &sa);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block omap_panda_netdev_notifier = {
>> +       .notifier_call = omap_panda_netdev_event,
>> +       .priority = 1,
>> +};
>> +
>> +int omap_register_mac_device_fixup_paths(const char * const *paths, int count)
>> +{
>> +       mac_device_fixup_paths = paths;
>> +       count_mac_device_fixup_paths = count;
>> +
>> +       return register_netdevice_notifier(&omap_panda_netdev_notifier);
>> +}
>
> The omap_panda_netdev_event and omap_panda_netdev_notifier symbols should probably
> lose the "panda_" part of their names, because they are now located in a common
> file and are not panda specific any more.

Good point thanks, I'll sort it out after waiting for any more comments.

-Andy

-- 
Andy Green | TI Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
