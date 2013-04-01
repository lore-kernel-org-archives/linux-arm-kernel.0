From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 01 Apr 2013 02:06:17 +0200
Subject: [PATCH] ARM: timer: Shutdown clock event device when stopping
 local timer
In-Reply-To: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
References: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
Message-ID: <5158CF79.2060702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 10:24 AM, ning.n.jiang at gmail.com wrote:
> From: Ning Jiang <ning.n.jiang@gmail.com>
> 
> Currently there are two problems when we try to stop local timer.
> First, it calls set_mode function directly so mode state is not
> updated for the clock event device. Second, it makes the device
> unused instead of shutdown.
> 
> A subtle error will happen because of it. When a cpu is plugged out
> it will stop the local timer. It will call tick_nohz_idle_enter()
> in idle thread afterwards. It will cancel the sched timer and try
> to reprogram the next event. This is wrong since the local timer
> is supposed to be stopped.
> 
> The right way to stop the local timer is to shutdown it by calling
> clockevents_set_mode(). Thus when we try to reprogram the clock
> event device, it will return directly without doing anything since
> the clock mode is CLOCK_EVT_MODE_SHUTDOWN.
> 
> Signed-off-by: Ning Jiang <ning.n.jiang@gmail.com>
> ---


Don't you see a kernel BUG with this patch ?

In the clockevents code, there is:

/**
 * clockevents_notify - notification about relevant events
 */
void clockevents_notify(unsigned long reason, void *arg)
{
	...
	case CLOCK_EVT_NOTIFY_CPU_DEAD:
	...
                cpu = *((int *)arg);
                list_for_each_entry_safe(dev, tmp, &clockevent_devices,
					list) {
                       if (cpumask_test_cpu(cpu, dev->cpumask) &&
                            cpumask_weight(dev->cpumask) == 1 &&
                            !tick_is_broadcast_device(dev)) {
                                BUG_ON(dev->mode !=
					CLOCK_EVT_MODE_UNUSED);

				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                                list_del(&dev->list);
                        }
                }
                break;
	...
}

This is called triggered from hrtimer_cpu_notify with the CPU_DEAD event.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
