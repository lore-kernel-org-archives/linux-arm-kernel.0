From: Mylene.Josserand@navocap.com (Mylene Josserand)
Date: Fri, 24 May 2013 11:52:54 +0200
Subject: [I2C] informations + advice about messages handling
In-Reply-To: <20130524110706.6052493e@endymion.delvare>
References: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
 <CAK7N6vpg6QUAKODKO2Msr4+GTASLDpA2cG1teQV3yiwt7D4SSw@mail.gmail.com>
 <20130524094407.61d0ec42@endymion.delvare>
 <CA78C307B8F06747967D122FC656B15398644A@SERVEUR0.nvp.local>
 <20130524110706.6052493e@endymion.delvare>
Message-ID: <CA78C307B8F06747967D122FC656B15398644B@SERVEUR0.nvp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/05/2013 11:07, Jean Delvare a ?crit :
 > On Fri, 24 May 2013 10:54:11 +0200, Mylene Josserand wrote:
 >> Ah okay ! And if there are not SMBus compliant, what function I will
 >> have to use ?
 >
 > i2c_transfer()


Okay, logic name ;)


 >> What is it doing if I use this function and that my device is not SMbus
 >> compliant ?
 >
 > This would make no sense. Your device understands only specific message
 > formats, which should be documented in its datasheet. You have to use
 > exactly that in your driver. If the message format matches SMBus, you
 > can use the SMBus API, otherwise you must use i2c_transfer() instead.

Very interesting !
Right now, my company uses the "i2c_smbus_read/write_byte_data" 
functions to talk to devices through an application. On the datasheet of 
these devices, I search but did not seem to be SMBus compliant.
As it was a software which was using these functions, we thought that a 
driver (that I would write) should be better. And here I am ! I prefer 
to understand well the mechanism before coding anything and it is 
interesting !


 >> I have some difficulties to understand the differences
 >> between SMbus and I2C :(
 >
 > SMBus is a subset of I2C. With I2C you can have messages of any length
 > and any format, with no attached semantics. SMBus restricts the
 > possibilities to a few standardized messages formats with semantics. If
 > you'd just tell us what your device is, we would be able to tell you if
 > SMBus will work or if I2C will be needed.

Thanks for the explanation.
No problem, we have 2 devices used without drivers :
- an odometer PIC18F24201 : In the datasheet, there is a SMBus select 
bit but I don't know if it is SMBus compliant.
- an audio codec tlv320aic3204 : There is a driver for this device but 
for some reasons, we did not use it. Did not find a "SMBus compliant" in 
its datasheet.


 >> (...)
 >> In my case, I have 2 segments but if I understand, the bus will not be
 >> used at the same time.
 >
 > I can't comment on that without knowing the exact topology. In
 > particular, do you have two independent segments each with its own
 > controller, or are they interconnected in some way? I2C/SMBus is very
 > simple with basic topologies but can become difficult with complex ones.

Yes of course, I understand.
For that, I will ask to our "hardware guy".


 >> (...)
 >> Okay. So the mutex blocks the I2C bus. And is it locking the bus at the
 >> beginning of a message (so when a START is send) and unlocking it after
 >> the STOP ?
 >
 > Yes.
 >
 >> So a complete message will be sent to a same device (the one which
 >> address is in the data frame) ? A device can not receive a beginning of
 >> one message (so with his address) and the end of another message
 >> destined to another device [because of "collision"], for example ?
 >
 > No, this cannot happen.


Thanks a lot for your help !


-- 
Myl?ne JOSSERAND
