From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 8 Feb 2016 11:28:47 +0100
Subject: [PATCH V4 1/7] clk: bcm2835: the minimum clock divider is 2
In-Reply-To: <87oac03tuz.fsf@eliezer.anholt.net>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-2-git-send-email-kernel@martin.sperl.org>
 <87oac03tuz.fsf@eliezer.anholt.net>
Message-ID: <56B86DDF.7060904@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02.02.2016 00:15, Eric Anholt wrote:
> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Testing with different clock divider values has shown
>> that (at least for the PCM clock) the clock divider
>> has to be at least 2, otherwise the clock will not
>> output a signal.
>
> For a MASH clock (PWM, PCM, SLIMBUS, but not the others), the minimum
> integer component of the divider is:
>
> mash 0: 1
> mash 1: 2
> mash 2: 3
> mash 3: 5
>

I know that that is what the datasheet says - see also the errata:
http://elinux.org/BCM2835_datasheet_errata#p105_table.

Experimentation has show that a divider between 1 and 1 + 4095 / 4096
does not provide any output PCM clock - only 2 and above does work for
mash = 0, 1, 2 or 3.

Example: Requesting 12288000Hz (=192kHz at 64bit) with the 19.2Mhz
oscillator results in a divider of: 1 + 2304 / 4096 and this does not
give a clock output.

See the report by hiassoft here:
https://github.com/raspberrypi/linux/issues/1231#issuecomment-171003182
(note that it also applies to mash = 0, but there may be no comment on
this fact in this thread)

Note that there is patch 7 that implements the above "mash" limits
for a divider and downgrades to a lower mash level if the divider
does not qualify.

Martin
