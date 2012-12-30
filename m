From: zhanzhenbo@gmail.com (steve.zhan)
Date: Sun, 30 Dec 2012 22:56:53 +0800
Subject: [PATCH] hwspinlock/core: Add testing capabilities
In-Reply-To: <20121230142710.GA16250@WorkStation.localnet>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
 <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
 <20121230142710.GA16250@WorkStation.localnet>
Message-ID: <CAKvkGKcHfJZ++B+sq2NUZT=EDW7C+Zd3zxsOjY1MV2YA9ecE7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Ido.

      I think if hwspinlock mudule probe register have not return 0 Or
executed over,  we can assume that system can not do acquire the

lock, that must be later than hardware module register..

      For example, if there have 32 locks, that using the same bank,

if register lock 31 failed, then omap hwlock module will release
bank struct like this:

reg_fail:
        pm_runtime_disable(&pdev->dev);

        kfree(bank);
iounmap_base:
        iounmap(io_base);
        return ret;
}

so, for  this time, if the spinlocks might already be acquired, that

lock will can not find the bank pointer...



/**
  * hwspin_lock_register() - register a new hw spinlock device
  * @bank: the hwspinlock device, which usually provides numerous hw locks
@@ -345,9 +392,18 @@ int hwspin_lock_register(struct hwspinlock_device
*bank, struct device *dev,
                spin_lock_init(&hwlock->lock);
                hwlock->bank = bank;

+
                ret = hwspin_lock_register_single(hwlock, base_id + i);
-               if (ret)
+               if (ret) {
                        goto reg_failed;
+               } else {
+                       ret = hwspin_lock_tests(ops, hwlock);
+                       if (ret) {
+                               pr_err("hwspinlock tests failed on lock
%d\n",
+                               base_id + i);
+                               goto reg_failed;
+                       }
+               }
        }

        return 0;


Steve.




2012/12/30 Ido Yariv <ido@wizery.com>

> Hi Steve,
>
> On Sun, Dec 30, 2012 at 10:13:08PM +0800, steve.zhan wrote:
> > Hi,
> >    Acked-by: Steve zhan zhanzhenbo at gmail.com
> >
> >    "I'd rather not test the spinlocks after they are registering as they
> > might already be in use by then."
> >
> >     Why? I think user must use it after hwspin_lock_register have retured
> > sucess.
>
> Once the spinlocks are registered anyone can request and acquire these.
> The tests could then interfere with any users of the hwspinlock layer,
> or simply fail (because the spinlocks might already be acquired).
>
> Thanks,
> Ido.
>



-- 
Steve Zhan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121230/60dfb7f2/attachment-0001.html>
