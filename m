From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 1 Nov 2011 11:29:32 -0500
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B34BEE2@wm021.weinmann.com>
References: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
	<CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D087B34BE8B@wm021.weinmann.com>
	<CAF8ieYWY2RwkgPERgagvw2bby8Y+UFgrYr3zPOb27e=bfOH-vg@mail.gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D087B34BEE2@wm021.weinmann.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DF77673@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 01, 2011 1:02 AM, Voss, Nikolaus wrote:
>> It is never correct to use push-pull I/O for i2c, so the flag does not
>> specify the desired behavior of the driver, it specifies what the
>> hardware has been configured to do so that the driver can choose the
>> cheapest way to do open-drain I/O.
>
> Ok, seems rather logical after all.
>
>> 
>> And even if you could argue that the flag should be inverted, it has
>> had the same meaning since the driver was introduced several years
>> ago, so changing it now will break every single platform which
>> currently uses i2c-gpio.
>
> I completely agree.
>

Just for the record...

The GPIO pins used for I2C on the ep93xx platform can be configured as
open-drain I/O pins.  When they are, and external pull-ups are applied
to the signals, the I2C bus works correctly when the "is_open_drain"
flags are set.  If the pull-ups are missing the bus does not work.
If the "is_open_drain" flags are not set, the I2C bus works correctly
regardless of the existence of the pull-ups.

Based on that I think the i2c-gpio driver's use of the "is_open_drain"
flags is correct.

Regards,
Hartley
