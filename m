From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Wed, 27 May 2015 08:08:36 +0200
Subject: [PATCH v2] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <CAJ+vNU0t70Df8t+zv=vqaL_uzv=TQ8EHxKm67FNGSKMmq6Lfkw@mail.gmail.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
 <1432251947-13335-1-git-send-email-tharvey@gateworks.com>
 <20150524024836.GA3264@dragon>
 <CALHpu34OpsfrWLZmrBB5mTVoiyAiEpsnuq7rSf95c9xHYrqzJQ@mail.gmail.com>
 <CAJ+vNU0t70Df8t+zv=vqaL_uzv=TQ8EHxKm67FNGSKMmq6Lfkw@mail.gmail.com>
Message-ID: <CALHpu37a5O9x16MY7jk6TT+b9xqVsaRn=oh1_MLWydL3uX3drw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 11:24 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Sat, May 23, 2015 at 10:19 PM, Jon Nettleton <jon.nettleton@gmail.com> wrote:
>> On Sun, May 24, 2015 at 4:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>> On Thu, May 21, 2015 at 04:45:47PM -0700, Tim Harvey wrote:
>>>> The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP which
>>>> is valid for all IMX6 SoC's (despite the fact that the IMXSDLRM and
>>>> IMXSXRM do not document this - this has been proven via tests as well as
>>>> verified by Freescale FAE).
>>>>
>>>> Instead of assuming a fixed 85C for passive cooling threshold and 105C for
>>>> critical use the thermal grade for these configurations.
>>>>
>>>> We will set the critical to maxT - 5C and passive to maxT - 10C.
>>
>> I would like to chime in here if you don't mind.  I have been carrying
>> a patch similar to this in the SolidRun repo to fix cooling issues
>> that we have had.  I would recommend keeping the passive temp at maxT
>> - 20C due to the thermal properties of the chip.  I have found that
>> around 85-90C we can maintain a relatively steady thermal state with
>> only passive cooling.  Generally with a hard non-NEON based cpu
>> workload the iMX6 will level off at about 87C with all the cores
>> clocked to 1Ghz, and sometimes dipping down to 800Mhz periodically.
>> With a NEON based workload on all the cores it will push beyond this
>> and generally end up finding steady state at about 800Mhz right around
>> 90C.
>>
>> If you raise the initial passive threshold by 10C it will allow enough
>> heat to build up in the chip that the only way to avoid reaching
>> critical temps is by dropping the CPU down to its lowest frequency.
>> This is not the best experience as then you have a much warmer chip
>> and if the workload doesn't change you will just be switching between
>> running at the highest cpu frequency or lowest which makes for a
>> choppy experience.  A longer passive cooling zone allows the
>> temperature of the chip to be regulated using only passive methods but
>> without drastic performance drops.
>>
>> I am doing things a bit differently in my implementation as I setup a
>> passive cooling zone for each cpu frequency, but that is just so you
>> can have more control from userspace by changing the different passive
>> trip points.
>>
>> -Jon
>
> Jon,
>
> I can agree with leaving a Max-20C passive delta. What do you think
> about the critical threshold of Max-5C and rule of not allowing it to
> be changed?
>

Tim,

I definitely agree that the Critical temp should be a fixed point.  Is
the purpose of lowering the critical threshold from the hardware
default, to allow Linux to shutdown more cleanly rather than just have
the hardware shutting down?  If that is the case then I think that is
fine.  If it is to protect the SOC then that is unnecessary.  We have
heated the SOCs to well beyond the critical threshold and they have
survived just fine.

This is a bit out of context but here is the formula I am using to
figure out my trip points.  By default I use a linear set of trip
points for passive cooling.
https://github.com/linux4kix/linux-linaro-stable-mx6/commit/212c17d543739a5fe0bd75b66c10f05177e8bcb0

The short of it is I set a trip delta of 6C and then figure out the
lowest passive trip point as Critical - (#passive trip points * trip
delta), where each cpu frequency stage is a passive trip point.  This
will allow an 800Mhz SOC with 2 trip points to run at full speed
longer than a 1.2Ghz with 4 trip points.  The idea being that the
higher the clock rate means we will generate more heat and have more
passive cooling levels so it is better to drop the top speed of the
CPU earlier in order to let the passive cooling be effective and find
a steady state.

This may be a bit over the top but has fixed problems where long
running processes would build up heat and eventually cause a thermal
shutdown, but doesn't completely cripple the faster SOCs.
