From: peda@lysator.liu.se (Peter Rosin)
Date: Mon, 5 Oct 2015 17:09:32 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <20151005150032.GA12137@odux.rfo.atmel.com>
References: <560F0DB1.2020101@lysator.liu.se>
 <561238A9.1060406@lysator.liu.se> <20151005150032.GA12137@odux.rfo.atmel.com>
Message-ID: <561292AC.8060408@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-05 17:00, Ludovic Desroches wrote:
> Hi Peter
> 
> On Mon, Oct 05, 2015 at 10:45:29AM +0200, Peter Rosin wrote:
>> On 2015-10-03 01:05, Peter Rosin wrote:
> 
> [...]
> 
>> Ok, I found the culprit, and I double and triple checked it this time...
>>
>> If I move to the very latest on the linux-3.18-at91 branch, the bug is
>> there too. Which made it vastly more palatable to bisect the bug.
>>
>> The offender (in the 4.2 kernel) is 93563a6a71bb69dd324fc7354c60fb05f84aae6b
>> "i2c: at91: fix a race condition when using the DMA controller"
>> which is far more understandable. Ao, adding Cyrille Pitchen to the Cc list.
>>
> 
> Thanks for the bisecting effort. I am currently at ELCE where I have
> met someone with the same kind of issue. Is it easily reproducible? It
> doesn't seem to be the case for him.

Yes, easy as pie, happens on every eeprom write of 256 bytes so far...

> I'll have a look once back.

Ok good, to further help understanding, I'm seeing this on the i2c bus (I
hope you understand the notation, or just ask):

Working (4.2 + the revert from my previous message)
===================================================

S W50 0x00 "product = 1-776-" P   S W50 NACK P   S W50 NACK P
delay 15.2 ms
S W50 0x10 "3.0\n" P
delay 19.5 ms
S W50 0x10 "3.0\n" P   S W50 NACK P   S W50 NACK P   S W50 NACK P
delay 19.0 ms
S W50 0x14 "serial = 380" P
delay 18.8 ms
S W50 0x14 "serial = 380" P   S W50 NACK P   S W50 NACK P
delay 18.4 ms
S W50 0x20 "000002\n" P
delay 19.2 ms
S W50 0x20 "000002\n" P
delay 10.8 ms
S W50 0x27 "         " P   S W50 NACK P (repeated 5 times)
delay 16.7 ms
S W50 0x30 "                " P
delay 18.4 ms
S W50 0x30 "                " P   S W50 NACK P (repeated 3 times)
delay 17.9 ms
S W50 0x40 "                " P

etc

I.e. every write (but the first) seems to fail the first time and is
then retried, even if the i2c bus shows no failure indication (at
least that I can find).


Not working (vanilla 4.2)
=========================

S W50 0x00 "product = 1-776-" P   S W50 NACK P   S W50 NACK P
delay 17.3 ms
S W50 0x10 ACK...
delay 19.8 with both SDA and SCL low
...ACK 0x10 "3.0\n" P   S W50 NACK P   S W50 NACK P
delay 19.3 ms
S W50 0x14 "serial = 380" P   S W50 NACK P   S W50 NACK P
delay 18.5 ms
S W50 0x20 ACK...
delay 19.9 with both SDA and SCL low
...ACK 0x20 "000002\n" P   S W50 NACK P   S W50 NACK P
delay 18.9 ms
S W50 0x27 "         " P   S W50 NACK P   S W50 NACK P
delay 19.2 ms
S W50 0x30 "                " P   S W50 NACK P   S W50 NACK P
delay 17.6 ms
S W50 0x40 "                " P   S W50 NACK P   S W50 NACK P

etc

I.e. when there is a disturbance (the long ACks) the recovery
mechanism appears to attempt to heal it by resending only the
failing byte, but the eeprom appears to not see the failure and
takes both bytes instead of just the resend.



It seems dangerous to attempt to fix apparent trouble with an
i2c command by anything less than a full retry, like the working
version appears to do. No?

But what trouble does the i2c bus driver see? Admittedly I only
have a simple logic level bus viewer, and not a full-blown
oscilloscope, so there might be something analogue going on?
I don't think so though, those signals looked fine last time we
looked (but we obviously didn't have these issues then, and
didn't really look that closely). I'll see if I can recheck
with a real scope too.

Cheers,
Peter
