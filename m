From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 23 Dec 2010 21:11:03 +0100
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <4D109C47.6020704@compulab.co.il> (Igor Grinberg's message of
	"Tue, 21 Dec 2010 14:23:35 +0200")
References: <20101220154853.254931637@rtp-net.org>
	<20101220155812.122749841@rtp-net.org>
	<4D109C47.6020704@compulab.co.il>
Message-ID: <8762ukb67c.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Hi Arnaud,
>
> On 12/20/10 17:48, Arnaud Patard (Rtp) wrote:
>> Current code doesn't handle setting CHRGVBUS when enabling vbus.
>> Add support for it
>>
>>
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: tst-usb/drivers/usb/otg/ulpi.c
>> ===================================================================
>> --- tst-usb.orig/drivers/usb/otg/ulpi.c	2010-12-20 15:38:41.000000000 +0100
>> +++ tst-usb/drivers/usb/otg/ulpi.c	2010-12-20 15:38:57.000000000 +0100
>> @@ -234,7 +234,8 @@
>>  {
>>  	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
>>  
>> -	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT);
>> +	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT |
>> +			ULPI_OTG_CTRL_CHRGVBUS);
>>  
>>  	if (on) {
>>  		if (otg->flags & ULPI_OTG_DRVVBUS)
>> @@ -242,6 +243,9 @@
>>  
>>  		if (otg->flags & ULPI_OTG_DRVVBUS_EXT)
>>  			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
>> +
>> +		if (otg->flags & ULPI_OTG_CHRGVBUS)
>> +			flags |= ULPI_OTG_CTRL_CHRGVBUS;
>>  	}
>>  
>>  	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>
> I think this is a wrong place to set the ChrgVbus bit.
> As for ULPI spec. 1.1:
> "3.8.7.1 Session Request Protocol (SRP)
> ULPI provides full SRP support. The Link uses the ChrgVbus and DischrgVbus bits
> in the OTG Control register to begin and end a session."
>
> So it is used for SRP.
> May be it is better to implement
> int    (*start_srp)(struct otg_transceiver *otg);
> method for setting this bit?
>
I was not sure on where to put this so I took the same approach as the
fsl bsp which was to set it in this function and to call this function
_after_ usb_add_hcd() [ see my previous patch ]. Indeed, it fixed my
issue so I believe it not so bad given that there has already been some
troubles on the ehci-mxc init.

Arnaud
