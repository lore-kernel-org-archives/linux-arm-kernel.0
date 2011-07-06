From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Jul 2011 23:16:00 +0800
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706110439.GP8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706110439.GP8286@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4yGJQjBufSxNCJowh_oQMBt7q15tAMRa9r_4Yu+Pzk2vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Jul 06, 2011 at 02:47:56AM -0700, Barry Song wrote:
>> +static int sirfsoc_timer_set_next_event(unsigned long delta,
>> + ? ? struct clock_event_device *ce)
>> +{
>> + ? ? unsigned long now, next;
>> +
>> + ? ? writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
>> + ? ? now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
>> + ? ? do {
>> + ? ? ? ? ? ? next = now + delta;
>> + ? ? ? ? ? ? writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
>> + ? ? ? ? ? ? writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
>> + ? ? ? ? ? ? now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
>> + ? ? } while ((next - now) > delta);
>> +
>> + ? ? return 0;
>> +}
>
> Please have a look at any of the callsites of clockevents_program_event()
> in kernel/time/. ?You'll notice that they loop in some fashion should your
> set_next_event() return -ETIME.

ok. looks like the function can be fixed to:

static int sirfsoc_timer_set_next_event(unsigned long delta,
                struct clock_event_device *ce)
{
        unsigned long now, next;

        writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base +
SIRFSOC_TIMER_LATCH);
        now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);

        next = now + delta;
        writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
        writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base +
SIRFSOC_TIMER_LATCH);
        now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);

        return next - now > delta ? -ETIME : 0;
}


>
> As there is the possibility that if you can't program the event (because
> it has already passed) then it is likely that there is some work which
> needs to be done before the next event is set. ?So the repeat logic should
> stay in the common code and not be duplicated in each platform.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
