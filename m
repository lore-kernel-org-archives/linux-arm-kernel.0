From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 Apr 2015 10:04:49 -0700
Subject: [PATCHv7 0/2] INPUT: Route keyboard LEDs through the generic LEDs
 layer
In-Reply-To: <20150423165544.GG7646@pali>
References: <20150217191527.GA9594@type.youpi.perso.aquilenet.fr>
 <201504012200.07408@pali>
 <20150401211140.GI2901@type.youpi.perso.aquilenet.fr>
 <20150402144410.GB18125@amd> <20150423165544.GG7646@pali>
Message-ID: <CAKdAkRSk4t2PKHB33f0=V2-zAhV9LXABp1TQ9NsiFLBQet66BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 9:55 AM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> On Thursday 02 April 2015 16:44:10 Pavel Machek wrote:
>> On Wed 2015-04-01 23:11:40, Samuel Thibault wrote:
>> > Pali Roh?r, le Wed 01 Apr 2015 22:00:07 +0200, a ?crit :
>> > > On Tuesday 17 February 2015 20:15:27 Samuel Thibault wrote:
>> > > > Here is an updated version to fix the initialization of the
>> > > > vt_led_work queues before registering LEDs, and refresh
>> > > > against 3.19.
>> > >
>> > > Hello! I would like to ask when will be this patch series merged
>> > > into mainline kernel? Are there still some problems with it?
>> >
>> > There are no known problems ATM.
>>
>> I thought it made it to -next, but apparently not.
>>
>> Dmitry, can you comment what needs to be done, or just merge it,
>> please?
>>
>>                                                                       Pavel
>
> Dmitry, can you merge this patch?

Sorry, I keep intending to go back to it and keep getting distracted
with other items. Last time I tried it it did not appear to work for
some scenarios that I tried, but I did not document it to provide
reasonable feedback to Samuel.

One thing that I know we'd have to fix is that input device must be
"opened" before we can engage it, right now LED interface violates
this requirement. It works right now because keyboard handler attaches
to most input devices with LEDs early enough for it to be
unnoticeable, but it does not mean that it is correct. It might be as
easy as calling input_open() unconditionally if devices has LEDs.

Another issue is that I do not think we should be introducing virtual
VT leds. I believe LEDs should belong to real devices; multiplexing
several into one usually ends up with problems (like the whole
mousedev and various users having to "grab" touchpads to exclude their
data form mousedev to avoid duplicate movement/button presses).

Hopefully I will have more coherent response RSN.

Thanks and sorry.

-- 
Dmitry
