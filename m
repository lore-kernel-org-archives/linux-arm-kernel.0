From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 15 Aug 2013 13:45:48 +0100
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <1376564133-11286-1-git-send-email-b29396@freescale.com>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
Message-ID: <CACxGe6tMm=u1jFKUQ59+cj-rYkLLAZUqMhsXamyi-wwpWaOGvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:55 AM, Dong Aisheng <b29396@freescale.com> wrote:
> We meet some boards having a lot of pin conflicts between different devices,
> only one of them can be enabled to run at one time.
>
> e.g. imx6q sabreauto board, i2c, spi, weim, flexcan, uart and etc involved
> with pin conflict.
>
> Instead of changing dts manually or adding a lot dts files according to
> different device availability, we provide feature to dynamically update the
> device node status via command line, then those devices involved with
> pin conflict can be enabled or disabled dynamically.

Ugh, no. If there are dynamic conflicts, then the driver really should
be responsible for handling them. ie. if the driver isn't able to get
the resource it needs because they don't exist, then driver probe
should fail.

Except in very excpetional circumstances (ie. firmware workarounds)
the kernel needs to treat the device tree as immutable*. The tree
passed in at boot should not be manipulated at runtime.

* There are powerpc platforms that modify the FDT at runtime; but in
those cases it is in response to firmware changing the data, not the
kernel.

g.
