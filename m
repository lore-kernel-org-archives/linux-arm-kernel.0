From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Nov 2014 14:16:49 +0000
Subject: [PATCH v5] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <5472F3F0.8060701@linaro.org>
References: <1416812564-26465-1-git-send-email-sonnyrao@chromium.org>
 <5472F3F0.8060701@linaro.org>
Message-ID: <20141124141649.GD15872@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 09:01:36AM +0000, Daniel Lezcano wrote:
> On 11/24/2014 08:02 AM, Sonny Rao wrote:
> > This is a bug fix for using physical arch timers when
> > the arch_timer_use_virtual boolean is false.  It restores the
> > arch_counter_get_cntpct() function after removal in
> >
> > 0d651e4e "clocksource: arch_timer: use virtual counters"
> >
> > We need this on certain ARMv7 systems which are architected like this:
> >
> > * The firmware doesn't know and doesn't care about hypervisor mode and
> >    we don't want to add the complexity of hypervisor there.
> >
> > * The firmware isn't involved in SMP bringup or resume.
> >
> > * The ARCH timer come up with an uninitialized offset between the
> >    virtual and physical counters.  Each core gets a different random
> >    offset.
> >
> > * The device boots in "Secure SVC" mode.
> >
> > * Nothing has touched the reset value of CNTHCTL.PL1PCEN or
> >    CNTHCTL.PL1PCTEN (both default to 1 at reset)
> >
> > One example of such as system is RK3288 where it is much simpler to
> > use the physical counter since there's nobody managing the offset and
> > each time a core goes down and comes back up it will get reinitialized
> > to some other random value.
> >
> > Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > Acked-by: Olof Johansson <olof@lixom.net>
> 
> 
> Catalin,
> 
> are you ok with this patch ?

Yes.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
