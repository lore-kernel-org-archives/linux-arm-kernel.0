From: dianders@chromium.org (Doug Anderson)
Date: Thu, 25 Sep 2014 14:52:08 -0700
Subject: [PATCH] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
References: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=WiHR+KcTWHnma6TdPQcc3oc4wqAofj5kF=Sgec_5kGAQ@mail.gmail.com>
 <54227F93.7000507@rock-chips.com>
 <CAD=FV=Uq9AteUcpMvcU5tmyGZbVYWM6PNmevZXSVCkYB8rqSsQ@mail.gmail.com>
 <5423765B.8000706@rock-chips.com>
 <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
Message-ID: <CAD=FV=UkAcR8b+T_Dvoy9STDfzyC8QVSawihoHLYyHFJ6bfXxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Sep 24, 2014 at 9:36 PM, Doug Anderson <dianders@chromium.org> wrote:
> Addy,
>
> On Wed, Sep 24, 2014 at 6:56 PM, addy ke <addy.ke@rock-chips.com> wrote:
>> In my measurement,all paramter but "Data hold time" are match the characteristics of SCL bus line.
>> the measured value is 0.928us("data hold time on RK3X"  ~=  "the low period / 2")
>> but the maximum value described in table is 0.9us
>>
>> About "Data hold time", there are described in I2C specification:
>> - for CBUS compatible masters for I2C-bus deivices
>> - the maximum data hold time has only be met if the device does not stretch the LOW period of the SCL signal.
>>
>> I have tested on RK3288-Pinky board, there are no error.
>> But I don't known whether this paramter will affect i2c communications.
>
> I'll have to spend more time tomorrow to really understand this, but
> if changing the code to bias towards slightly longer "high" times
> instead of "low" times helps fix it then that's fine with me.

So what you're saying is that you're seeing a case where the clock
goes low and the data is not valid until .928us.  Is this data that is
being driven by the master or data that is being driven by the slave?

Do you know why the data takes so long to be valid?  Maybe you can
email me some of the waveforms and I can try to help you debug it.


In any case it sounds like the the "data hold time" problem is
unrelated to the clock ratio problem (right?), so maybe you could send
out patch v2?

-Doug

P.S. I checked the Rockchip TRM and it claims 400kHz maximum i2c.  I
think that means you can just remove all of the "fast mode plus" and
"high speed mode" clock rates from your table.
