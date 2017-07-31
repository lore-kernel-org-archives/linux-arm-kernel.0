From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 31 Jul 2017 18:17:38 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <20170731153009.xkjknygpmckv2pfp@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
Message-ID: <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Mon, Jul 31, 2017 at 5:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Patches can be applied independently since the DTS changes without driver
>> changes are no-op and the OF table won't be used without the DTS changes.
>
> But there is a dependency, no? If I apply the driver patch,
> non-converted device trees will not find their eeproms anymore. So, I

I don't think that's correct. If you apply this patch before the DTS
changes, the driver will still match using the I2C device ID table
like it has been doing it until today.

IOW, this is what will happen:

1- an OF device is registered with the wrong compatible (not found in
the OF table)
2- the I2C core strips the vendor part and fills the struct i2c_client
.name with the device part.
3- i2c_device_match() will be called since a new device has been registered
4- i2c_of_match_device() will fail because there's no OF entry that
matches the device compatible
5- the I2C core fallbacks to i2c_match_id() and matches using the I2C
device ID table.

So no noticeable difference AFAICT in that case.

Best regards,
Javier
