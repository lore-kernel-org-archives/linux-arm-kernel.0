From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Sep 2012 09:56:26 +0800
Subject: [RFC/PATCH] ARM: PRIMA2: initial support for SiRFmarco dual-core
 SoC
In-Reply-To: <201209041946.47068.arnd@arndb.de>
References: <1346409312-16778-1-git-send-email-Barry.Song@csr.com>
 <201209031410.50729.arnd@arndb.de>
 <CAGsJ_4yKN2QvOGYE0NFX0GvLM+fRr36=hrPxpuXxUwHuNUkp4g@mail.gmail.com>
 <201209041946.47068.arnd@arndb.de>
Message-ID: <CAGsJ_4wUas7JhDuGgKM0FFQTKqNzj5-nv9JS5-vqgfLNUA5_=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/5 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 04 September 2012, Barry Song wrote:
>
>> >
>> >> +              rstc-iobg {
>> >> +                     compatible = "simple-bus";
>> >> +                     #address-cells = <1>;
>> >> +                     #size-cells = <1>;
>> >> +                     ranges = <0xc2000000 0xc2000000 0x10000>;
>> >> +
>> >> +                     reset-controller at c2000000 {
>> >> +                             compatible = "sirf,marco-rstc";
>> >> +                             reg = <0xc2000000 0x10000>;
>> >> +                     };
>> >> +             };
>> >> +
>> >> +             sys-iobg {
>> >> +                     compatible = "simple-bus";
>> >> +                     #address-cells = <1>;
>> >> +                     #size-cells = <1>;
>> >> +                     ranges = <0xc3000000 0xc3000000 0x30000>;
>> >
>> > It looks to me that the sub-buses all have a size of 0x1000000, so I would
>> > recommend listing that one in the ranges, rather than only enough to
>> > provide the devices that you actually use.
>>
>> these ranges come from the hw spec. it seems you mean something like:
>>                   ranges = <0xcc050000 0xcc050000 0x1000
>>                             0xcc060000 0xcc060000 0x1000
>>                             0xcc190000 0xcc190000 0x1000
>>                             ....>;
>> then the list will be very long. i can't really understand the
>> benefit.  of course, if a driver makes misoperations to map an address
>> not in this list, io mapping will fail for it.
>> here <0xc3000000 0xc3000000 0x30000> is the filter range that will go
>> through sys-iobg in marco SoC. if an address located in this range
>> doesn't locate in a real hardware which exists, the driver should fail
>> due to hw error.
>
> I actually meant
>
>         ranges = <0xc2000000 0xc2000000 0x1000000>;
>
> Since each iobg range seems to be 16MB apart from the previous one,
> I would assume that the actual ranges that get translated are also
> 16 MB, not 64 KB or 192 KB as in the examples above. The rule however
> is that you should model what the hardware does, and if that bus
> has a 192KB window, then you should list that in the DT source.

yes. every iobrg almost begins from a 16MB alignment:
CPURTC IO Bridge: 0xC1000000
RSTC IO Bridge: 0xC2000000
SYS IO Bridge: 0xC3000000
MEM IO Bridge: 0xC4000000
MEM IO Bridge: 0xC5000000
...

i'd like to make sure from SoC guys about the real hardware model.

>
>
>         Arnd

-barry
