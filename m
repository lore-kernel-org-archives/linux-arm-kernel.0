From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 23 Jul 2016 20:22:28 +0900
Subject: Why do we need reset_control_get_optional() ?
Message-ID: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


Now the reset subsystem provides
a bunch of reset_control_get variants.

I am still wondering why we need to have _optional ones.

As far as I see, the difference is WARN_ON(1)
when CONFIG_RESET_CONTROLLER is not defined.



[1] When the reset is mandatory,
the code of the reset consumer is probably like follows:

  rst = devm_reset_control_get(dev, NULL);
  if (IS_ERR(rst)) {
          dev_err(dev, "failed to get reset\n");
          return PTR_ERR(rst);
  }

  ret = reset_control_deassert(rst);
  if (ret) {
          dev_err(dev, "failed to deassert reset\n");
          return ret;
  }

   ...



[2] When the reset is optional,
  the code should be something like follows:

   rst = devm_reset_control_get(dev, NULL);
   if (ERR_PTR(rst) == -EPROBE_DEFER)
           return -EPROBE_DEFER;

   /* deassert reset if it is available */
   if (!IS_ERR(rst)) {
           ret = reset_control_deassert(rst);
           if (ret) {
                  dev_err(dev, "failed to deassert reset\n");
                  return ret;
           }
    }




What I mean is, we can write a driver in either way
without using the _optional one.

No need to call WARN_ON(1).


What does _optional buy us?



One more thing.
WARN_ON(1) is only useful on run-time,
but run-time test is more expensive than compile-time test.

If a driver really needs reset control,
it should not be complied without CONFIG_RESET_CONTROLLER.
So, the driver should have "depends on RESET_CONTROLLER" in Kconfig.



I dug the git-log to figure out historical reason.

The _optional functions were introduced by the following commit:

----------------->8-----------------
commit b424080a9e086e683ad5fdc624a7cf3c024e0c0f
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Fri Mar 7 15:18:47 2014 +0100

    reset: Add optional resets and stubs

    This patch adds device_reset_optional and (devm_)reset_control_get_optional
    variants that drivers can use to indicate they can function without control
    over the reset line. For those functions, stubs are added so the drivers can
    be compiled with CONFIG_RESET_CONTROLLER disabled.
    Also, device_reset is annotated with __must_check. Drivers
ignoring the return
    value should use device_reset_optional instead.

    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
------------------8<-----------------------------

At that point of time, the reset_control_get  (without _optional)
did not have a stub, so drivers calling reset_control_get()
could not be built without CONFIG_RESET_CONTROLLER enabled.
So, it made sense to add _optional variants.




A while later, any drivers became able to be built
without CONFIG_RESET_CONTROLLER, by the following commit.

----------------->8------------------------------------
commit 5bcd0b7f3c56c616abffd89e11c841834dd1528c
Author: Axel Lin <axel.lin@ingics.com>
Date:   Tue Sep 1 07:56:38 2015 +0800

    reset: Add (devm_)reset_control_get stub functions

    So the drivers can be compiled with CONFIG_RESET_CONTROLLER disabled.

    Signed-off-by: Axel Lin <axel.lin@ingics.com>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
-------------------8<------------------------------------


Since then, it became pointless to have _optional variants.




I want to deprecate _optional variants in the following steps:

[1] Add "depends on RESET_CONTROLLER" to drivers
    for which reset_control is mandatory.

    We can find those driver easily by grepping
    the reference to non-optional reset_control_get().


[2] Change all of _optional calls to non-optional ones.


[3] Remove _optional static inline functions from include/linux/reset.h



It will take some releases to complete this task,
but I am happy to volunteer to it if we agree on this idea.




-- 
Best Regards
Masahiro Yamada
