From: enrico.weigelt@gr13.net (Enrico Weigelt, metux IT consult)
Date: Thu, 29 Jun 2017 12:40:40 +0000
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <cover.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.06.2017 10:26, Viresh Kumar wrote:

Hi,

> Some devices are powered ON by the bootloaders before the bootloader
> handovers control to Linux. It maybe important for those devices to keep
> working until the time a Linux device driver probes the device and
> reconfigure its resources.

Just curious: aren't the devices (at least w/ DT) only initialized after
dependencies (eg. regulators) are already up ?

Let's imagine a LCD panel driven by a regulator behind SPI. The panel
driver would ask the regulator framework to switch on, which would
call the regulator driver. This one now would talk to SPI framework,
which finally calls the SPI driver. If SPI isn't up yet, it would all
be deferred, leaving the panel driver uninitialized (tried again later).

Am I wrong here ?

If the bootloader already switched on the panel (therefore already
enabled SPI), why does it matter that the panel driver isn't up yet ?

Is there anything that accidentially switches it off again (eg. by
resetting the regulator) ? If so, shouldn't the corresponding drivers
make sure that all depencies are met before doing anyhing w/ the
device, not even attempting a reset ?


--mtx
