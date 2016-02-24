From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 24 Feb 2016 11:39:26 +0530
Subject: [PATCH 0/5] Modularize PCI_DW related drivers.
In-Reply-To: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <56CD4916.3050904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 08 February 2016 05:30 AM, Paul Gortmaker wrote:
> In a recent patch series that aimed to remove code related to module
> unload for PCI support that was simply non modular, the discussion
> led to people wanting to keep the code and push towards taking the
> steps needed to support moving it towards tristate instead[1].
> 
> Here, we take step one, which is simply making the Kconfig change
> and then dealing with any build fallout or modpost fallout.  What
> amounts to essentially a sanity build test.  To be clear, these
> have not been runtime validated; that will need to be done by those
> with access to real hardware.  However, the changes are not anything
> that should disrupt any existing built-in validation, so real world
> users should not be impacted by this change.
> 
> We start with a smaller family of drivers; those that actively select
> PCI_DW, as a nice self contained group to test the waters and see if
> everyone is still good with this approach before investing more time
> on a wider scale to other pci/host/ code blocks.
> 
> As such the drivers here share a dependency on having the same group
> of functions exported in order to successfully complete modpost.
> 
> In addition, we have to stray outside drivers/pci to add exports
> in two places; once for an ARM fault handler, and once for an OF
> variable.
> 
> The pci-keystone-dw.c instance was handled separately because it
> consists of two source files that need their own group of driver
> specific exports above and beyond the "shared" ones.
> 
> Then we convert the Kconfig for all remaining at once; we could have
> done it on a per driver basis for ease of revert if anyone really
> objects, but since it would be a one line change, that seemed like
> not a real concern.
> 
> Build testing was done on the linux-next tree for arm allmodconfig.

I took these patches and gave a test with DRA7xx board. As expected there was
no issues when the driver was built-in. However when I tried to rmmod/modprobe
I got this error [2].

Thanks
Kishon

[2] -> http://pastebin.ubuntu.com/15185894/
> 
> [1] https://lkml.kernel.org/r/20160108203102.GH5354 at localhost
> 
