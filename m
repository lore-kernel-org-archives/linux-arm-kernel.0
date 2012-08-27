From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Aug 2012 21:43:10 +0800
Subject: Question about ION carveout heap support partial cache flush
In-Reply-To: <20120827082914.GN18957@n2100.arm.linux.org.uk>
References: <CAMj5BkgffAW6azUjwz+iCF1tBLmBDRBvBjR-_fTr=4G=h+BLZw@mail.gmail.com>
 <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
 <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
 <20120827082914.GN18957@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZw4Qk5qSyuyMko9SZWu3u3_7OPA2yNVYz6C1WQWVimbvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 4:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 27, 2012 at 04:23:31PM +0800, zhangfei gao wrote:
>> On Mon, Aug 27, 2012 at 1:46 PM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>> > Let me summerize it. First, user space address is mapped. Then,
>> > flushing user space
>> > address is triggered. It's a workaround of fixing non-existed virtual
>> > address without fixing
>> > vmap() or any other solution. It's just a quick fix.
>> >
>> > Zhangfei,
>> > I doubt that the issue may be caused by missing memory barrier.
>> > Flushing is using
>> > coprocessor instructions. It's a little different.
>>
>> Is there any limitation that dmac_map_area & dmac_flush_range
>> supporting addr mapped from user space?
>
> They DEFINITELY DO NOT SUPPORT FLUSHING USER SPACE.

I agree that those API are defined to support kernel space address only.
But the implementation is only flushing address by assembly code.

If we don't care the original goal of API, the problem should be caused
by address mapping isn't set up yet. I doubt that the first step isn't fully
finished. Since the second step is using coprocessor instruction, that's
a shortcut. If we add delay such as memory barrier, the first step can
be really finished before the second step running.
