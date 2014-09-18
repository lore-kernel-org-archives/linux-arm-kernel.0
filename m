From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Sep 2014 21:17:18 -0700
Subject: About RK3288 i2c scl duty cycle
In-Reply-To: <541A34C3.6000400@rock-chips.com>
References: <2014091709302172205233@rock-chips.com>
 <CAD=FV=VEUVxxZ8ZP89qhSOmvX_LgMvnczNx17qdMTGCapZj3uw@mail.gmail.com>
 <541A34C3.6000400@rock-chips.com>
Message-ID: <CAD=FV=WLH_md15gUu0tGXvVE0nTLkgc6hPhMMMQBb9h3qNwptw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Sep 17, 2014 at 6:26 PM, addy ke <addy.ke@rock-chips.com> wrote:
> Add public list
>
> On 2014/9/17 23:17, Doug Anderson wrote:
>> Addy,
>>
>> On Tue, Sep 16, 2014 at 6:30 PM, addy.ke at rock-chips.com
>> <addy.ke@rock-chips.com> wrote:
>>> hi, all
>>
>> Any reason why you didn't add some public lists?  It seems like this
>> is a perfect discussion for linux-i2c.
>>
>>
>>> According to i2c-bus specification(version2.1, page 32, Table5, FAST-MODE):
>>> The minimum LOW period of the scl clock is <1.3us>, and the minimum HIGH
>>> period of the scl clock is <0.6us>.
>>> T(min_low) : T(min_high)  ~= 2 : 1
>>>
>>> If <DIVH = DIVL> in fast mode(scl rate = 400Khz)
>>> 1?Under ideal conditions, T(scl_low) = T(scl_high) = <1.25us>
>>> 2?Our measurement, T(scl_low) = <1.3us>, T(scl_high) = <1.25us>
>>>
>>> The low period of the scl clock is critical.
>>>
>>> Do we need set <DIVL:DIVH = 1 : 2>  to increase T(scl_low)?   // T(scl_low )
>>> : T(scl_High) = 2 : 1
>>
>> I can't say I've ever looked at that pat of the i2c spec before, but
>> what you say seems reasonable to me.  ...well for 400kHz, at least.
>> At 100kHz you shouldn't use the same 2:1 ratio.
>
> Yes, in normal-mode(100K) we can be only used 1:1 ratio.
> But in FAST-MODE maybe we must use 2:1 ratio.
> ----
> In Table 5(Characteristics of the SDA and SCL bus lines for F/S-mode I2C-bus devices)
>
> 1)FAST-MODE(400K):
>   The minimum LOW period of the scl clock                1.3us
>   the minimum HIGH period of the scl clock               0.6us
>   T(min_low) : T(min_high)  ~= 2 : 1
>
>   But I can't see any ratio about In FAST-mode(400k) and Normal-mode(100k).
> 2)Normal-MODE(100K):
>   The minimum LOW period of the scl clock                4.7us
>   the minimum HIGH period of the scl clock               4.0us
>   T(min_low) : T(min_high)  ~= 1 : 1

You might as well do the math all the way correctly.  That is for
clock > 100kHz use 47 / 87 and 40 / 87.  For clock <= 100kHz use 13 /
19 and 6 / 19

I think that'll give us a max margin, or (given perfect precision):
* a low of 5.4us (10 * 47 / 87.) and a high of 4.6us (10 * 40 / 87.) for 100kHz
* a low of 1.7us and a high of .8us for 400kHz


> 3) HS-mode(3.4M)
>   ratio of 1 to 2 is required, decribed as follows:
>   Hs-mode master devices generate a serial clock signal with a HIGH to LOW ratio of 1 to 2

You forgot about Fast Mode Plus!  ;)  You should probably think of
that before High Speed (IMHO)...

...seriously, though, I think you should send up a patch to do 400kHz
right first, then worry about fast mode plus and high speed.  I
haven't read through the whole i2c-rk3x.c driver, but I can't quite
believe that HS mode is supported right now.  It requires a whole
bunch of extra negotiation.


-Doug
