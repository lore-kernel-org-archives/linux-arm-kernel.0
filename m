From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 2 Jul 2014 11:45:56 +0100
Subject: drm/i2c: tda998x: Set CEC I2C address from TDA I2C address
In-Reply-To: <20140702102513.GF32514@n2100.arm.linux.org.uk>
References: <53B3D1F8.7080106@arm.com>
 <20140702102513.GF32514@n2100.arm.linux.org.uk>
Message-ID: <53B3E2E4.20209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 11:25, Russell King - ARM Linux wrote:
> You missed me as the maintainer of the driver:

Sorry, an over-sight on my part.

> NXP TDA998X DRM DRIVER
> M:      Russell King <rmk+kernel@arm.linux.org.uk>
> S:      Supported
> F:      drivers/gpu/drm/i2c/tda998x_drv.c
> F:      include/drm/i2c/tda998x.h
>
> On Wed, Jul 02, 2014 at 10:33:44AM +0100, Andrew Jackson wrote:
>> @@ -1274,9 +1275,9 @@ tda998x_encoder_init(struct i2c_client *client,
>>
>>         priv->current_page = 0xff;
>>         priv->hdmi = client;
>> -       priv->cec = i2c_new_dummy(client->adapter, 0x34);
>> -       if (!priv->cec)
>> -               priv->cec = i2c_new_dummy(client->adapter, 0x35);
>> +       /* CEC I2C address bound to TDA998x I2C addr by configuration pins */
>> +       cec_addr = 0x34 + (client->addr & 3);
>> +       priv->cec = i2c_new_dummy(client->adapter, cec_addr);
>
> We discussed the issue of the I2C CEC address when the DT binding first
> came up...
>
> Do we know for certain that the above is always true for all the devices
> that this driver supports?

I know that it is true for the following:

        * TDA9989 (Both lower LSBs are zero)
        * TDA19988 (LSBs are set from configuration pins)
        * TDA19989 (Both lower LSBs are zero)

I don't know about the N2 variants of the various devices.

I have tested the patch on board containing two TDA19988s.


   Andrew


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
