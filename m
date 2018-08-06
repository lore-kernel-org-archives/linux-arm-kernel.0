From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Aug 2018 14:22:00 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
 <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
 <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
 <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
Message-ID: <CAKv+Gu9Sa0pPeKVYBcCF8w-4QYYtp0YhHArzL3F2bnfVqyBYYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2018 at 14:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 August 2018 at 14:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>
>>
>> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>>
>>> >> Are we talking about a quirk for the Armada 8040 or about PCIe on ARM
>>> >> in general?
>>> >
>>> > I don't know - there are not any other easily available PCIe ARM boards
>>> > except for Armada 8040.
>>>
>>> ... indeed, and sadly, the ones that are available all have this
>>> horrible Synopsys DesignWare PCIe IP that does not implement a true
>>> root complex at all, but is simply repurposed endpoint IP with some
>>> tweaks so it vaguely resembles a root complex.
>>>
>>> But this is exactly why I am asking: I use a AMD Seattle Overdrive as
>>> my main Linux development system, and it runs the gnome-shell stack
>>> flawlessly (using the nouveau driver), as well as a UEFI framebuffer
>>> using efifb. So my suspicion is that this is either a Synopsys IP
>>> issue or an interconnect issue, and has nothing to do with the
>>> impedance mismatch between AMBA and PCIe.
>>
>> If you run the program for testing memcpy on framebuffer that I posted in
>> this thread - does it detect some corruption for you?
>>
>
> I won't be able to check that for a while - I'm currently travelling.
>
>>
>> BTW. does the Radeon GPU driver work for you?
>>
>> My observation is that OpenGL with Nouveau works, but it's slow and the
>> whole system locks up when playing video in chromium.
>>

Are you setting the pstate to auto? That helps a lot in my experience.

I.e.,

echo auto > /sys/kernel/debug/dri/0/pstate
