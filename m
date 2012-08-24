From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 24 Aug 2012 15:38:01 +0000 (UTC)
Subject: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
In-Reply-To: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello P?ter,

On Thu, 23 Aug 2012, Peter Ujfalusi wrote:

> When booted with some resource will have their name set to NULL. This can
> cause later kernel crash since this is not expected by the platform code.
> 
> When we boot without DT the devices are created with platform_device_add()
> which itself fixes up the missing resource names:
> if (r->name == NULL)
> 	r->name = dev_name(&pdev->dev);
> 
> The of core also fixes up the resource names when taking the information
> from DT data - in __of_address_to_resource():
> r->name = name ? name : dev->full_name;
> 
> When we boot OMAP with devicetree: of will create the devices based on the
> DT data so the resource names are guarantied to be not NULL. Since we have
> the 'ti,hwmod' tag, we remove the of created resources from the device and
> re-create them based on hwmod data. If the hwmod data does not specify a
> name for a resource it will be NULL.
> This can cause kernel crash if the driver uses
> platform_get_resource_byname() to get any resource.

Do we need both this one and your '[PATCH] driver core: Check if r->name 
is valid in platform_get_resource_byname()' ?  Or would that second patch 
be enough?  Is the crash happening in the platform_get_resource_byname() 
iterator?


- Paul
