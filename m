From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 15:17:12 -0600
Subject: [PATCH 2/3 v2] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1431543609-19646-3-git-send-email-eric@anholt.net>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-3-git-send-email-eric@anholt.net>
Message-ID: <556785D8.2090709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 01:00 PM, Eric Anholt wrote:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
...
> Note that I don't think I've done what srwarren wanted for
> -EPROBE_DEFER, because I'm not clear what he wants.  I think he might
> just be asking for a function that does:
> 
> /*
>  * Returns 0 if the firmware device is probed and available, otherwise
>  * -EPROBE_DEFER.
>  */
> int rpi_firmware_get(struct device_node *firmware_node)
> {
> 	struct platform_device *pdev = of_find_device_by_node(of_node);
> 	if (!platform_get_drvdata(pdev))
> 		return -EPROBE_DEFER;
> 	return 0;
> }
> EXPORT_SYMBOL(rpi_firmware_get)
> 
> If that's all, I'm happy to add it.

Yes, there definitely needs to be something that clients can call at
probe() time to make sure the firmware driver is there already. That
check is quite different from actually sending a request to the FW, so
I'd certainly expect a separate function for that.
