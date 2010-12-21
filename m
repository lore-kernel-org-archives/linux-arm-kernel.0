From: nvishwan@codeaurora.org (nvishwan at codeaurora.org)
Date: Tue, 21 Dec 2010 15:44:21 -0800 (PST)
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <201012152204.42002.arnd@arndb.de>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
	<201012152204.42002.arnd@arndb.de>
Message-ID: <c59887f4d87c07003902219b5615d184.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 15 December 2010 19:31:06 Niranjana Vishwanathapura wrote:
>> +struct rmnet_private {
>> +       smd_channel_t *ch;
>> +       struct net_device_stats stats;
>> +       const char *chname;
>> +#ifdef CONFIG_MSM_RMNET_DEBUG
>> +       ktime_t last_packet;
>> +       short active_countdown; /* Number of times left to check */
>> +       short restart_count; /* Number of polls seems so far */
>> +       unsigned long wakeups_xmit;
>> +       unsigned long wakeups_rcv;
>> +       unsigned long timeout_us;
>> +       unsigned long awake_time_ms;
>> +       struct delayed_work work;
>> +#endif
>> +};
>
> It feels like a significant portion of the code and the complexity
> (of which there fortunately is very little otherwise) is in the
> debugging code. How important is that debugging code still?
>
> In my experience, once a driver gets stable enough for inclusion,
> most of the debugging code that you have put in there to write
> the driver becomes obsolete, because the next bug is not going
> to be found with it anyway.
>
> How about deleting the debug code now? You still have the code and
> if something goes wrong, you can always put it back to analyse
> the problem.
>

These debug code proved to be very helpful in debugging with different
baseband images on different targets.  So, it would be very handy to keep it.

But, let me remove it for now, I can send another patch later for debug code.

>> +/* Called in soft-irq context */
>> +static void smd_net_data_handler(unsigned long arg)
>> +{
>> ...
>> +}
>> +
>> +static DECLARE_TASKLET(smd_net_data_tasklet, smd_net_data_handler, 0);
>> +
>> +static void smd_net_notify(void *_dev, unsigned event)
>> +{
>> +       if (event != SMD_EVENT_DATA)
>> +               return;
>> +
>> +       smd_net_data_tasklet.data = (unsigned long) _dev;
>> +
>> +       tasklet_schedule(&smd_net_data_tasklet);
>> +}
>
> It appears strange to do all the receive work in a tasklet. The
> common networking code already has infrastructure for deferring
> the rx to softirq time, and using the NAPI poll() logic likely gives
> you better performance as well.
>

NAPI will not buy much as the SMD transport doesn't provide a machanism to
stop interrupts.  I will consider using NAPI in the future (it requires
performance testing on lot of different targets).

> Aside from these, the driver looks very nice and clean to me.
>
> 	Arnd
>
