From: therealbadguy@gmail.com (Chris)
Date: Mon, 31 Jan 2011 10:37:52 -0700
Subject: iMX31 MBX registers Porting problem
In-Reply-To: <20110131154523.GB32737@n2100.arm.linux.org.uk>
References: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
	<20110131003128.GD27436@n2100.arm.linux.org.uk>
	<AANLkTi=EsCCwgiK5BtkKfaYEuzVUtnie-LU77cNJ4P4q@mail.gmail.com>
	<20110131154523.GB32737@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin4fPo6pKWLCqb+BXNS-hDrWPLEK7QQErbuq15C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 8:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 30, 2011 at 10:08:02PM -0700, Chris wrote:
>> Ok, I did that and it inserts and removes an entry I am not sure about
>> what would be wrong.
>>
>> 0x7f000000-0x7f002000 ? ?8192 module_alloc_update_bounds+0x18/0x68
>> pages=1 vmalloc
>> ...
>> 0x848a0000-0x848a5000 ? 20480 reg_probe+0x94/0x12c [reg] ioremap
>>
>> 0x7f006000-0x7f008000 ? ?8192 module_alloc_update_bounds+0x18/0x68
>> pages=1 vmalloc
>> ...
>> 0x848a8000-0x848ad000 ? 20480 reg_probe+0x94/0x12c [reg] ioremap
>>
>> here are two insertions, also showing the module bounds update, not
>> sure what to make of this information.
>
> The 'module_alloc_update_bounds+0x18/0x68' entry is the space used for
> your module. ?As it is free'd lazily, each time you insert it you'll
> get different virtual addresses.
>
>> when I cat /proc/iomem I can see my entry:
>> ? ?c0000000-c0003fff : mx3_mbx_regs.0
>>
>> how can I know that the mapping is pointing me to my location?
>
> ioremap() always gives you a cookie for use with readl() et.al. or NULL.
> If it's successful, the mapping will have been created and pointing at
> the requested bus address.
>

Ok, understood, so no tool to currently view what memory is being pointed at
is available in the filesystem?

My final question to you if I could would be,
I see dynamic returns on the mapped address on 2.6.30 - 2.6.38-rc2
where on 2.6.19.2 I see the same address always gets mapped.
can I get a brief explanation on this?

I also notice that the address is within different ranges for a few kernels.
I assume it is not relevant, but I have to turn over every rock here.

> I can't see anything wrong with your code, so I suspect you're missing
> something with the hardware - maybe a clock which isn't running or an
> enable bit somewhere?
>

  I have gone the extra distance in turning off support in the working kernel
2.6.19.2, I have removed nearly everything. I am down to the gpio_port
initialization code.
and that is all I have left, I will continue to look for more running clocks.

 I cannot think of anyone who would be twiddling bits on this thing
that I have not removed.
anything is possible and I am still looking.

for now I have paused moving forward, and am trying to break it on 2.6.19.2
so far it turns out I don't need very much support to talk to this device.
any suggested ways to turn off more stuff hidden somewhere perhaps?

> I've no idea how MBX works on the MX platforms, so I can't really suggest
> anything further.
>

Me neither! and that is making this really hard to figure out. trying
to find any information is impossible I think.
being a propriety chip from PowerVR with no available information
aside from how it is connected to the iMX.

Any tips for learning how to operate this device or one like it
connected in this fashion would bring great happiness.

Thank you for your comments.
