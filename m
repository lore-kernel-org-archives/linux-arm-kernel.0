From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 10 May 2012 09:10:54 -0500
Subject: [PATCH v3 2/3] ARM: imx: Add imx5 cpuidle driver
In-Reply-To: <20120510124130.GS27341@pengutronix.de>
References: <1336425407-20308-1-git-send-email-rob.lee@linaro.org>
 <1336425407-20308-3-git-send-email-rob.lee@linaro.org>
 <20120509080214.GJ27341@pengutronix.de>
 <CAMXH7KF7eznzF7AzM_JzwJ1jOm-1J4biqd=PvKMSa=ex8YFQrA@mail.gmail.com>
 <20120510124130.GS27341@pengutronix.de>
Message-ID: <CAMXH7KGskSa2a-URCV0cP=zh20cJNWx6VNfHZJbh=PHbNgCDfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 7:41 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 09, 2012 at 09:27:02AM -0500, Rob Lee wrote:
>> Sascha,
>>
>> >
>> > This clk_get should go away here and be moved somewhere to
>> > initialization. Also, if getting this clock fails we can still
>> > do regular cpu_do_idle. Additionally, if clk_get fails, we'll
>> > have a ERR_PTR value in gpc_dvfs_clk in which case the
>> > gpc_dvfs_clk == NULL won't trigger next time you are here and
>> > then you'll enable a nonexisting clock below.
>> >
>>
>> Agree. ?I'd prefer to enable this clock during intialization and just
>> leave it running. ?It is supposed to be a very low power clock and I
>> couldn't measuring any power difference with and without it being
>> enabled
>
> Ok, even better.
>
>> >
>> > I wonder why you don't add the default ARM_CPUIDLE_WFI_STATE_PWR state.
>> > The above is something different, right? It has a greater exit latency
>> > than ARM_CPUIDLE_WFI_STATE_PWR, so why don't we add it here aswell?
>>
>> Yes and no. ?Yes this is a different state but no, it doesn't have a
>> significantly greater exit latency, or at least a large enough exit
>> latency to warrant an extra state in my opinion. ?According to the
>> i.MX5 documentation, the extra exit time beyond basic WFI required for
>> the ?"WAIT_UNCLOCKED_POWER_OFF" state is 500ns (this is due to a
>> difference in i.MX5 hardware implementation compared to all other ARM
>> platforms). ?In reality, it did require a few more microseconds to
>> perform in my testing just based on the extra register writes in
>> mx5_cpu_lp_set(). ?I'd like to clean up mx5_cpu_lp_set() and add a
>> global variable to track the previous state and to just exit out if
>> the new state is the same as the old.
>
> Do you think it's worth it? You buy skipping the read with an additional
> test.
>

I'll run some tests to check.

Thanks,
Rob

>> I could do this cleanup as part of this patchset if you prefer that.
>
> Yes please. Cleanups before adding new features is always a good reason
> to apply a patch series ;)
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
