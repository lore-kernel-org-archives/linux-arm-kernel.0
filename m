From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 13 Sep 2012 11:04:42 -0700
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <87wqzysuu3.fsf@deeprootsystems.com> (Kevin Hilman's message of
 "Wed, 12 Sep 2012 16:08:20 -0700")
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <20120912131615.GB16547@pengutronix.de>
 <87pq5quaqr.fsf@deeprootsystems.com>
 <87wqzysuu3.fsf@deeprootsystems.com>
Message-ID: <87sjaldcjp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
[...]

>> Sorry to be late to the party (again), but still catching up after some
>> time off.
>>
>> Unfortunately, this series causes PM regressions on several OMAP
>> platforms.  I hope we can hold off on this until those issues are
>> addressed.
>
> I tracked the regression down to [PATCHv8 21/22] (see reply there.)
>
> Since this series is already merged, I suggest that the problem patch be
> reverted, at least for v3.7 and until the problem is better understood
> and tested.
>
> With that patch reverted, all my PM tests are passing.  Feel free to
> add:

OK, the i2c series is off the hook.

Felipe and I spent a little time tracking this down.  Felipe suggested
that there might be a driver with periodic i2c activity keeping I2C
awake, and thus preventing CORE retention.  He was right.

On the boards where I'm seeing the failure, the RTC is firing every
second, and since the RTC is on the I2C connected PMIC, the PMIC IRQ
reads and the RTC reads are causing lots of I2C activity every second.  

With the new autosuspend feature, that is enough to keep the I2C active
continually and prevent CORE retention.

So, all that to say, from my PoV, this series can go in as is.  The PM
problem is caused by the RTC driver someplace.

Thanks Felipe,

Kevin
