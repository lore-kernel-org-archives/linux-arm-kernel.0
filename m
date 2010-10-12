From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 12 Oct 2010 15:11:51 +0800
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <AANLkTimzYX0ftJkzKwcfofw=O+BZFtZwZpEGVvr6heDX@mail.gmail.com>
References: <1285738417-1638-1-git-send-email-yong.shen@linaro.org>
	<20100930104817.GC2526@matterhorn.lan>
	<20101006095111.GV28242@pengutronix.de>
	<AANLkTi=fh4_19QhB8ArTfiigbPOQSejB=gLPMiEmyXjP@mail.gmail.com>
	<20101007073027.GY28242@pengutronix.de>
	<AANLkTimzYX0ftJkzKwcfofw=O+BZFtZwZpEGVvr6heDX@mail.gmail.com>
Message-ID: <AANLkTimDzt+Z-FFq_tMuL7qjm5LNRBObV6E48pi28WWf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does anybody have more comments on [PATCHv2] ?

On Thu, Oct 7, 2010 at 8:00 PM, Yong Shen <yong.shen@linaro.org> wrote:

>
> > Using wp_tbl is because that it also contains information like regulator
>> > voltage.
>>
>> The clock code does not handle the regulators, not even in the fsl
>> kernel.
>>
> I did not mean to say clock code will handle regulators. I mean this table
> also contains such information which may be needed in other freescale
> drivers, like dvfs and busfreq.
>
>>
>>
> > Since the regulator driver for imx51 have not been upstreamed, you
>> > don't see any regulator operation here. Also, like you mentioned, there
>> are
>> > two ways to change cpufreq, by post divider or pll change. And post
>> divider
>> > change is a simpler way and also the only way for babbage, since cpu
>> freq
>> > and ddr freq are all root from the same pll on babbage and they will
>> > interfere each other.
>>
>> I understand what you have to do, but the way you did really looks
>> strange. You introduce get_cpu_wp() to get the complete array of
>> workpoints. In the cpufreq driver you have this complete array, pick
>> the desired workpoint, pass the frequency to the clock layer which in
>> turn calls get_cpu_wp() to get the array and loop around it to get
>> the workpoint from the frequency again. Addionally you maintain a
>> pointer to what the clock code thinks the current workpoint is.
>>
>> How about making the clock code agnostic of such workpoints and
>> calculate the pll values and dividers for a given frequency based
>> on the frequency. If that's to complicated you could maintain
>> a table in the clock code. If that's not flexible enough you could
>> pass a pointer to this table to mx51_clocks_init. This array could
>> carry information relevant only to the clock code and only relevant
>> to the i.MX51, In the fsl kernel struct cpu_wp is a catch-all struct
>> for all i.MXs. The i.MX51 uses the pdf/mfi/mfd/mfn/cpu_podf fields,
>> the i.MX35 uses the pll_reg and pdr0_reg fields and who knows what
>> the next i.MX needs.
>>
>
> I strongly agree with you about this, and it is better to letter clock
> calculate by itself.
>
>>
>>
> >
>> > > > +static struct cpufreq_frequency_table imx_freq_table[4];
>> > >
>> > > Three frequencies should be enough for everyone, right? This should be
>> > > dynamically allocated like in other cpufreq drivers.
>> > >
>> >
>> > Yes, we only support 3 work points, which is for sure. Actually, we only
>> > support 2 points on most mx51 chips. I supposed it is ok to use static
>> array
>> > here.
>>
>> Please just add dynamic allocation, then we are safe for any potential
>> future use.
>>
>> Ok! sorry for misunderstanding.
>
> Here, I am not trying to find excuse for the cpufreq driver designer which
> is my colleague, however the truth is that since in our company the schedule
> is tight for all the tasks, that's why we always code with the first rough
> idea in the head, and having less time to think about the flexibility and
> other good conventions in programming. You can see that even freescale code
> upstreaming is done by people out of freescale, because of we lacking of
> resource.
> Therefore, I would say we did not mean to have some short-sight design, we
> also want to achieve a better life of coding like you guys are doing, which
> is my direct feeling while I am in Linaro. :)
> Thanks for comments.
>
> Yong
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101012/c5d94aa6/attachment-0001.html>
