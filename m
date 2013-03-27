From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 09:27:21 +0000
Subject: [PATCH v2 10/10] arm: zynq: Add cpuidle support
In-Reply-To: <CAHTX3d+ZHxiTSL38cyRXUz1Q4+GybbVwn7Ls9R=_Z2ozR6YwoA@mail.gmail.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303262146.58590.arnd@arndb.de>
 <CAHTX3d+ZHxiTSL38cyRXUz1Q4+GybbVwn7Ls9R=_Z2ozR6YwoA@mail.gmail.com>
Message-ID: <201303270927.21373.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Michal Simek wrote:
> 2013/3/26 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday 26 March 2013, Michal Simek wrote:
> >>  arch/arm/mach-zynq/Makefile  |    1 +
> >>  arch/arm/mach-zynq/cpuidle.c |  133 ++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 134 insertions(+)
> >>  create mode 100644 arch/arm/mach-zynq/cpuidle.c
> >
> > Can you move that file to drivers/cpuidle instead?
> 
> I can't see any problem in it right now.

Ok.

Adding Daniel Lezcano to CC, he's currently doing a lot of work on
the cpuidle drivers and may have some input as well.

> >>+/* Initialize CPU idle by registering the idle states */
> >>+static int xilinx_init_cpuidle(void)
> >>+{
> >>+       unsigned int cpu;
> >>+       struct cpuidle_device *device;
> >>+       int ret;
> >>+
> >>+       ret = cpuidle_register_driver(&xilinx_idle_driver);
> >>+       if (ret) {
> >>+               pr_err("Registering Xilinx CpuIdle Driver failed.\n");
> >>+               return ret;
> >>+       }
> >
> > I think you have to check that you actually run on a Zynq system before
> > registering the driver.
> 
> Is there any elegant way how to do it?
> I see that Rob is checking compatible machine with of_machine_is_compatible().
> 

Most drivers use some resource that they can check the presence of, which is
better than checking the global "compatible" property of the system. I don't
see any of that in your driver, but I may be missing something. What is it
specifically that makes this cpuidle driver special to Zynq and different
from other cpuidle drivers? Is that difference something we can describe
using the device tree in more specific terms than the root compatible
property?

	Arnd
