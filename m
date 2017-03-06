From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 6 Mar 2017 15:46:15 +0530
Subject: [PATCH v2 04/22] Documentation: PCI: Guide to use pci endpoint
 configfs
In-Reply-To: <20170217171506.GB15276@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-5-git-send-email-kishon@ti.com>
 <20170217171506.GB15276@infradead.org>
Message-ID: <58BD36EF.9070804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 17 February 2017 10:45 PM, Christoph Hellwig wrote:
> I'm commenting on the configfs layout here instead of the patch with the
> code as the issues are easier to explain that way.  I think the layout
> is a bit confusing and could be cleaner by making use of pre-created
> entries and symlinks.  Here is my suggestion:
> 
> /sys/kernel/config/pci_ep/functions/		
>     .. test/					# a directory for each function driver
>        ... user-specified-name1/
>        ... user-specified-name2
>     .. nvme/
>        ... user-specified-name42/		
> 
> Each directory under /sys/kernel/config/pci_ep/functions/ is owned
> by a function drivers.  Under that function driver's directory you
> can create a directory for each instance of a function driver.  The
> configfs layout is controlled by the function driver.  E.g. your current
> EPF fields would move into the test function driver, while the nvme
> function would expose totally different fields.
> 
> 
> /sys/kernel/config/pci_ep/controllers/
> 	... dwc-0/
> 	    ... function
> 	... dwc-1/
> 	    ... function
> 	... vhost-0/
> 	    ... function
> 
> 	Here you have a directory for each controller that can be bound
> 	to a function.  The directories are pre-created for each
> 	controller port that is EP capable.
> 	Function is a symlink to the function instance above.
> 	Additional parameters might also be present depending on the
> 	EPC driver.

I've changed the configfs entry according to your suggestion. However I've
considered only the generic test function and a standard EP controller and
implemented the configfs in a single file pci-ep-cfs.c. But I think this will
get more complex as we add custom parameters for individual EPC, new functions
etc..

Thanks
Kishon
