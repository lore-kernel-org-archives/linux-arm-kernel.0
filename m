From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 14 Jan 2016 12:23:54 +0100
Subject: [PATCH v2] reboot: Backup orderly_poweroff
In-Reply-To: <56977BA7.702@ti.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com> <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com> <56977BA7.702@ti.com>
Message-ID: <20160114112354.GA17869@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Keerthy <a0393675@ti.com> wrote:

> I tried to simulate the issue.
> 
> In the probe function of drivers/thermal/ti-soc-thermal/ti-bandgap.c
> ti_bandgap_probe i call
> 
> orderly_poweroff(true);
> 
> This is while driver probes are still on going. I observe that
> ret = run_cmd(poweroff_cmd);
> 
> ret is a non-zero value and we enter the if condition:
> 
> Even after the
> 
> emergency_sync();
> kernel_power_off();
> 
> calls
> 
> the console remained active in weird state.

Now _that_ is clearly an architecture bug that should not be papered over ...

If kernel_power_off() is called then the system should power off. No ifs and 
whens.

Thanks,

	Ingo
