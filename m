From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 17 Jul 2014 16:58:17 +0200
Subject: [PATCH v2 1/5] i2c: Don't start transfers when suspended
In-Reply-To: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
Message-ID: <CABYn4swJ5NHyUd5+zCK6jhHex4v9DCMe5Qo-BZqxjPf90JfusQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I want to add the remark that I can't help further on the patch series
in the next month about. So this is free to be taken/ignored/modified
without any approval by my side.

Have fun coding,

 Bastian


2014-07-17 16:48 GMT+02:00 Bastian Hecht <hechtb@gmail.com>:
> i2c transfer requests come in very uncontrolled, like from interrupt routines.
> We might be suspended when this happens. To avoid i2c timeouts caused by
> powered down busses we check for suspension.
>
> Several bus drivers handle this problem on their own. We can clean things up
> by moving the protection mechanism into the core.
>
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> ---
> changelog v2:
>
> - commit message extended.
> - initialization added for adap->suspended
> - swapped branch for increased performance
>
>
>  drivers/i2c/i2c-core.c | 25 ++++++++++++++++++++++++-
>  include/linux/i2c.h    |  1 +
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7c7f4b8..b15dc20 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -343,6 +343,13 @@ static int i2c_legacy_resume(struct device *dev)
>  static int i2c_device_pm_suspend(struct device *dev)
>  {
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +       struct i2c_adapter *adap = i2c_verify_adapter(dev);
> +
> +       if (adap) {
> +               i2c_lock_adapter(adap);
> +               adap->suspended = true;
> +               i2c_unlock_adapter(adap);
> +       }
>
>         if (pm)
>                 return pm_generic_suspend(dev);
> @@ -353,6 +360,13 @@ static int i2c_device_pm_suspend(struct device *dev)
>  static int i2c_device_pm_resume(struct device *dev)
>  {
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +       struct i2c_adapter *adap = i2c_verify_adapter(dev);
> +
> +       if (adap) {
> +               i2c_lock_adapter(adap);
> +               adap->suspended = false;
> +               i2c_unlock_adapter(adap);
> +       }
>
>         if (pm)
>                 return pm_generic_resume(dev);
> @@ -1243,6 +1257,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>         dev_set_name(&adap->dev, "i2c-%d", adap->nr);
>         adap->dev.bus = &i2c_bus_type;
>         adap->dev.type = &i2c_adapter_type;
> +       adap->suspended = false;
>         res = device_register(&adap->dev);
>         if (res)
>                 goto out_list;
> @@ -1819,7 +1834,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>                         i2c_lock_adapter(adap);
>                 }
>
> -               ret = __i2c_transfer(adap, msgs, num);
> +               if (!adap->suspended)
> +                       ret = __i2c_transfer(adap, msgs, num);
> +               else
> +                       ret = -EIO;
>                 i2c_unlock_adapter(adap);
>
>                 return ret;
> @@ -2577,6 +2595,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>
>         if (adapter->algo->smbus_xfer) {
>                 i2c_lock_adapter(adapter);
> +               if (adapter->suspended) {
> +                       res = -EIO;
> +                       goto unlock;
> +               }
>
>                 /* Retry automatically on arbitration loss */
>                 orig_jiffies = jiffies;
> @@ -2590,6 +2612,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>                                        orig_jiffies + adapter->timeout))
>                                 break;
>                 }
> +unlock:
>                 i2c_unlock_adapter(adapter);
>
>                 if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index b556e0a..af08c75 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -434,6 +434,7 @@ struct i2c_adapter {
>         int timeout;                    /* in jiffies */
>         int retries;
>         struct device dev;              /* the adapter device */
> +       unsigned int suspended:1;
>
>         int nr;
>         char name[48];
> --
> 1.9.1
>
