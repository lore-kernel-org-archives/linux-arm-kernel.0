From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 24 Oct 2011 10:42:05 +0200
Subject: [RFC 0/4] simplify remapping a resource for drivers
Message-ID: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mostly all platform drivers need to do something like this to get a ioremapped
pointer from a resource (and some have multiple resources to be remapped):

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(&pdev->dev, "can't get device resources\n");
		return -ENOENT;
	}

	res_size = resource_size(res);
	if (!devm_request_mem_region(&pdev->dev, res->start, res_size, res->name)) {
		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
				res_size, res->start);
		return -EBUSY;
	}

	priv->base = devm_ioremap_nocache(&pdev->dev, res->start, res_size);
	if (priv->base) {
		dev_err(&pdev->dev, "ioremap failed\n");
		return -ENOMEM;
	}

In case of not using managed devices, there is also code for cleaning up when
hitting an error. After this series, the same can be done with:

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	err = devm_resource_to_mapped_ptr(&pdev->dev, res, &priv->base);
	if (err)
		return err;

The new function will perform all necessary checks and return with consistent
error codes and messages on failures. It also prevents common mistakes like
using a wrong type for res_size or not calling the _nocache-variant of ioremap
if the resource is not marked otherwise. Because the new functions works with
the struct device (plus a resource), it will probably be useful even if
platform drivers run out of fashion.

The first two patches are minor cleanups on devres found while working on the code.
The third patch adds the new function. The fourth patch is an example, so we have a
simple use-case for the proposed functionality.

The series can also be fetched from:

	git://git.pengutronix.de/git/wsa/linux-2.6.git resource_to_ptr

Looking forward to reviews and comments.

Thanks,

   Wolfram


Wolfram Sang (4):
  Documentation: devres: add allocation functions to list of supported calls
  lib: devres: add annotations for #endif
  lib: devres: add function which remaps a given resource
  watchdog: imx2: simplify resource allocation

 Documentation/driver-model/devres.txt |    5 +++
 drivers/watchdog/imx2_wdt.c           |   22 ++-----------
 include/linux/device.h                |    3 ++
 lib/devres.c                          |   56 +++++++++++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 21 deletions(-)

-- 
1.7.6.3
