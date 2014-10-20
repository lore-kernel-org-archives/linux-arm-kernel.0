From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Oct 2014 11:27:02 -0700
Subject: [PATCH] tty: serial: msm: Fix lock init issue with earlycon
In-Reply-To: <1413551588-14877-1-git-send-email-galak@codeaurora.org>
References: <1413551588-14877-1-git-send-email-galak@codeaurora.org>
Message-ID: <544553F6.1020409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 06:13 AM, Kumar Gala wrote:
> With CONFIG_DEBUG_SPINLOCK enabled we see:
>
> BUG: spinlock bad magic on CPU#0, swapper/0
>   lock: early_console_dev+0x8/0x160, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-09733-gb446b33-dirty #18

[...]

> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 4b6c783..8ab27c9 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -973,6 +973,8 @@ msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
>   	if (!device->port.membase)
>   		return -ENODEV;
>   
> +	spin_lock_init(&device->port.lock);
> +
>   	device->con->write = msm_serial_early_write;
>   	return 0;
>   }
> @@ -995,6 +997,8 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
>   	if (!device->port.membase)
>   		return -ENODEV;
>   
> +	spin_lock_init(&device->port.lock);
> +
>   	device->con->write = msm_serial_early_write_dm;
>   	return 0;
>   }

Could this be done in the tty core instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
