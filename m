From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 19:03:20 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <20140217093126.GE2633@katana>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
 <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
 <20140217093126.GE2633@katana>
Message-ID: <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 6:31 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Feb 17, 2014 at 10:23:31AM +0100, Geert Uytterhoeven wrote:
>> Hi Wolfram,
>>
>> On Mon, Feb 17, 2014 at 10:19 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >> I think the tricky part is when a driver for "renesas,i2c-r8a7790" is updated
>> >> with a new feature for r8a7790, which doesn't necessarily exist in r8a7791.
>> >> Then the compatible entry above will cause breakage.
>> >
>> > If the driver is updated in that way, then it MUST introduce an r8a7791
>> > compatible entry and make sure the new feature is only used on r8a7790.
>> > Otherwise it is a bug. If this is adhered, we won't have a breakage
>> > because the specific entry (here r8a7791) always comes first. Or?
>>
>> That will indeed prevent breakage. But in the distributed development world,
>> the person who modifies the driver may not be aware of the r8a7791.
>
> Then it will break even with a seperate r8a7791 compatible entry as
> well, sadly. Currently, the only thing encoded in the .data field of all
> compatibles, is which generation of the core is used. This is the same
> for r8a7790 and r8a7791 (this is why they ARE compatible ;)). So, even
> in the unlikely case of an r8a7790-only-feature, some code/reactoring to
> make the distinction is absolutely necessary.

It won't break because anyone who modifies r8a7790 support need to
make it specific to that SoC to not pull in r8a7791 into some
assumption. Just because the driver assumes something now doesn't mean
the hardware actually is compatible.

I think I understand your proposal with making an assumption of the
current state of the driver and making sure to add the new SoC
compatible value before adjusting the fallback. But this mainly seems
like a optimization to improve throughput commit-wise. I actually
proposed the same way for SDHI, but now when I think about it I
realize that there is no shortcut for adding the compatible string to
the driver. It has to be done sooner or later anyway.

Or what am I missing? =)

/ magnus
