From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 16:12:29 -0400 (EDT)
Subject: [PATCH v3 6/7] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <1364507705-22012-7-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303291607090.1467-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the  Qualcomm QSD/MSM on-chip host controller driver from
> ehci-hcd host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> however, note that other changes are still needed before Qualcomm QSD/MSM
> can be booted with a multi-platform kernel, which is not expected before
> 3.11.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the msm bus glue.

This patch is good.  However the ehci-msm driver itself is not.  While
checking through the code, I was struck by the fact that it never calls
usb_add_hcd() or usb_remove_hcd().  Obviously the driver cannot work
properly.

In addition, it stores the PHY pointer in a global variable.  
(ehci-atmel does much the same thing for its clocks.)  This means the
driver cannot be used on a system having more than one EHCI controller.  
Maybe this doesn't matter, though.

Maybe somebody would like to fix and test it...

Alan Stern
