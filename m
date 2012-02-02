From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 2 Feb 2012 14:29:08 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com>
 <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
 <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
 <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com>
Message-ID: <CAMQu2gw5uU4kXRWtuUuYAAUcrTJvS_nQhJ42-_hEmHM2NO8ZZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2012 at 2:03 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 2 Feb 2012, Shilimkar, Santosh wrote:
>
>> On Thu, Feb 2, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>
>> > N.B., I haven't looked at this file before. ?There are a few other things
>> > that don't look right that hopefully someone can take the initiative to
>> > fix. ?For example, those calls to mpuss_clear_prev_logic_pwrst() and
>> > cpu_clear_prev_logic_pwrst() should be removed as well. ?That should be
>> > done by pwrdm_clear_all_prev_pwrst() in mach-omap2/powerdomain44xx.c.
>> > Currently it's not, so that needs to be patched.
>> >
>> We(rajendra and myself) discussed this some time back with Benoit and we agreed
>> that for CPU and MPU power domains which are needed very early in the PM power
>> up sequence, we can do direct APIs..
>
> Looking at the call sites, don't these calls occur quite late in boot,
> after everything is initialized? ?I see calls from a late_initcall() and a
> suspend entry function. ?Am I missing something?
>
The code has changed now  because of the recent ARM suspend code and CPU PM idle
notifiers consolidation. O.w before we had to check the last power
state as early as MMU is
with identity mapping and we use to check the CPU last power state.

Then for the interrupt controller enable/disable etc as well we use to
check MPUSS PD
context lost state etc.

Thanks to the consolidation, some of those situations have reduced now.

>> These calls were in critical path and the PD API's proposed for context clear
>> and logic clear were use to iterate over all power domains.
>
> The code iterates over all powerdomains anyway a few lines above those
> calls, right?
>
As I said in other thread, that code was under PM debug.

> If the code only needs to iterate over a subset, let's discuss what you
> need and a different iterator can be implemented in the powerdomain code.
>
>> It is only recently we got clear context etc some reasonable form
>> even though it still iterates over all hwmod etc which is really overhead.
>
> Which mainline PM calls iterate over all hwmods?
>
>> Also you need to create 'pdev' etc for context-loss kind of APIs and
>> we all thought that that makes things un-ncessary complicated and
>> lengthy.
>
> Could you point out the code that you are referring to? ?I seem to be
> missing it :-(
>
> If the existing powerdomain API is missing something you need, there's no
> problem to add it. ?It makes things easier to debug and more portable in
> the long term if there is a clean, standard interface. ?Another hope is
> that more of the PM code can be shared.
>
Yes, we do have issue with below APIs for OMAP4 and onwards design
because of the PRCM change.

pwrdm_clear_all_prev_pwrst
pwrdm_*_mem_*

There use to be a single power state and memory state register till OMAP3
at power domain level which can give you the logic and memory last test
which is needed for OSWR.

On OMAP4, we have registers per modules and it becomes difficult to model
this difference in APIs. Initially we tried to fix that with [1] and
then later realized
that's not going to work on OMAP4 + devices because of mentioned issue.

Regards
Santosh
[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/42564




> In terms of performance, it seems pretty unlikely that one would be able
> to measure a meaningful performance difference, unless we are missing an
> API call that was needed? ?As we were discussing before, device reads are
> likely to dominate the profile.
>
> Flipping through the code, I see that code is getting duplicated again.
> We now have three identical copies of clkdms_setup(). ?The OMAP4
> pwrdms_setup() is doing string comparisons to skip powerdomains -- that's
> also pretty fragile; that should be controlled through powerdomain flags
> or some similar mechanism. ?Once that's fixed, it looks to me like that
> function could be shared with the OMAP34xx pwrdms_setup()? ?Looks like we
> could also share omap{3,4}_pm_suspend() and omap{2,3,4}_pm_{begin,end}?
>
> It would be good if we can keep working towards making as much of this
> code as common as possible. ?If already-tested code can be reused, that
> should cut down on bugs and maintainer workload. ?Also, we can avoid
> adding unnecessary lines of diff; we are trying to cut that down too..
>
>> > Also all of the open-coded powerdomain register accesses in
>> > omap-mpuss-lowpower.c should be removed - those should all go through
>> > pwrdm_*() functions...
>> >
>> ?I will have another look at the code with your recent power domain
>> clean-ups and see what all can be moved to generic APIs.
>
> That would be great!
>
>
> - Paul
