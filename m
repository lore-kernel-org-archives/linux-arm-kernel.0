From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 16:02:19 -0700
Subject: [PATCH 5/9] ARM: BCM2836: Add io map initialization for bcm2836.
In-Reply-To: <60195891.q3RtUhgfkn@wuerfel>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <6559239.zHhRM8VZWD@wuerfel> <87oamh9q12.fsf@eliezer.anholt.net>
 <60195891.q3RtUhgfkn@wuerfel>
Message-ID: <87bnihhypw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 21 April 2015 13:37:13 Eric Anholt wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> > On Tuesday 21 April 2015 11:09:52 Eric Anholt wrote:
>> >> +static struct map_desc bcm2836_io_map __initdata = {
>> >> +       .virtual = BCM2835_PERIPH_VIRT,
>> >> +       .pfn = __phys_to_pfn(BCM2836_PERIPH_PHYS),
>> >> +       .length = BCM2835_PERIPH_SIZE,
>> >> +       .type = MT_DEVICE
>> >> +};
>> >> +
>> >>  static void __init bcm2835_map_io(void)
>> >>  {
>> >> -       iotable_init(&io_map, 1);
>> >> +       iotable_init(&bcm2835_io_map, 1);
>> >> +}
>> >> +
>> >> +static void __init bcm2836_map_io(void)
>> >> +{
>> >> +       iotable_init(&bcm2836_io_map, 1);
>> >>  }
>> >> 
>> >
>> > Can you explain what this is needed for? Most platform ports don't
>> > do this any more.
>> 
>> Nope, I can't!  I'm not sure what the bcm2835 side of it does, and I was
>> just replicating that for 2836.
>> 
>> Should it be removed from 2835, too?
>> 
>
> Hard to know. Does anything reference BCM2835_PERIPH_VIRT? Does it work
> if you remove it?

Well, that's clear enough. It dies early with:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc1-v7+ (anholt at eliezer) (gcc version 4.9.2 ( 4.9.2-10) ) #487 SMP PREEMPT Tue Apr 21 15:58:29 PDT 2015
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Raspberry Pi 2 Model B+
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 64 MiB at 0x37000000
[    0.000000] Memory policy: Data cache writealloc

(hung)

The only thing I see using this 0xf0000000 range is DEBUG_BCM2836's
serial stuff, though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/ed1c6e77/attachment.sig>
