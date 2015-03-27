From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Mar 2015 09:17:31 +0100
Subject: Need a phy function to enable / disable usb squelch detection
In-Reply-To: <BN3PR0301MB08495F972481336D9DA86A8A81090@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <55145B46.9020501@redhat.com>
 <BN3PR0301MB08495F972481336D9DA86A8A81090@BN3PR0301MB0849.namprd03.prod.outlook.com>
Message-ID: <5515121B.40003@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-03-15 02:21, Peter Chen wrote:
>
>> Hi Kishon,
>>
>> I've been debugging why some devices do not work with the musb otg
>> controller found on Allwinner SoC-s, and the conclusion is not good, the
>> Android kernel does a poke to the phy before releasing the usb reset.
>>
>> Now you did not want me to introduce any sunxi specific / private phy
>> functions in my initial patch-series for adding sunxi support, but in this case I do
>> not really see an alternative, as this is a very platform specific hack to work
>> around an issue with the phy-s squelch detection which causes it to see a
>> squelch when reset is released switching it to high speed mode when a lo
>> speed device is connected, after which things fall apart.
>>
>
> The nofity_connect API at struct usb_phy may satisfy your requirement,
> it will be called after bus rest has finished.

Thanks for the suggestion, but that is too late, I try to write a patch
set for this tonight (my sunxi musb work is a spare time project), as
I think that will make the discussion easier.

What I need is a way to disable squelch detection on the phy before clearing
the root port reset bit in the musb controller, currently we have this:

drivers/usb/musb/musb_virthub.c: void musb_port_reset()

	if (do_reset) {
		...
	} else {
		dev_dbg(musb->controller, "root port reset stopped\n");
		musb_writeb(mbase, MUSB_POWER, power & ~MUSB_POWER_RESET);
		...
	}

In order to work around the phy bug I need to do this (I got this from
the Allwinner android kernel sources and it seems the only way):

	if (do_reset) {
		...
	} else {
		dev_dbg(musb->controller, "root port reset stopped\n");
		musb_platform_pre_reset_end();
		musb_writeb(mbase, MUSB_POWER, power & ~MUSB_POWER_RESET);
		musb_platform_post_reset_end();
		...
	}

Notice the 2 new musb_platform_... calls, these are to be empty stubs for
all platforms except sunxi, where they need to call into the phy driver.

All in all I really believe this is so specific that a platform specific
phy callback is best, so that is what I'll do for the first version of
my patchset for this,

Regards,

Hans
