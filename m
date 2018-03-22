From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Mar 2018 09:26:06 +0800
Subject: [PATCH V7 00/13] drivers: Boot Constraint core
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Message-ID: <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-02-18, 15:53, Viresh Kumar wrote:
> Problem statement:
> 
> Some devices are powered ON by the bootloader before the bootloader
> handovers control to Linux. It maybe important for some of those devices
> to keep working until the time a Linux device driver probes the device
> and reconfigure its resources.
> 
> A typical example of that can be the LCD controller, which is used by
> the bootloaders to show image(s) while the platform is booting into
> Linux.  The LCD controller can be using some resources, like clk,
> regulators, etc, that are shared between several devices. These shared
> resources should be configured to satisfy need of all the users.  If
> another device's (X) driver gets probed before the LCD controller driver
> in this case, then it may end up disabling or reconfiguring these
> resources to ranges satisfying the current users (only device X) and
> that can make the LCD screen unstable.
> 
> Another case can be a debug serial port enabled from the bootloader.
> 
> Of course we can have more complex cases where the same resource is
> getting used by two devices while the kernel boots and the order in
> which devices get probed wouldn't matter as the other device will surely
> break then.

And we have a _real_ use case for this complex scenario as well.

Georgi (cc'd) is currently working[1] on implementing generic support for the
interconnect bus, which tries to play with the bandwidth of the bus based on how
much are the requirements from different parts of the SoC. The 4th version was
posted recently by him, and things are looking good/positive.

The bootloader configures the interconnect to provide sufficient bandwidth for
all the devices which are used during boot, few of them are the CPUs, serial and
the LCD controller. As the kernel starts taking control of things, the drivers
being probed start putting their requirements on the interconnect bus.  Because
the interconnect doesn't have any representation from the devices which are not
yet initialized by the kernel, the interconnect core incorrectly reduces the
bandwidth of the bus to a level unacceptable to the devices running currently,
like the CPUs and this makes kernel boot awfully slow. This is not an ordering
problem as no matter which device we probe first, we are going to break
something else.

Georgi already tried using the boot constraint patches to solve this complex
problem, and its a perfect fit.

-- 
viresh

[1] http://lkml.kernel.org/r/20180309210958.16672-1-georgi.djakov at linaro.org
