From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 10 Jan 2011 15:22:00 +0100
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <4D2B0D7E.3080801@compulab.co.il> (Igor Grinberg's message of
	"Mon, 10 Jan 2011 15:45:34 +0200")
References: <20101220154853.254931637@rtp-net.org>
	<20101220155812.122749841@rtp-net.org>
	<4D109C47.6020704@compulab.co.il> <8762ukb67c.fsf@lechat.rtp-net.org>
	<4D14B69D.4030506@compulab.co.il> <87fwta8b99.fsf@lechat.rtp-net.org>
	<4D21D00C.3040601@compulab.co.il> <87bp3y84ng.fsf@lechat.rtp-net.org>
	<4D22D256.2040504@compulab.co.il> <87sjx8783g.fsf@lechat.rtp-net.org>
	<AANLkTimWfucS6XqovGDCyVhM20HgKpxCwTOkeHKzqK29@mail.gmail.com>
	<4D257553.30101@compulab.co.il> <87hbdl6q96.fsf@lechat.rtp-net.org>
	<4D2B0D7E.3080801@compulab.co.il>
Message-ID: <878vys7saf.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Hi Arnaud,

Hi,
>
>
> Can you, please, send patches inline and not as attachments next time?
> It is very inconvenient to review and comment on attached patches.

This patch a quick rewrite&test. It was more meant to understand if the
direction was right rather than a formal submission. (I use quilt to
send patches and not my mailer). There are some comment in the code
needed and I've not put them.

> Comments below.
>
> On 01/07/11 11:02, Arnaud Patard (Rtp) wrote:
>> Hi
>>
>> Igor Grinberg <grinberg@compulab.co.il> writes:
>> [...]
>>> Thanks for the information. Now I am finally getting the picture of what's is
>>> going on there...
>>>
>>>> On the Smartbook at least both USB host ports (H1 and H2) on the board
>>>> (one port each) are connected directly to 4-port USB hubs (SMSC2514).
>>>> We don't have anything on there except that connection: the hub should
>>>> handle VBUS properly. Both ports use an SMSC3317 (just a 3311 with a
>>>> built in 3.3V supply so the id and behavior should be identical).
>>> OK, so the SMSC331x ulpi transceiver is connected to the SMSC2514 usb hub,
>>> so all the peripheral devices (ethernet/wifi/bt/hid) are connected to the
>>> downstream ports of that hub and thus get their Vbus as expected. This is fine.
>>>
>>>> On the Smarttop H1 is connected to a 4-port USB hub (Terminus FE1.1)
>>>> with the same configuration. Same PHY. The DR port is connected
>>>> directly to an ASIX ethernet controller. VBUS seems routed to a test
>>>> point.
>>>>
>>>> I'm curious exactly what the real problem here is: that VBUS is
>>>> basically not being handled correctly? It should be driven or not? I'm
>>>> not entirely familiar with the specification.
>>> SMSC2514 usb hub will not provide power to its D+ and D- pull-up resistors
>>> until it detects a Vbus enabled on the upstream port. This is totally fine.
>>>
>>> SMSC331x ulpi transceiver does not have either an integrated Vbus switch or
>>> an integrated charge pump - this means that it cannot provide a Vbus to the hub.
>>>
>>> The hub in its turn does not power the pull-up resistors and peripheral devices
>>> are not being connected to the usb subsystem.
>>>
>>> With this patch applied, SMSC331x ulpi transceiver issues an SRP pulses on the Vbus
>>> and hub senses that there is something that looks like Vbus and then enables the
>>> pull-up resistors -> peripheral devices are being connected to the usb subsystem.
>>> This behavior violates the ULPI (and mostly certain OTG and may be also USB 2.0)
>>> specification and SMSC2514 usb hub datasheet.
>>>
>>> According to the SMSC2514 usb hub datasheet, VBUS_DET pin has to be connected
>>> to a valid Vbus from the upstream port, but SMSC331x does not provide this Vbus.
>>> This means that you should have add a Vbus switch or a charge pump to the
>>> VBUS_DET pin of the usb hub and provide means (like GPIO) to enable/disable that
>>> switch or charge pump.
>>> This is h/w design bug we are dealing with.
>>>
>>> The best solution to this would be to add a missing h/w component.
>>> Now, I understand that it can be kind a problematic ;)
>>> But, we cannot violate the ULPI spec and the generic driver to workaround
>>> some h/w problem that is existing in some specific configuration and hopefully will
>>> be fixed in the next h/w revisions. Therefore, as I said before, this patch is NAK.
>>>
>>> What we can do is:
>>> 1) implement the int (*start_srp)(struct otg_transceiver *otg);
>>> method as defined by the ULPI spec.
>>>
>>> 2) and then add a call (along with huge comment explaining this workaround)
>>> to otg_start_srp(). I'd recommend to restrict this call to that specific board somehow,
>>> but it is up to Sascha to decide where to put it.
>> What about the following patch ?
>> ulpi: provide start_srp
>>
>> Add support for setting CHRGVBUS thanks to start_srp and use it
>> to workaround a hardware bug on efika mx/sb boards.
>> See http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/037341.html
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/drivers/usb/otg/ulpi.c
>> ===================================================================
>> --- linux-2.6-submit.orig/drivers/usb/otg/ulpi.c	2011-01-04 17:12:26.000000000 +0100
>> +++ linux-2.6-submit/drivers/usb/otg/ulpi.c	2011-01-06 14:44:50.000000000 +0100
>> @@ -247,6 +247,14 @@
>>  	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>>  }
>>
>> +static int ulpi_start_srp(struct otg_transceiver *otg, bool on)
>> +{
>> +	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
>> +
>> +	flags |= ULPI_OTG_CTRL_CHRGVBUS;
>> +	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>> +}
>> +
>
> I went through the OTG spec. and found that there are much more things
> should be done for the start_srp() function to be implemented properly.
> For example, it says that we should make sure that the Vbus is discharged
> (means, the previous session has finished) before attempting to start a new
> session, but that is only a half of the problem. The real problem for you, is that
> the duration of the SRP should be no more then 100ms.

oops. That's really annoying. (fwiw, I think that original code from fsl
doesn't take care of that 100ms delay otherwise I guess I would have
detected it too).

> This means that my proposal under 1) is not good for you, sorry...
>
>>  struct otg_transceiver *
>>  otg_ulpi_create(struct otg_io_access_ops *ops,
>>  		unsigned int flags)
>> @@ -263,6 +271,7 @@
>>  	otg->init	= ulpi_init;
>>  	otg->set_host	= ulpi_set_host;
>>  	otg->set_vbus	= ulpi_set_vbus;
>> +	otg->start_srp	= ulpi_start_srp;
>>
>>  	return otg;
>>  }
>> Index: linux-2.6-submit/drivers/usb/host/ehci-mxc.c
>> ===================================================================
>> --- linux-2.6-submit.orig/drivers/usb/host/ehci-mxc.c	2011-01-06 14:45:14.000000000 +0100
>> +++ linux-2.6-submit/drivers/usb/host/ehci-mxc.c	2011-01-06 15:48:16.000000000 +0100
>> @@ -25,6 +25,8 @@
>>
>>  #include <mach/mxc_ehci.h>
>>
>> +#include <asm/mach-types.h>
>> +
>>  #define ULPI_VIEWPORT_OFFSET	0x170
>>
>>  struct ehci_mxc_priv {
>> @@ -239,6 +241,13 @@
>>  			dev_err(dev, "unable to enable vbus on transceiver\n");
>>  			goto err_add;
>>  		}
>> +		if (machine_is_mx51_efikamx() || machine_is_mx51_efikasb()) {
>> +			ret = otg_start_srp(pdata->otg);
>> +			if (ret) {
>> +				dev_err(dev, "unable to start srp\n");
>> +				goto err_add;
>> +			}
>> +		}
>
> In light of the problem described above, here you will need to write directly
> to the view port instead of calling the otg_start_srp() function.

ok. I don't think it's a problem. Looks otg_io_(read|write) are
available here.

>
> I'd recommend to move this to the machine (board) specific code.
> May be to platform init (pdata->init) call back?

oh, no. I've put this call in this place for some good reasons. This
trick is working only if it's done _after_ add_hcd. Any other place
won't work. For instance, pdata->init is meant to be called before
mxc_initialise_usb_hw iirc which is _before_ add_hcd.

>
> IMHO, the explanation of the h/w bug workaround in the commit message
> is not enough - in-code comment regarding the bug workaround should be added.

I know. As I said this patch was not the final submission. It was
probably not clear enough.

Arnaud
