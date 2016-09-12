From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 12 Sep 2016 10:52:33 -0600
Subject: [PATCH v2 00/17] Make rpmsg a framework
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <20160912165233.GB21885@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, Sep 01 2016 at 16:28 -0600, Bjorn Andersson wrote:
>This series splits the virtio rpmsg bus driver into a rpmsg bus and a virtio
>backend/wireformat.
>
>
>As we discussed the Qualcomm SMD implementation a couple of years back people
>suggested that I should make it "a rpmsg thingie". With the introduction of the
>Qualcomm 8996 platform, we must support a variant of the communication
>mechanism that share many of the characteristics of SMD, but are different
>enough that it can't be done in a single implementation. As such there is
>enough benefit to do the necessary work and being able to make SMD a "rpmsg
>thingie".
>
>On-top of this series I have patches to switch the current smd clients over to
>rpmsg (and by that drop the existing SMD implementation).
>
>All this allows me to implement the new backend and reuse all existing SMD
>drivers with the new mechanism.
>

RPM Communication has to supported even when IRQs are disabled. The most
important use of this communication is to set the wake up time for the
CPU subsystem when all the CPUs are powered off. In addition to that,
"sleep" votes that are sent by the application processor subsystem to
allow system to go into deep sleep modes can only be triggered when the
CPU PM domains are power collapsed, drivers do not have a knowledge of
when that happens. This has to be done by a platform code that registers
for CPU PM domain power_off/on callbacks.

Using rpmsg may be nice for RPM SMD communication, but mutexes need to
go away for this driver to be any useful than bare bones active mode
resource requests for QCOM SoCs. By not doing that now, we lock
ourselves out of using this SMD driver in the near future when CPU PM
domains are available in the kernel with an ability to do system low
power modes.

I hope you would make rpmsg work in IRQ disabled contexts first before
porting the SMD driver.

Thanks,
Lina

>
>Changes from v1:
>- Split up the patch moving core code to rpmsg_core into several commits
>- Dropped the wrapping struct in rpmsg_core and just added the ops to the
>  public API (but hid the implementation details)
>- Reordered things to reduce the size of the later patches
>
>Bjorn Andersson (17):
>  rpmsg: Enable matching devices with drivers based on DT
>  rpmsg: Name rpmsg devices based on channel id
>  rpmsg: rpmsg_send() operations takes rpmsg_endpoint
>  rpmsg: Make rpmsg_create_ept() take channel_info struct
>  rpmsg: Clean up rpmsg device vs channel naming
>  rpmsg: Introduce indirection table for rpmsg_device operations
>  rpmsg: Move rpmsg_device API to new file
>  rpmsg: Indirection table for rpmsg_endpoint operations
>  rpmsg: Move endpoint related interface to rpmsg core
>  rpmsg: Move helper for finding rpmsg devices to core
>  rpmsg: Split off generic tail of create_channel()
>  rpmsg: Split rpmsg core and virtio backend
>  rpmsg: Hide rpmsg indirection tables
>  rpmsg: virtio: Hide vrp pointer from the public API
>  rpmsg: Move virtio specifics from public header
>  rpmsg: Allow callback to return errors
>  rpmsg: Introduce Qualcomm SMD backend
>
> drivers/remoteproc/Kconfig          |    4 +-
> drivers/rpmsg/Kconfig               |   14 +
> drivers/rpmsg/Makefile              |    4 +-
> drivers/rpmsg/qcom_smd.c            | 1434 +++++++++++++++++++++++++++++++++++
> drivers/rpmsg/rpmsg_core.c          |  498 ++++++++++++
> drivers/rpmsg/rpmsg_internal.h      |   82 ++
> drivers/rpmsg/virtio_rpmsg_bus.c    |  487 +++++-------
> include/linux/rpmsg.h               |  246 +-----
> samples/rpmsg/rpmsg_client_sample.c |   14 +-
> 9 files changed, 2266 insertions(+), 517 deletions(-)
> create mode 100644 drivers/rpmsg/qcom_smd.c
> create mode 100644 drivers/rpmsg/rpmsg_core.c
> create mode 100644 drivers/rpmsg/rpmsg_internal.h
>
>-- 
>2.5.0
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
