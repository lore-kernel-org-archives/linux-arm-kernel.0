From: khilman@ti.com (Kevin Hilman)
Date: Tue, 31 Jan 2012 13:55:19 -0800
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <CAMXH7KF69QJ-WprR3i4dDxWKQSvDxwLx=Os-NqG+H1p12yM0uw@mail.gmail.com>
 (Rob Lee's message of "Mon, 30 Jan 2012 21:02:06 -0600")
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <871uqoj23b.fsf@ti.com>
 <CAMXH7KGeVtvW7ciHrDuK_a6b396RUXnU4eWb26nNMSk1jsDkyw@mail.gmail.com>
 <87fwf3ehi3.fsf@ti.com>
 <20120129153459.GF15455@n2100.arm.linux.org.uk>
 <CAMXH7KF69QJ-WprR3i4dDxWKQSvDxwLx=Os-NqG+H1p12yM0uw@mail.gmail.com>
Message-ID: <87obtjlepk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Lee <rob.lee@linaro.org> writes:

> On Tue, Jan 24, 2012 at 2:08 PM, Kevin Hilman <khilman@ti.com> wrote:
>> I noticed that the generic code uses ktime_get() for measuring time.  On
>> OMAP, we use getnstimeofday() because I while back I remember having
>> problems with the interaction of CPUidle state measurements and system
>> suspend.  Any idle activity during system suspend/resume ktime_get()
>> will WARN() because the timekeeping system has been suspended.
>
> It seems that all the time keeping functions including
> getnstimeofday() now have the "WARN_ON(timekeeping_suspended)" or
> WARN_ON_ONCE. ?So I'd like to stick with ktime_get unless I'm missing
> something about the suspend warning or unless there is some other
> reason why getnstieofday() is preferred.

I agree.  

I've convinced myself that my use of getnstimeofday() is because of a
problem that doesn't exist anymore in mainline, and now that the
timekeeping core has been converted to use syscore_ops, use of
ktime_get() is good.

Kevin
