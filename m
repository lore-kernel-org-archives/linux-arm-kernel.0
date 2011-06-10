From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 10 Jun 2011 12:30:48 -0500
Subject: [PATCH v2 2/5] net: ep93xx_eth: pass struct device to DMA API
	functions
In-Reply-To: <20110610165545.GA2753@acer>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<c0ddfc297e0ea1e64e58cedd6552c6b2e52c5fe8.1307040443.git.mika.westerberg@iki.fi>
	<ADE657CA350FB648AAC2C43247A983F001F3820B8699@AUSP01VMBX24.collaborationhost.net>
	<20110610165545.GA2753@acer>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3820B880E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 10, 2011 9:56 AM, Mika Westerberg wrote:
> On Thu, Jun 09, 2011 at 06:40:21PM -0500, H Hartley Sweeten wrote:
>> 
>> I just noticed this macro in include/linux/netdevice.h
>> 
>> /* Set the sysfs physical device reference for the network logical device
>>  * if set prior to registration will cause a symlink during initialization.
>>  */
>> #define SET_NETDEV_DEV(net, pdev)       ((net)->dev.parent = (pdev))
>> 
>> Is there anyway you could use that macro in the probe to save the platform_device
>> (with it's associated device) instead of introducing a new struct device * in the
>> private data?
>
> Nice finding, thanks.
>
> I'll look into that and send new version of the whole series soon.

It looks like after doing this in the probe:

	SET_NETDEV_DEV(dev, &pdev->dev);

You can then pass the required struct device pointer to the DMA API functions
like this:

static int ep93xx_rx(struct net_device *dev, int processed, int budget)
{
	...
	dma_sync_single_for_cpu(dev->dev.parent, ...

Regards,
Hartley
