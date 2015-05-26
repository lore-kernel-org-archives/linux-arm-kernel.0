From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 26 May 2015 14:24:37 -0700
Subject: [PATCH v2] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <CALHpu34OpsfrWLZmrBB5mTVoiyAiEpsnuq7rSf95c9xHYrqzJQ@mail.gmail.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
 <1432251947-13335-1-git-send-email-tharvey@gateworks.com>
 <20150524024836.GA3264@dragon>
 <CALHpu34OpsfrWLZmrBB5mTVoiyAiEpsnuq7rSf95c9xHYrqzJQ@mail.gmail.com>
Message-ID: <CAJ+vNU0t70Df8t+zv=vqaL_uzv=TQ8EHxKm67FNGSKMmq6Lfkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 23, 2015 at 10:19 PM, Jon Nettleton <jon.nettleton@gmail.com> wrote:
> On Sun, May 24, 2015 at 4:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Thu, May 21, 2015 at 04:45:47PM -0700, Tim Harvey wrote:
>>> The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP which
>>> is valid for all IMX6 SoC's (despite the fact that the IMXSDLRM and
>>> IMXSXRM do not document this - this has been proven via tests as well as
>>> verified by Freescale FAE).
>>>
>>> Instead of assuming a fixed 85C for passive cooling threshold and 105C for
>>> critical use the thermal grade for these configurations.
>>>
>>> We will set the critical to maxT - 5C and passive to maxT - 10C.
>
> I would like to chime in here if you don't mind.  I have been carrying
> a patch similar to this in the SolidRun repo to fix cooling issues
> that we have had.  I would recommend keeping the passive temp at maxT
> - 20C due to the thermal properties of the chip.  I have found that
> around 85-90C we can maintain a relatively steady thermal state with
> only passive cooling.  Generally with a hard non-NEON based cpu
> workload the iMX6 will level off at about 87C with all the cores
> clocked to 1Ghz, and sometimes dipping down to 800Mhz periodically.
> With a NEON based workload on all the cores it will push beyond this
> and generally end up finding steady state at about 800Mhz right around
> 90C.
>
> If you raise the initial passive threshold by 10C it will allow enough
> heat to build up in the chip that the only way to avoid reaching
> critical temps is by dropping the CPU down to its lowest frequency.
> This is not the best experience as then you have a much warmer chip
> and if the workload doesn't change you will just be switching between
> running at the highest cpu frequency or lowest which makes for a
> choppy experience.  A longer passive cooling zone allows the
> temperature of the chip to be regulated using only passive methods but
> without drastic performance drops.
>
> I am doing things a bit differently in my implementation as I setup a
> passive cooling zone for each cpu frequency, but that is just so you
> can have more control from userspace by changing the different passive
> trip points.
>
> -Jon

Jon,

I can agree with leaving a Max-20C passive delta. What do you think
about the critical threshold of Max-5C and rule of not allowing it to
be changed?

Tim
