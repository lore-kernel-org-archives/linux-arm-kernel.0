From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 23 Oct 2010 16:44:00 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <1287843531.29752.10.camel@maxim-laptop>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<1287704855.12734.14.camel@maxim-laptop>
	<AANLkTi=iC1uKyToEXrroOj+JxQ2mW97WRVEXjv+9oQEa@mail.gmail.com>
	<1287843531.29752.10.camel@maxim-laptop>
Message-ID: <AANLkTikgrsyeZVEnce1ouCD2ehrYg7=w54MYCSLi5Ekp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 23, 2010 at 4:18 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Sat, 2010-10-23 at 12:09 +0200, Ohad Ben-Cohen wrote:
...
>> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >> index c94565d..515ff39 100644
>> >> --- a/drivers/mmc/core/core.c
>> >> +++ b/drivers/mmc/core/core.c
>> >> @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
>> >> ? ? ? if (host->bus_ops && !host->bus_dead) {
>> >> ? ? ? ? ? ? ? if (host->bus_ops->suspend)
>> >> ? ? ? ? ? ? ? ? ? ? ? err = host->bus_ops->suspend(host);
>> >> + ? ? ? ? ? ? if (err == -ENOSYS || !host->bus_ops->resume) {

>> > This reintroduces the bug I fixed.
...
>> In this case, mmc_suspend_host() should skip the code you are concerned about.

> You are right here.
> There is a very unlikely case that suspend of sd/mmc card fails (with
> CONFIG_MMC_UNSAFE_RESUME set, and that will trigger the hang, but that
> currently isn't possible because both mmc_sd_suspend and mmc_suspend
> just return 0 unconditionally).

Please note that the card is removed only on -ENOSYS, which is not a
random error that can happen. In this context, it's a deliberate
request (from the underlying bus) to remove the card.

So even if mmc_{sd_}suspend will be changed to propagate an error code
one day, it is unlikely that they will trigger this bug even if they
fail.

> Btw, two above functions are identical, so some refactoring won't hurt.

Feel free to send a patch ;)

Regards,
Ohad.
