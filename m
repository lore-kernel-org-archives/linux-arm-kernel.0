From: currojerez@riseup.net (Francisco Jerez)
Date: Tue, 11 Jun 2013 17:10:12 +0200
Subject: [PATCH] drm: encoder_slave: respect of_node on i2c encoder init
In-Reply-To: <51B6D91D.3000906@gmail.com> (Sebastian Hesselbarth's message of
 "Tue, 11 Jun 2013 10:00:29 +0200")
References: <1370899422-1281-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130611072433.GP22870@phenom.ffwll.local>
 <51B6D91D.3000906@gmail.com>
Message-ID: <8738soptt7.fsf@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

>> - I think we could also drop the call to ->set_config since presumably an
>>    of-enabled driver grabbed any required info already from the dt.
>[...]
>> I think this way we could still share encoder slaves across tons of
>> platforms, only the init sequence (and specifically how they get at their

The "set_config" hook is just the way a DRM driver communicates those
board-specific differences in the init sequence to the slave encoder
driver.  I don't think it would make sense to remove it unless we make
sure it's being called elsewhere.

>
> IMHO, the whole i2c encoder stuff is just wrong. Not any i2c slave
> driver is even really using its probe(). Everything is packed somewhere
> because it just worked.. this is at least a start.
>
Why is that?  What do you mean by the probe hooks not being used?
ch7006 and sil164 rely on it being called on initialization.

> I suggest this to get merged to at least allow to have DT slaves,
> then start with improving tda998x as an example, then maybe rethink
> drm_slave_encoder completely, e.g.
>
> - generalize the concept to SPI attached encoders, "internal" encoders..

drm_encoder_slave is bus-agnostic.  drm_i2c_encoder_init() is just a
helper function taking care of bus-specific details like the creation of
the underlying I2C device object, which cannot be made bus-agnostic for
obvious reasons.  You're welcome to implement SPI and internal
counterparts of drm_i2c_encoder_init().

> - find a way to setup .encoder_type and .connector_type correctly

I guess encoder_type could be initialized correctly from the slave
encoder_init() hook -- that hasn't been necessary until now because the
DRM driver making use of the slave encoder has been expected to have
some other means to find out encoder types [e.g. device-specific BIOS
tables].  OTOH, I don't think that setting connector types is the slave
encoder's business.

> - have more common of_drm_blabla helpers
>
>> config data) would be different. That would also be extensible quite
>> easily (*cough* intel platforms could setup encoder slaves from
>> information out of the vbt *cough*).
>>
>[...]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 229 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/0870508c/attachment.sig>
