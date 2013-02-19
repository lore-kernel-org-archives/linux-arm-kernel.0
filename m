From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 19 Feb 2013 09:32:28 +0100
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <20130219072438.GQ20212@lunn.ch> (Andrew Lunn's message of "Tue,
 19 Feb 2013 08:24:38 +0100")
References: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.44L0.1302181723540.6790-100000@netrider.rowland.org>
 <20130219072438.GQ20212@lunn.ch>
Message-ID: <87vc9ok8kj.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:
Hi,

[...]

>> > +
>> > +static const char hcd_name[] = "ehci-orion";

[...]

>> >  }
>> >  
>> > -MODULE_ALIAS("platform:orion-ehci");
>> > -
>> >  static const struct of_device_id ehci_orion_dt_ids[] = {
>> >  	{ .compatible = "marvell,orion-ehci", },

orion-ehci here ...

>> >  	{},
>> > @@ -336,8 +307,31 @@ static struct platform_driver ehci_orion_driver = {
>> >  	.remove		= __exit_p(ehci_orion_drv_remove),
>> >  	.shutdown	= usb_hcd_platform_shutdown,
>> >  	.driver = {
>> > -		.name	= "orion-ehci",
>> > +		.name	= hcd_name,

... and ehci-orion here. This would explain why only DT case seems to
work. I'm wondering why it has not been changed given that it has been
changed everywhere else, breaking stuff.

>> 
>> Is this really what you want -- changing the driver name from 
>> "orion-ehci" to "ehci-orion"?  Is that liable to cause trouble?
>> 
>> > +MODULE_DESCRIPTION(DRIVER_DESC);
>> > +MODULE_ALIAS("platform:ehci-orion");
>> 
>> And is this really what you want -- changing the alias from 
>> "platform:orion-ehci" to "platform:ehci-orion"?
>
> Hi Manjunath
>
> I can confirm that this breaks non DT based kirkwood systems. The
> driver does not get loaded.
>
> Sorry for not testing and finding this case earlier, i just tested a
> DT based system.

Maybe doing a mass renaming from orion-ehci to ehci-orion in
arch/arm/* files would be enough ? [ well, not necessary everywhere, I'm
not sure if changing the clock name in mach-kirkwood/board-dt.c would be
a good idea given the of node didn't change its name ]

Arnaud
