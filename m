From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 23 Oct 2010 12:09:01 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <1287704855.12734.14.camel@maxim-laptop>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<1287704855.12734.14.camel@maxim-laptop>
Message-ID: <AANLkTi=iC1uKyToEXrroOj+JxQ2mW97WRVEXjv+9oQEa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxim,

On Fri, Oct 22, 2010 at 1:47 AM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Wed, 2010-10-13 at 09:31 +0200, Ohad Ben-Cohen wrote:
>> Fix SDIO suspend/resume regression introduced by
>> 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e "mmc: fix all hangs related to
>> mmc/sd card insert/removal during suspend/resume":
...
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index c94565d..515ff39 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
>> ? ? ? if (host->bus_ops && !host->bus_dead) {
>> ? ? ? ? ? ? ? if (host->bus_ops->suspend)
>> ? ? ? ? ? ? ? ? ? ? ? err = host->bus_ops->suspend(host);
>> + ? ? ? ? ? ? if (err == -ENOSYS || !host->bus_ops->resume) {
> This reintroduces the bug I fixed.
>
> if the CONFIG_MMC_UNSAFE_RESUME isn't set (and that is default
> unfortunately), the host->bus_ops->resume will be NULL (see core/mmc.c
> mmc_ops), and therefore card will be removed, that will trigger a block
> device removal, sync, and deadlock).

Have you reproduced this or is it just a general concern ?

I'm asking this because if CONFIG_MMC_UNSAFE_RESUME isn't set, then
mmc_pm_notify() will remove the card and detach the bus.

As a result, host->bus_ops will be unset, and host->bus_dead will be set.

In this case, mmc_suspend_host() should skip the code you are concerned about.

Regards,
Ohad.
