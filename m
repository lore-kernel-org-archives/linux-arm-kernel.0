From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 13 Aug 2015 20:40:42 -0700
Subject: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
In-Reply-To: <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
 (Geert Uytterhoeven's message of "Thu, 13 Aug 2015 10:57:38 +0200")
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
 <7hfv3onv5c.fsf@deeprootsystems.com>
 <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
Message-ID: <7hwpwylepx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Kevin,
>
> On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> Remove check for driver of a device, for runtime PM. Device may be
>>> suspended without an explicit driver. This check seems to be vestigial
>>> and incorrect in the current context.
>>
>> This one should probably have been RFC.
>>
>> For a little more context here, this was uncovered when experimenting
>> with using runtime PM for CPU devices which don't have a dev->driver.
>>
>> This check might have made sense before PM domains, but with PM domains,
>> it's entirely possible to have a simple device without a driver and the
>> PM domain handles all the necesary PM, so I think this check
>> could/should be removed.
>>
>> Thoughts?
>
> Simple devices without a driver aren't handled automatically.
> At minimum, the driver should call pm_runtime_enable(), cfr.
> drivers/bus/simple-pm-bus.c.

That's correct, and in the proof-of-concept stuff I hacked up and in
Lina's series, the CPU "devices" do indeed to this.  Without that, they
wouldn't end up ever taking this codepath through genpd's
runtime_suspend and power_off hooks.

Also, I'm not sure if your comment was meant to be an objection to the
patch?  or if you're OK with it.

Thanks for the feedback,

Kevin
