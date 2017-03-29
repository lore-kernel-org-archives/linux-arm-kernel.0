From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Mar 2017 17:32:28 +0200
Subject: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
In-Reply-To: <20170329152408.GM23442@leverpostej>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-4-fu.wei@linaro.org>
 <20170328150220.GF2123@mai> <20170329152408.GM23442@leverpostej>
Message-ID: <20170329153228.GN2123@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 04:24:08PM +0100, Mark Rutland wrote:
> On Tue, Mar 28, 2017 at 05:02:20PM +0200, Daniel Lezcano wrote:
> > On Wed, Mar 22, 2017 at 12:31:14AM +0800, fu.wei at linaro.org wrote:
> > > From: Fu Wei <fu.wei@linaro.org>
> > > 
> > > When system init with device-tree, we don't know which node will be
> > > initialized first. And the code in arch_timer_common_init should wait
> > > until per-cpu timer and MMIO timer are both initialized. So we need
> > > arch_timer_needs_probing to detect the init status of system.
> > > 
> > > But currently the code is dispersed in arch_timer_needs_probing and
> > > arch_timer_common_init. And the function name doesn't specify that
> > > it's only for device-tree. This is somewhat confusing.
> > 
> > Can the following patch help you to solve nicely the situation ?
> > 
> > https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1360007.html
> 
> This does not help.
> 
> The needs_probing logic is all there to bodge around a problem with
> registering sched_clock, when you have two sources of the same
> frequency, but one is otherwise better.
> 
> The sysreg clocksource has much lower latency than the MMIO clocksource,
> so we always want to use that as the sched_clock if we have it.
> Currently, the code ensures this by deferring registration of
> sched_clock.
> 
> Ideally, we'd figure that out dynamically, or we'd have a rating
> argument.
> 

Ok, I see. Thanks.

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
