From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Jan 2018 18:08:57 +0530
Subject: [PATCH] i2c: davinci: fix the cpufreq transition
In-Reply-To: <20180122144258.13627-1-brgl@bgdev.pl>
References: <20180122144258.13627-1-brgl@bgdev.pl>
Message-ID: <8323a87f-93fb-c1fd-4098-e47f0fcf5859@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 January 2018 08:12 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> i2c_davinci_cpufreq_transition() is implemented in a way that will
> block if it ever gets called while no transfer is in progress.

true!

> 
> Not only that, but reinit_completion() is never called for xfr_complete.

reinit_completion() use is must only with complete_all(). At least that
bug is not obvious so needs more detail to be added here.

> Use the fact that cpufreq uses an srcu_notifier (running in process
> context) for transitions and that the bus_lock is taken during the call
> to master_xfer() and simplify the code by removing the transfer
> completion entirely and protecting i2c_davinci_cpufreq_transition()
> with i2c_lock/unlock_adapter().
> 
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I assume you tested this on a board where I2C-controlled PMIC changes
voltage during CPUfreq (DA850 LogicPD EVM should have this hardware
support).

Perhaps also add:

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")

Apart from that:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
