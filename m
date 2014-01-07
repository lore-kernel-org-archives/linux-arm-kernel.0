From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 07 Jan 2014 10:53:00 +0100
Subject: [PATCH 1/2] phy-core: Don't print an error on probe deferral
 or nodata
In-Reply-To: <52CBC956.6050106@ti.com>
References: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
 <52CBC956.6050106@ti.com>
Message-ID: <52CBCE7C.3040202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/2014 10:31 AM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Monday 06 January 2014 04:36 AM, Hans de Goede wrote:
>> Printing an error on probe-deferral clearly is not the right thing to do.
>> While at it I've also silenced the error in case of -ENODATA, so that
>> devm_phy_get can be used to get an optional phy without causing errors to
>
> What do you mean by optional phy here?

Some generic platform drivers, ie drivers/usb/host/ehci-platform.c
(with some extensions to make it more generic I'm working on), may
take a phy in the devicetree-node, but having a phy is not mandatory,
the code using the phy will all be guarded against the phy not being
there and only call phy_ functions if it is actually there.

For this use case it would be nice if in this case devm_phy_get would
return an error code, but not do a dev_err, so as to not pollute dmesg
with irrelevant / wrong error messages.

The regulator core has devm_regulator_get_optional for this, so
if you don't want this silent behavior in devm_phy_get by default,
I can do write a different patch adding devm_phy_get_optional
instead.

Also I've just realized that this check:

>> +		if (err != -EPROBE_DEFER && err != -ENODATA)
>> +			dev_err(dev, "unable to get phy\n");

Is incomplete to also be silent when no phy-names are specified,
it should be:

	if (err != -EPROBE_DEFER && err != -ENODATA && err != -EINVAL)
		dev_err(dev, "unable to get phy\n");

I'll fix this (or add a devm_phy_get_optional) in v2 of this set.

Regards,

Hans
