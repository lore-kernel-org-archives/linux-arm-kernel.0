From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 03 Jul 2014 14:21:22 +0200
Subject: timers & suspend
In-Reply-To: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
References: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
Message-ID: <53B54AC2.5040908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 08:39 PM, S?ren Brinkmann wrote:
> Hi,
>
> I'm currently working on suspend for Zynq and try to track down some
> spurious wakes. It looks like the spurious wakes are caused by timers,
> hence I was wondering whether there are any special requirements for
> timer drivers when it comes to suspend support or if I just missed
> something.
>
> Zynq sets the 'IRQCHIP_MASK_ON_SUSPEND' flag, which should mask all
> interrupts but the wake source. Reading through kernel/irq/pm.c
> indicates, that timer interrupts get some special treatment though.
> Therefore I implemented some suspend/resume callbacks for the
> cadence_ttc which disable and clear the timer's interrupts when going
> into suspend. That seems to mitigate the issue quite a bit, but I still
> saw spurious wakes - just a lot less often.
> Digging a little deeper revealed, the spurious wakes are caused by the
> ARM's smp_twd timer now. Given that that driver is probably used by a few
> more ARM platforms, I get the feeling that I'm missing something.

Do you receive any interrupt from the cadence_ttc ? (/proc/interrupts)

That's funny because I realize that you cadence ttc timer is never used 
as there are the architected timers. The cadence ttc would be only 
useful if there were an idle state powering down the smp_twd timers but 
it is not the case on this board, IIUC.

> It's probably worth mentioning that the suspend state in Zynq does not
> power off the CPU cores. It just asserts the resets on secondary cores
> and the primary one waits in wfi.

Why do you need to reset them ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
