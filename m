From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 11 Jan 2011 09:41:32 +0200
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <878vys7saf.fsf@lechat.rtp-net.org>
References: <20101220154853.254931637@rtp-net.org>	<20101220155812.122749841@rtp-net.org>	<4D109C47.6020704@compulab.co.il>
	<8762ukb67c.fsf@lechat.rtp-net.org>	<4D14B69D.4030506@compulab.co.il>
	<87fwta8b99.fsf@lechat.rtp-net.org>	<4D21D00C.3040601@compulab.co.il>
	<87bp3y84ng.fsf@lechat.rtp-net.org>	<4D22D256.2040504@compulab.co.il>
	<87sjx8783g.fsf@lechat.rtp-net.org>	<AANLkTimWfucS6XqovGDCyVhM20HgKpxCwTOkeHKzqK29@mail.gmail.com>	<4D257553.30101@compulab.co.il>
	<87hbdl6q96.fsf@lechat.rtp-net.org>	<4D2B0D7E.3080801@compulab.co.il>
	<878vys7saf.fsf@lechat.rtp-net.org>
Message-ID: <4D2C09AC.8060305@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/11 16:22, Arnaud Patard (Rtp) wrote:

> Igor Grinberg <grinberg@compulab.co.il> writes:
>> Can you, please, send patches inline and not as attachments next time?
>> It is very inconvenient to review and comment on attached patches.
> This patch a quick rewrite&test. It was more meant to understand if the
> direction was right rather than a formal submission. (I use quilt to
> send patches and not my mailer). There are some comment in the code
> needed and I've not put them.

Well, I also have got all other patches in the series as attachments...
Why not use git send-email?

>> On 01/07/11 11:02, Arnaud Patard (Rtp) wrote:
>>> What about the following patch ?
>>> ulpi: provide start_srp
>>>
>>> Add support for setting CHRGVBUS thanks to start_srp and use it
>>> to workaround a hardware bug on efika mx/sb boards.
>>> See http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/037341.html
>>>
>>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>> Index: linux-2.6-submit/drivers/usb/otg/ulpi.c
>>> ===================================================================
>>> --- linux-2.6-submit.orig/drivers/usb/otg/ulpi.c	2011-01-04 17:12:26.000000000 +0100
>>> +++ linux-2.6-submit/drivers/usb/otg/ulpi.c	2011-01-06 14:44:50.000000000 +0100
>>> @@ -247,6 +247,14 @@
>>>  	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>>>  }
>>>
>>> +static int ulpi_start_srp(struct otg_transceiver *otg, bool on)
>>> +{
>>> +	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
>>> +
>>> +	flags |= ULPI_OTG_CTRL_CHRGVBUS;
>>> +	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>>> +}
>>> +
>> I went through the OTG spec. and found that there are much more things
>> should be done for the start_srp() function to be implemented properly.
>> For example, it says that we should make sure that the Vbus is discharged
>> (means, the previous session has finished) before attempting to start a new
>> session, but that is only a half of the problem. The real problem for you, is that
>> the duration of the SRP should be no more then 100ms.
> oops. That's really annoying. (fwiw, I think that original code from fsl
> doesn't take care of that 100ms delay otherwise I guess I would have
> detected it too).
>>>  struct otg_transceiver *
>>>  otg_ulpi_create(struct otg_io_access_ops *ops,
>>>  		unsigned int flags)
>>> @@ -263,6 +271,7 @@
>>>  	otg->init	= ulpi_init;
>>>  	otg->set_host	= ulpi_set_host;
>>>  	otg->set_vbus	= ulpi_set_vbus;
>>> +	otg->start_srp	= ulpi_start_srp;
>>>
>>>  	return otg;
>>>  }
>>> Index: linux-2.6-submit/drivers/usb/host/ehci-mxc.c
>>> ===================================================================
>>> --- linux-2.6-submit.orig/drivers/usb/host/ehci-mxc.c	2011-01-06 14:45:14.000000000 +0100
>>> +++ linux-2.6-submit/drivers/usb/host/ehci-mxc.c	2011-01-06 15:48:16.000000000 +0100
>>> @@ -25,6 +25,8 @@
>>>
>>>  #include <mach/mxc_ehci.h>
>>>
>>> +#include <asm/mach-types.h>
>>> +
>>>  #define ULPI_VIEWPORT_OFFSET	0x170
>>>
>>>  struct ehci_mxc_priv {
>>> @@ -239,6 +241,13 @@
>>>  			dev_err(dev, "unable to enable vbus on transceiver\n");
>>>  			goto err_add;
>>>  		}
>>> +		if (machine_is_mx51_efikamx() || machine_is_mx51_efikasb()) {
>>> +			ret = otg_start_srp(pdata->otg);
>>> +			if (ret) {
>>> +				dev_err(dev, "unable to start srp\n");
>>> +				goto err_add;
>>> +			}
>>> +		}
>> In light of the problem described above, here you will need to write directly
>> to the view port instead of calling the otg_start_srp() function.
> ok. I don't think it's a problem. Looks otg_io_(read|write) are
> available here.

yeah, otg_io_(read|write) should do.

>> I'd recommend to move this to the machine (board) specific code.
>> May be to platform init (pdata->init) call back?
> oh, no. I've put this call in this place for some good reasons. This
> trick is working only if it's done _after_ add_hcd. Any other place
> won't work. For instance, pdata->init is meant to be called before
> mxc_initialise_usb_hw iirc which is _before_ add_hcd.

I see. The reason, I'd like to move it to the board code is a possibility that h/w will
change (hopefully even fixed) and then you will not have to violate the spec
anymore, but to deal with the h/w revision checking. ehci-mxc.c doesn't look
like a good place to deal with h/w revision checking of the board, so may be it is
worth to introduce some kind of another platform hook, like pdata->late_init?

I don't insist, it is up to you and Sascha to decide what's the best choice here.

>> IMHO, the explanation of the h/w bug workaround in the commit message
>> is not enough - in-code comment regarding the bug workaround should be added.
> I know. As I said this patch was not the final submission. It was
> probably not clear enough.
>
> Arnaud

-- 
Regards,
Igor.
