From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 6 Mar 2011 19:50:38 +0530
Subject: [PATCH] ARM: twd: Adjust localtimer frequency withcpufreqnotifiers
In-Reply-To: <AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com><AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com><4D70BE9D.4000507@stericsson.com><AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com><4D714C17.7080102@gmail.com><AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com><eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
	<AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
Message-ID: <7e9fafa016bfe536ccc373fc2cc7ba61@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Linus Walleij
> Sent: Sunday, March 06, 2011 5:37 PM
> To: Santosh Shilimkar
> Cc: Russell King; Srinidhi KASAGAR; Harald Gustafsson; Linus
> Walleij; linux-kernel at vger.kernel.org; Rickard ANDERSSON; martin
> persson; Colin Cross; Varun Swara; Catalin Marinas; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: twd: Adjust localtimer frequency
> withcpufreqnotifiers
>
> On Sat, Mar 5, 2011 at 9:19 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>
> > While doing this patch for OMAP I also found that
> > CPUFREQ notifiers does delays scaling timer frequency
> > and there is a tick deviation(3-4 ms) around 1st tick and
> > last tick around twd rescaling.
>
> Is this caused by ticks that have been programmed
> already (based on the previous frequency) when the scaling
> takes effect? (That's most likely I think.)
>
That's correct Linus. I noticed that Collin's patch reduces that
problem a bit. In my patch I was always leaving the scaling
to post notifier which actually aggravates the scenario.

> The latter could be fixed by simply calling
> schedule() for each CPU connected in the same core as
> the TWD at the end of twd_update_cpu_frequency(),
> couldn't it?
>
I don't think schedule will do any difference here because
it's the actual tick duration which getting changed. The
tick does happen as per the timer load value. Now it all
depends at what point time in tick window the timer scaling
happens.

> Colin what do you say?
>
> > Another issue was not able to select higher fixed twd rate
> > and found fix for the same.
>
> Can you send out the patch?
>
Sure. May be let's get all these twd scaling
patches on the list. Rob's clock patches, Collin's
notifier patch. And then I shall post the fix on
top of that.

Regards,
Santosh
