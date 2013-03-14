From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Mar 2013 17:42:30 +0400
Subject: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
In-Reply-To: <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
 <5140F35F.3090702@cogentembedded.com>
 <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <5141D3C6.4090806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-03-2013 4:29, Kuninori Morimoto wrote:

>>> +/* USB */
>>> +static struct usb_phy *phy;
>>> +static int usb_power_on(struct platform_device *pdev)
>>> +{
>>> +	if (!phy)
>>> +		return -EIO;
>>> +
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	pm_runtime_get_sync(&pdev->dev);
>>> +
>>> +	usb_phy_init(phy);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void usb_power_off(struct platform_device *pdev)
>>> +{
>>> +	if (!phy)
>>> +		return;
>>> +
>>> +	usb_phy_shutdown(phy);
>>> +
>>> +	pm_runtime_put_sync(&pdev->dev);
>>> +	pm_runtime_disable(&pdev->dev);
>>> +}
>>> +
>>> +static struct usb_ehci_pdata ehcix_pdata = {
>>> +	.power_on	= usb_power_on,
>>> +	.power_off	= usb_power_off,
>>> +	.power_suspend	= usb_power_off,
>>> +};
> (snip)

>>      Morimoto-san, I don't understand why this SoC specific platform device
>> ended up in the board file? Could you explain your reasons please?
>>      I think this is generally a bad practice as this approach scales badly.

> Do you mean it should exist in setup-r8a7779.c ?

    Yes.

> I forgot detail of it, but these usb is using callback function,
> and it is using *phy*.

   But this PHY also belongs to SoC.

> This phy came from marzen_init_late() with usb_get_phy(USB_PHY_TYPE_USB2);
> This usb_get_phy() is not needed if board doesn't have USB.

    Anyway, there should be ways to separate the board specific platform code 
and the SoC specific one. That's what other subarches do.

> You can modify it if you want

    Yes, I definitely would like to try.

WBR, Sergei
