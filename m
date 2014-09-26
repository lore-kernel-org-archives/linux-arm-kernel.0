From: dianders@chromium.org (Doug Anderson)
Date: Thu, 25 Sep 2014 19:08:18 -0700
Subject: [PATCH] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <5424C41F.8030508@rock-chips.com>
References: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=WiHR+KcTWHnma6TdPQcc3oc4wqAofj5kF=Sgec_5kGAQ@mail.gmail.com>
 <54227F93.7000507@rock-chips.com>
 <CAD=FV=Uq9AteUcpMvcU5tmyGZbVYWM6PNmevZXSVCkYB8rqSsQ@mail.gmail.com>
 <5423765B.8000706@rock-chips.com>
 <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
 <CAD=FV=UkAcR8b+T_Dvoy9STDfzyC8QVSawihoHLYyHFJ6bfXxQ@mail.gmail.com>
 <5424C41F.8030508@rock-chips.com>
Message-ID: <CAD=FV=WhBhmCO=GamNr7yyXvLmOFDro8zWVwrj1zQVYogzeyVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Thu, Sep 25, 2014 at 6:40 PM, addy ke <addy.ke@rock-chips.com> wrote:
> Hi, Doug
>
> On 2014/9/26 5:52, Doug Anderson wrote:
>> Addy,
>>
>> On Wed, Sep 24, 2014 at 9:36 PM, Doug Anderson <dianders@chromium.org> wrote:
>>> Addy,
>>>
>>> On Wed, Sep 24, 2014 at 6:56 PM, addy ke <addy.ke@rock-chips.com> wrote:
>>>> In my measurement,all paramter but "Data hold time" are match the characteristics of SCL bus line.
>>>> the measured value is 0.928us("data hold time on RK3X"  ~=  "the low period / 2")
>>>> but the maximum value described in table is 0.9us
>>>>
>>>> About "Data hold time", there are described in I2C specification:
>>>> - for CBUS compatible masters for I2C-bus deivices
>>>> - the maximum data hold time has only be met if the device does not stretch the LOW period of the SCL signal.
>>>>
>>>> I have tested on RK3288-Pinky board, there are no error.
>>>> But I don't known whether this paramter will affect i2c communications.
>>>
>>> I'll have to spend more time tomorrow to really understand this, but
>>> if changing the code to bias towards slightly longer "high" times
>>> instead of "low" times helps fix it then that's fine with me.
>>
>> So what you're saying is that you're seeing a case where the clock
>> goes low and the data is not valid until .928us.  Is this data that is
>> being driven by the master or data that is being driven by the slave?
>>
> It is driven by the master and will be release at half of LOW period in our IC design.

Ah, I didn't know this.  Is that in the TRM somewhere?

...so does it work to just replace:

    ideal_low_div = DIV_ROUND_UP(clk_rate * min_low_ns,
                                 scl_rate * 8 * min_total_ns)

...with:

    ideal_low_div = min_low_div


That will assign all "extra" time to the "high" part.

-Doug
