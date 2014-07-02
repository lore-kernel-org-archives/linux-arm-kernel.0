From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 2 Jul 2014 13:32:42 -0600
Subject: [PATCH 0/9 v2] Coresight framework and drivers
In-Reply-To: <DEE44AFE682197449410588EB783A5145BE217925A@BUNGLE.Emea.Arm.com>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
 <DEE44AFE682197449410588EB783A5145BE217925A@BUNGLE.Emea.Arm.com>
Message-ID: <CANLsYkxEuxw7KjLDz6_t_yJYVNAojuHS9O1tPSaEGis_0cpcsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2014 04:32, Al Grant <Al.Grant@arm.com> wrote:
>> This set is addressing comments received after the May 30th
>> submission[1].  More specifically:
>>
>> .All drivers have been converted to use the AMBA bus
>>  interface.
>> .Debugfs entries are now created with a macro.
>> .A header file was created for the ETM driver to allow
>>  for the reuse of constant definition.
>> .Error path on some drivers have been corrected.
>> .All types converted from uintX_t to uX.
>> .All numeric constant have been replaced with #defines and
>>  comments added where necessary.
>> .Removal of "coresight-id" and "coresigh-name" DT bindings.
>> .Move all DT connections specification to use the generic
>>  graph bindings.
>> .The removal of the replicator driver since it doesn't show
>>  on the AMBA bus.  Drivers for enhanced replicators that have
>>  a configuration space can be added when the need arises.
>
> So now any source or link can have multiple output ports.  But you
> still have a device type CORESIGHT_DEV_SUBTYPE_LINK_SPLIT, which is
> now unused.  Is CORESIGHT_DEV_SUBTYPE_LINK_SPLIT there just for
> future programmable replicators?

I kept it to guide the way to future implementation.  I currently have
a target with a programmable replicator on it but simply haven't had
the time to provide the necessary support.

>
> It would be simpler if you kept the separate replicator component,
> even for non-programmable replicators.

I agree with your position - doing so would certainly highlight that a
replicator is present and would shed light on why components with a
single output suddenly appear to have multiples.  I removed
non-programmable replicators because they don't show on the AMBA bus.

Russell, given that all other coresight drivers go through AMBA for
their registration, would you agree to have non-programmable
replicators show up in DT specifications even if they don't get
registered via the AMBA interface?  From a computational point of view
the end result is the same - is it strictly on the basis of
understandability.

>Then a node can be a merge
> node (multiple inputs) or split node (multiple outputs) but not both.
>
> Also, the global curr_sink limits you to one trace sink device.
> It will need changing for systems with multiple ETBs, or where
> people want to route one trace source to an ETB and another to a TPIU.
>

Very good point - I did not think about that.

> One way to support this (without exposing the full topology to the
> user) would be to have a trace sink per trace source.  So instead of
> switching the sink system-wide, the user would switch the sink for
> each source.  You would then run into the problem that some valid
> end states cannot be reached by individually changing the sink of
> each source, but the sources would have to be changed as a group.
>
> For example:
>
>   cpu #0 --funnel--replicator--tpiu
>   cpu #1 -/                  \-etb
>
>   stm ---------etf-------------etr
>
> CPU #0 and CPU #1 have to go to the same place (unless you have a
> programmable filtering replicator) but STM goes to a different place.
> You need an interface that lets you set the destination for multiple
> devices, either to a specific trace sink, or expressed in terms of
> intent (on-chip vs. off-chip) with the ability to read back to find
> out where you'll actually find the trace for any given source.

Ok, let me look into that.  I may have to get back to you in order to
iron out some corner cases but as a whole I get the concept.

>
> Al
>
>
>>
>> Regards,
>> Mathieu
>>
>> [1]. http://thread.gmane.org/gmane.linux.kernel/1714785
>>
>> Mathieu Poirier (3):
>>   coresight: adding support for beagle and beagleXM
>>   coresight: adding basic support for Vexpress TC2
>>   ARM: removing support for etb/etm in "arch/arm/kernel/"
>>
>> Pratik Patel (6):
>>   coresight: add CoreSight core layer framework
>>   coresight-tmc: add CoreSight TMC driver
>>   coresight-tpiu: add CoreSight TPIU driver
>>   coresight-etb: add CoreSight ETB driver
>>   coresight-funnel: add CoreSight Funnel driver
>>   coresight-etm: add CoreSight ETM/PTM driver
>>
>>  .../devicetree/bindings/arm/coresight.txt          |  141 ++
>>  arch/arm/boot/dts/omap3-beagle-xm.dts              |   28 +
>>  arch/arm/boot/dts/omap3-beagle.dts                 |   28 +
>>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  174 +++
>>  arch/arm/include/asm/hardware/coresight.h          |  157 --
>>  arch/arm/include/asm/hardware/cp14.h               |  540 +++++++
>>  arch/arm/kernel/Makefile                           |    1 -
>>  arch/arm/kernel/etm.c                              |  654 ---------
>>  arch/arm/kernel/hw_breakpoint.c                    |    4 +-
>>  arch/arm/mach-omap2/Kconfig                        |    8 -
>>  arch/arm/mach-omap2/Makefile                       |    1 -
>>  arch/arm/mach-omap2/emu.c                          |   50 -
>>  drivers/Kconfig                                    |    2 +
>>  drivers/Makefile                                   |    1 +
>>  drivers/amba/bus.c                                 |    2 +-
>>  drivers/coresight/Kconfig                          |   39 +
>>  drivers/coresight/Makefile                         |    8 +
>>  drivers/coresight/coresight-etb.c                  |  557 ++++++++
>>  drivers/coresight/coresight-etm-cp14.c             |  506 +++++++
>>  drivers/coresight/coresight-etm.c                  | 1507
>> ++++++++++++++++++++
>>  drivers/coresight/coresight-etm.h                  |  192 +++
>>  drivers/coresight/coresight-funnel.c               |  252 ++++
>>  drivers/coresight/coresight-priv.h                 |   69 +
>>  drivers/coresight/coresight-tmc.c                  |  791
>> ++++++++++
>>  drivers/coresight/coresight-tpiu.c                 |  223 +++
>>  drivers/coresight/coresight.c                      |  680 +++++++++
>>  drivers/coresight/of_coresight.c                   |  207 +++
>>  include/linux/amba/bus.h                           |    1 +
>>  include/linux/coresight.h                          |  190 +++
>>  include/linux/of_coresight.h                       |   27 +
>>  30 files changed, 6166 insertions(+), 874 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/arm/coresight.txt
>>  delete mode 100644 arch/arm/include/asm/hardware/coresight.h
>>  create mode 100644 arch/arm/include/asm/hardware/cp14.h
>>  delete mode 100644 arch/arm/kernel/etm.c
>>  delete mode 100644 arch/arm/mach-omap2/emu.c
>>  create mode 100644 drivers/coresight/Kconfig
>>  create mode 100644 drivers/coresight/Makefile
>>  create mode 100644 drivers/coresight/coresight-etb.c
>>  create mode 100644 drivers/coresight/coresight-etm-cp14.c
>>  create mode 100644 drivers/coresight/coresight-etm.c
>>  create mode 100644 drivers/coresight/coresight-etm.h
>>  create mode 100644 drivers/coresight/coresight-funnel.c
>>  create mode 100644 drivers/coresight/coresight-priv.h
>>  create mode 100644 drivers/coresight/coresight-tmc.c
>>  create mode 100644 drivers/coresight/coresight-tpiu.c
>>  create mode 100644 drivers/coresight/coresight.c
>>  create mode 100644 drivers/coresight/of_coresight.c
>>  create mode 100644 include/linux/coresight.h
>>  create mode 100644 include/linux/of_coresight.h
>>
>> --
>> 1.9.1
>>
>
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
>
