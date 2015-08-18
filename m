From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Aug 2015 13:04:53 +0100
Subject: [PATCH v4 1/5] pwm: add the Berlin pwm controller driver
In-Reply-To: <55D31CB7.9030504@gmail.com>
References: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
 <1439897888-10921-2-git-send-email-antoine.tenart@free-electrons.com>
 <55D31CB7.9030504@gmail.com>
Message-ID: <20150818120452.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 01:53:27PM +0200, Sebastian Hesselbarth wrote:
> On 08/18/2015 01:38 PM, Antoine Tenart wrote:
> >+	val = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> >+	val &= ~BERLIN_PWM_PRESCALE_MASK;
> >+	val |= prescale;
> >+	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> >+
> >+	berlin_pwm_writel(duty, pwm, pwm_dev->hwpwm, BERLIN_PWM_DUTY);
> >+	berlin_pwm_writel(period, pwm, pwm_dev->hwpwm, BERLIN_PWM_TCNT);
> 
> The reason why I usually tend to _not_ use _relaxed() in low-performance
> setup code is that you'll have to think about reordering issues when
> using _relaxed ones.

If that is your concern, then you should read Documentation/memory-barriers.txt,
specifically the section on "ACQUIRES VS I/O ACCESSES".  Using the non-
relaxed accessors doesn't save you in every circumstance.

> The question here is: Is it _guaranteed_ that above writel_relaxed()
> will be issued _before_ actually releasing the spin_lock?

There is no guarantee on all hardware that writel() will be seen by the
hardware before other accesses within a separate spinlocked region
using the same lock.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
