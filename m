From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 2 Feb 2012 12:43:20 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com>
 <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
Message-ID: <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 31 Jan 2012, Kevin Hilman wrote:
>
>> Kevin Hilman <khilman@ti.com> writes:
>>
>> > Paul Walmsley <paul@pwsan.com> writes:
>> >
>> >> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> >> pwrdm_pre_transition(), which appears a few lines after these calls,
>> >> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
>> >> need to do it twice.
>> >
>> > It looks like these two for OMAP4 are surpurfluous since the immediately
>> > follow a call to pwrdm_pre_transition() as well.
>> >
>> > Santosh/Rajendra, please confirm/ack.
>>
>> So after the discussion, do you want to fold this into the original
>> patch, or do you want a separate patch?
>
> Your changes make sense to me. ?I am fine with you adding them into the
> original patch and adding some credit for you into the commit message.
> Or you can create a separate patch.
>
> N.B., I haven't looked at this file before. ?There are a few other things
> that don't look right that hopefully someone can take the initiative to
> fix. ?For example, those calls to mpuss_clear_prev_logic_pwrst() and
> cpu_clear_prev_logic_pwrst() should be removed as well. ?That should be
> done by pwrdm_clear_all_prev_pwrst() in mach-omap2/powerdomain44xx.c.
> Currently it's not, so that needs to be patched.
>
We(rajendra and myself) discussed this some time back with Benoit and we agreed
that for CPU and MPU power domains which are needed very early in the PM power
up sequence, we can do direct APIs..
These calls were in critical path and the PD API's proposed for context clear
and logic clear were use to iterate over all power domains.
It is only recently we got clear context etc some reasonable form
even though it still iterates over all hwmod etc which is really overhead.
Also you need to create 'pdev' etc for context-loss kind of APIs and
we all thought that that makes things un-ncessary complicated and
lengthy.


> Also all of the open-coded powerdomain register accesses in
> omap-mpuss-lowpower.c should be removed - those should all go through
> pwrdm_*() functions...
>
 I will have another look at the code with your recent power domain clean-ups
and see what all can be moved to generic APIs.

Regards
Santosh
