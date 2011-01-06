From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 06 Jan 2011 09:54:59 +0200
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <AANLkTimWfucS6XqovGDCyVhM20HgKpxCwTOkeHKzqK29@mail.gmail.com>
References: <20101220154853.254931637@rtp-net.org>
	<20101220155812.122749841@rtp-net.org>
	<4D109C47.6020704@compulab.co.il>
	<8762ukb67c.fsf@lechat.rtp-net.org>
	<4D14B69D.4030506@compulab.co.il>
	<87fwta8b99.fsf@lechat.rtp-net.org>
	<4D21D00C.3040601@compulab.co.il>
	<87bp3y84ng.fsf@lechat.rtp-net.org>
	<4D22D256.2040504@compulab.co.il>
	<87sjx8783g.fsf@lechat.rtp-net.org>
	<AANLkTimWfucS6XqovGDCyVhM20HgKpxCwTOkeHKzqK29@mail.gmail.com>
Message-ID: <4D257553.30101@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/11 22:03, Matt Sealey wrote:
> On Tue, Jan 4, 2011 at 2:00 PM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>
>> Adding Matt Sealey in CC:. he's the product development analyst so he
>> knows the hardware (unlike me).
>>>>> Also, what ulpi vendor/product id is reported in ulpi_init()?
>>>> ULPI transceiver vendor/product ID 0x0424/0x0006
>>>> Found SMSC USB3319 ULPI transceiver.
>>> SMSC USB3319 does not have either an integrated Vbus switch or Charge Pump,
>>> For the device connected to that transceiver could work properly,
>>> there is a need in _external Vbus switch_ , that should be enabled using
>>> some kind of CPEN pin (can be GPIO).
>>> This means, that you don't even need to call ulpi_set_vbus().
>>>
>>> Either way, this patch is NAK.
>>> I think you need to check your hardware (in particular Vbus supply).
> Hey guys,

Hi

Thanks for the information. Now I am finally getting the picture of what's is
going on there...

> On the Smartbook at least both USB host ports (H1 and H2) on the board
> (one port each) are connected directly to 4-port USB hubs (SMSC2514).
> We don't have anything on there except that connection: the hub should
> handle VBUS properly. Both ports use an SMSC3317 (just a 3311 with a
> built in 3.3V supply so the id and behavior should be identical).

OK, so the SMSC331x ulpi transceiver is connected to the SMSC2514 usb hub,
so all the peripheral devices (ethernet/wifi/bt/hid) are connected to the
downstream ports of that hub and thus get their Vbus as expected. This is fine.

> On the Smarttop H1 is connected to a 4-port USB hub (Terminus FE1.1)
> with the same configuration. Same PHY. The DR port is connected
> directly to an ASIX ethernet controller. VBUS seems routed to a test
> point.
>
> I'm curious exactly what the real problem here is: that VBUS is
> basically not being handled correctly? It should be driven or not? I'm
> not entirely familiar with the specification.

SMSC2514 usb hub will not provide power to its D+ and D- pull-up resistors
until it detects a Vbus enabled on the upstream port. This is totally fine.

SMSC331x ulpi transceiver does not have either an integrated Vbus switch or
an integrated charge pump - this means that it cannot provide a Vbus to the hub.

The hub in its turn does not power the pull-up resistors and peripheral devices
are not being connected to the usb subsystem.

With this patch applied, SMSC331x ulpi transceiver issues an SRP pulses on the Vbus
and hub senses that there is something that looks like Vbus and then enables the
pull-up resistors -> peripheral devices are being connected to the usb subsystem.
This behavior violates the ULPI (and mostly certain OTG and may be also USB 2.0)
specification and SMSC2514 usb hub datasheet.

According to the SMSC2514 usb hub datasheet, VBUS_DET pin has to be connected
to a valid Vbus from the upstream port, but SMSC331x does not provide this Vbus.
This means that you should have add a Vbus switch or a charge pump to the
VBUS_DET pin of the usb hub and provide means (like GPIO) to enable/disable that
switch or charge pump.
This is h/w design bug we are dealing with.

The best solution to this would be to add a missing h/w component.
Now, I understand that it can be kind a problematic ;)
But, we cannot violate the ULPI spec and the generic driver to workaround
some h/w problem that is existing in some specific configuration and hopefully will
be fixed in the next h/w revisions. Therefore, as I said before, this patch is NAK.

What we can do is:
1) implement the int (*start_srp)(struct otg_transceiver *otg);
method as defined by the ULPI spec.

2) and then add a call (along with huge comment explaining this workaround)
to otg_start_srp(). I'd recommend to restrict this call to that specific board somehow,
but it is up to Sascha to decide where to put it.

-- 
Regards,
Igor.
