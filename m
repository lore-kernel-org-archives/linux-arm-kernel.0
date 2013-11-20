From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 20 Nov 2013 20:21:58 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: Arnaud Ebalard's message of "Wed\, 20 Nov 2013 19\:59\:13 +0100"
References: <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <87li0kkhzx.fsf@natisbad.org>
 <1384869194.8604.92.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119174323.GH913@1wt.eu>
 <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119184121.GN913@1wt.eu> <874n780wzc.fsf@natisbad.org>
 <20131120095037.07dc6fc0@skate>
Message-ID: <87iovmq3op.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I removed netdev from that reply

arno at natisbad.org (Arnaud Ebalard) writes:

> <#secure method=pgpmime mode=sign>
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
>
>> Arnaud,
>>
>> On Wed, 20 Nov 2013 00:53:43 +0100, Arnaud Ebalard wrote:
>>
>>>  - It seems I will I have to spend some time on the SATA issues I
>>>    previously thought were an artefact of not cleaning my tree during a
>>>    debug session [1], i.e. there is IMHO an issue.
>>
>> I don't remember in detail what your SATA problem was, but just to let
>> you know that we are currently debugging a problem that occurs on
>> Armada XP (more than one core is needed for the problem to occur), with
>> SATA (the symptom is that after some time of SATA usage, SATA traffic is
>> stalled, and no SATA interrupts are generated anymore). We're still
>> working on this one, and trying to figure out where the problem is.

The problem I had is in the first email of:

  http://thread.gmane.org/gmane.linux.ports.arm.kernel/271508

Then, yesterday, when testing with the USB 3.0 to ethernet dongle
connected to my RN102 (Armada 370) as primary interface, I got the
following. It is easily reproducible:

[  317.412873] ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
[  317.419947] ata1.00: failed command: READ FPDMA QUEUED
[  317.425118] ata1.00: cmd 60/00:00:00:07:2a/01:00:00:00:00/40 tag 0 ncq 131072 in
[  317.425118]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  317.439926] ata1.00: status: { DRDY }
[  317.443600] ata1.00: failed command: READ FPDMA QUEUED
[  317.448756] ata1.00: cmd 60/00:08:00:08:2a/01:00:00:00:00/40 tag 1 ncq 131072 in
[  317.448756]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  317.463565] ata1.00: status: { DRDY }
[  317.467244] ata1: hard resetting link
[  318.012913] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  318.020220] ata1.00: configured for UDMA/133
[  318.024559] ata1.00: device reported invalid CHS sector 0
[  318.030001] ata1.00: device reported invalid CHS sector 0
[  318.035425] ata1: EH complete

And then again:

[  381.342873] ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
[  381.349947] ata1.00: failed command: READ FPDMA QUEUED
[  381.355119] ata1.00: cmd 60/00:00:00:03:30/01:00:00:00:00/40 tag 0 ncq 131072 in
[  381.355119]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  381.369927] ata1.00: status: { DRDY }
[  381.373599] ata1.00: failed command: READ FPDMA QUEUED
[  381.378756] ata1.00: cmd 60/00:08:00:04:30/01:00:00:00:00/40 tag 1 ncq 131072 in
[  381.378756]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  381.393563] ata1.00: status: { DRDY }
[  381.397242] ata1: hard resetting link
[  381.942848] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  381.950167] ata1.00: configured for UDMA/133
[  381.954496] ata1.00: device reported invalid CHS sector 0
[  381.959958] ata1.00: device reported invalid CHS sector 0
[  381.965383] ata1: EH complete

But, as the problem seems to happen when the dongle is connected and in
use (and considering current threads on the topic on USB and netdev ML),
I think I will wait for things to calm down and test again with a 3.12
and then a 3.13-rcX.

Anyway, if you find something on your bug, I can give patches a try on
my RN2120.

Cheers,

a+
