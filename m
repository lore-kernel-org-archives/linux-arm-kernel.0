From: ynvich@gmail.com (Sergei Ianovich)
Date: Sun, 15 Dec 2013 03:03:51 +0400
Subject: [PATCH v2 16/16] misc: support for I-8024 in LP-8x4x
In-Reply-To: <201312142159.40250.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-17-git-send-email-ynvich@gmail.com>
 <201312142159.40250.arnd@arndb.de>
Message-ID: <1387062231.13062.43.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-12-14 at 21:59 +0100, Arnd Bergmann wrote:
> Have you checked that the nsleep definition actually does the
> right thing here? 450 nanoseconds must be close the latency
> you get from calling schedule_hrtimeout(). I'd suggest using
> either ndelay() or usleep_range() instead, depending on your
> needs.

Documentation/timers/timers-howto.txt stated there was a significant
overhead when setting up usleep_range. I studied implementation and
found that schedule_hrtimeout was certainly less than 520000 CPU cycles
that udelay(1) would consume.

It worked. I haven't checked actual delay time. However, machines with
the driver (based on 3.8) are in production since May 2013 without
issues.

> If nsleep is really useful here, we should probably add that
> as a generic API rather than having it in one driver.

I've also used this nsleep for driving RTC clock (DS1302) since May
2013.

Now I see that my code is a clone of usleep_range(x, x). I will convert
my code to use it.
