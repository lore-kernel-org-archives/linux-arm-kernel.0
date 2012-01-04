From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jan 2012 15:42:17 -0800
Subject: [PATCH 6/9] arm/tegra: emc: convert tegra2_emc to a platform
 driver
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F158A@HQMAIL01.nvidia.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-7-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F158A@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhE+==YRUbSj9GQ32tRjFR7WcSZ7KifNMmUqrPkHJPGmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 3:39 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
>> This is the first step in making it device-tree aware and get rid of the
>> in-kernel EMC tables (of which there are none in mainline, thankfully).
>
>> -void tegra_init_emc(const struct tegra_emc_table *table, int table_size)
>> +static int __devinit tegra_emc_probe(struct platform_device *pdev)
>> +{
> ...
>> + ? ? }
>> +
>> + ? ? ? ?res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? ? ?if (!res) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "missing register base\n");
>> + ? ? ? ? ? ? ? ?return -ENOMEM;
>> + ? ? ? ?}
>> +
>> + ? ? if (!request_mem_region(res->start, resource_size(res), "tegra_emc")) {
>
> Something is wrong with the indentation there.
>
>> + ? ? /* Since default max_rate on emc clock is the same as firmware set
>> + ? ? ?* it to before booting, raise it up here based on known timings.
>> + ? ? ?*/
>> +
>> + ? ? for (i = 0; i < pdata->num_tables; i++)
>> + ? ? ? ? ? ? if (pdata->tables[i].rate > max)
>> + ? ? ? ? ? ? ? ? ? ? max = pdata->tables[i].rate;
>> +
>> + ? ? c->max_rate = max * 2 * 1000;
>> +
>> + ? ? list_for_each_entry(user, &c->shared_bus_list, u.shared_bus_user.node)
>> + ? ? ? ? ? ? user->max_rate = c->max_rate;
>
> Hmm. I guess that works OK for now. Using some kind of accessor might
> be nice; I'm not sure how that could be implemented once there's a
> common clock framework, and this code can't touch the clock internals.

Oh dear, that code should have been ripped out in the patch I posted.
It is definitely not to be left in there.

We're going to assume that firmware boots the system at maximum
performance so the above shouldn't be needed. I guess I could add a
warning for cases where different operation is detected.


-Olof
