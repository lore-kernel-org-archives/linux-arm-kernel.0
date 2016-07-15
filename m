From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 15 Jul 2016 15:48:45 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate application
 method
In-Reply-To: <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com> <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
Message-ID: <98fd2ab2-9b1d-1494-5867-7701780fd471@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15.7.2016 15:27, Jean-Francois Moine wrote:
> On Fri, 15 Jul 2016 12:38:54 +0200
> Ond?ej Jirman <megous@megous.com> wrote:
> 
>>> If so, then yes, trying to switch to the 24MHz oscillator before
>>> applying the factors, and then switching back when the PLL is stable
>>> would be a nice solution.
>>>
>>> I just checked, and all the SoCs we've had so far have that
>>> possibility, so if it works, for now, I'd like to stick to that.
>>
>> It would need to be tested. U-boot does the change only once, while the
>> kernel would be doing it all the time and between various frequencies
>> and PLL settings. So the issues may show up with this solution too.
> 
> I don't think this is a good idea: the CPU clock may be changed at any
> time with the CPUFreq governor. I don't see the system moving from
> 1008MHz to 24MHz and then to 1200MHz when some computation is needed!

PLL lock time is around 10-20us, I'd guess based on the number of loops
in the PLL lock wait loop. So unless you'll be switching frequencies
many times per second, this should be barely noticeable.

But I'd like a different solution too.

> BTW, Ond?ej, in my BPi M2+, I tried to change the CPU clock with your
> code at kernel start time from 792MHz to 1008MHz, but the hardware
> (arisc?) set an other value, and the system speed was lower than before
> (the PLL-CPUx register is 0x90031521 on boot, I want to set it to
> xxxx1410 and I read 0x91031f33 - sorry, I did not have a look at the
> CPU SD pattern). Do you know why?

No idea. Arisc shouldn't do anything, unless you load some firmware into
it, and release its reset line.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/55a9a2db/attachment.sig>
