From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 19:25:16 +0530
Subject: [RFC]: Supporting PIO mode of operation in i2c_msg->flags
In-Reply-To: <5562EF9D.1090403@linaro.org>
References: <5562EF9D.1090403@linaro.org>
Message-ID: <55671E44.5000704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 25 May 2015 03:17 PM, Vaibhav Hiremath wrote:
>
> Hi,
>
> This is rather an old issue, for which I have also done custom & hacky
> solution in the past.
>
> Please let me know if there is already an some other method or accepted
> workaround to this issue. Also, let me know if you have any suggestions
> on this patch, I would be happy to work on it.
>
>
> Problem Statement:
> ------------------
> In certain embedded platforms, the board power on/off is managed by
> PMIC IC, which in most of the cases is over I2C bus.
> So during shutdown/reboot you may have to do I2C transactions to access
> PMIC, which may sleep if I2C bus driver is not functioning in PIO by
> default.
>
> This is unexpected, to sleep after you disable the interrupts.
>
> For example,
>
> During reboot/shutdown, the execution call reaches to,
>
> void machine_power_off(void)
> {
>          local_irq_disable();
>          smp_send_stop();
>          if (pm_power_off)
>                  pm_power_off();
> }
>
> pm_power_off will try to do I2C transaction to access PMIC, which may
> sleep/schedule.
>
>
> Current implementation:
> --------------------
>
> Everyone probably does have their own custom implementation for this.
> Or some other mechanism to achieve this (may be hardware support).
>
>
> Proposal:
> ---------
>
> If I am not missing any other way of handling this situation,
> below proposal should be clean and acceptable (I hope so :) )
>
>
> Add flags to choose PIO mode, for I2C transactions, and the default
> would be to non-PIO mode.
>
>
> struct i2c_msg flags :
>
> #define I2C_M_PIO    0x0800
>
>
> And also add respective functionality flags
>
> #define I2C_FUNC_PIO    0x10000000 /* Driver should support PIO mode*/
>
>
> In the bus driver,
>
> Inside master_xfer() callback we will check whether the intended i2c
> transaction is meant to be processed in PIO mode, if yes, then we will
> call PIO api, else as usual non-pio api should serve.
>
>
> static int xxx_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int
> num)
> {
>      ...
>
>
> /* We can also check i2c_check_functionality(adap,I2C_FUNC_PIO) */
>      if (msg->flags & I2C_M_PIO) {
>          /* PIO mode operation */
>      } else {
>          /* non-pio mode of operation */
>      }
>
>
>      ...
>
>
>          return ret;
> }
>
>
> Feedback/comments are always welcome.
>
> Thanks,
> Vaibhav


Any comments on the RFC?

Also,
+ linux-arm & Wolfram Sang

Thanks,
Vaibhav
