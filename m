From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 13:14:26 -0500
Subject: [PATCH 3/5] ARM: davinci: da8xx: add cfgchip2 to resources
In-Reply-To: <56E99A16.9020709@cogentembedded.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-3-git-send-email-david@lechnology.com>
 <56E8906E.7070800@cogentembedded.com> <56E8D720.7000508@lechnology.com>
 <56E8E7C7.70901@lechnology.com> <56E99A16.9020709@cogentembedded.com>
Message-ID: <56E9A282.7030103@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 12:38 PM, Sergei Shtylyov wrote:
> On 03/16/2016 07:57 AM, David Lechner wrote:
>
>> Also, I am not finding any existing data structure to pass the musb
>> set_mode
>> function to the phy in either usb_phy or usb_otg. Setting the mode
>> (host/peripheral/otg) is done in the same PHY register, so it seems
>> like it
>> should be implemented in the new phy driver as well.
>
>     Perhaps we'd have to sacrifice that functionality...

The device I am working on (LEGO MINDSTORMS EV3) has the port wired as 
peripheral only, so I don't think leaving this out is an option. Leaving 
it in OTG mode doesn't work because the required electrical connections 
are just not there.

>> I guess I could use a generic phy instead and use phy_set_drvdata() to
>> share
>> data between the phy driver and the musb driver. Does this sound like a
>> reasonable thing to do?
>
>     Not sure what you mean, could you elaborate?

I found another driver that essentially does what I was trying to 
explain here. See the sun4i_usb_phy_set_squelch_detect function in 
drivers/phy/phy-sun4i-usb.c:394[1] as an example. It is called at 
drivers/usb/musb/sunxi.c:160[2] and :167.

I would move the da8xx_musb_set_mode function from 
drivers/usb/musb/da8xx.c to the new drivers/phy/phy-da8xx-usb.c and call 
it in a similar manner to the sunix example I gave.


---

[1]: drivers/phy/phy-sun4i-usb.c

void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
{
struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);

sun4i_usb_phy_write(phy, PHY_SQUELCH_DETECT, enabled ? 0 : 2, 2);
}
EXPORT_SYMBOL_GPL(sun4i_usb_phy_set_squelch_detect);



[2]: drivers/usb/musb/sunxi.c

static void sunxi_musb_pre_root_reset_end(struct musb *musb)
{
	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);

	sun4i_usb_phy_set_squelch_detect(glue->phy, false);
}
