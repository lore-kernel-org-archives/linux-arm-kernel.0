From: panand@redhat.com (Pratyush Anand)
Date: Sat, 30 Apr 2016 08:57:34 +0530
Subject: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
In-Reply-To: <20160429180024.GS19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
 <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <20160429180024.GS19428@n2100.arm.linux.org.uk>
Message-ID: <CAHB_GuqhPJ7J-MNbjxqeQnogW-J6=Bt2e1STKSG5kzJT+4PJpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 11:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 08:26:00PM +0530, Pratyush Anand wrote:
>> Hi Russell,
>>
>> On Thu, Apr 28, 2016 at 2:58 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > Advertise the location of bootable RAM to kexec-tools.  kexec needs to
>> > know where it can place the kernel in RAM, and so be executable when
>> > the system needs to jump into it.
>> >
>> > Advertise these areas in /proc/iomem with a "System RAM (boot alias)"
>> > tag.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Can you please also share git tree path of corresponding kexec-tools changes?
>>
>> Could it be a better idea (if things in user space become simpler)
>> that in stead of patch 5 and 6, we pass arch_phys_to_idmap_offset to
>> user space, and then user space manipulates existing "Crash kernel"
>> and "System RAM" resources.
>
> Given that it's only _one_ platform right now, I don't think that
> additional complexity is worth it.  It means that we have to invent

Probably, I could not communicate it well.  I was not trying  to have
*additional* complexity. Wanted to see if things could be simpler
rather. So this is what my understanding was:
-- We create one patch to pass arch_phys_to_idmap_offset to user space
(say in /sys/kernel/bootmem_idmap_offset)
-- We do not use patch 5,6,11 and 12 of this series. Probably few more
content of the series will go away.
--  In kexec-tools code , we read /sys/kernel/bootmem_idmap_offset and
add that value in "start" and "end" of "Crash Kernel" and "System RAM"
resources.

> some API to do it, and I don't see why userspace should even care
> about having the delta exported - especially when the conversion
> may not be as trivial.
>

Yes, I agree, if translation is not trivial like that of keystone,
then what I am proposing will not work.

Reviewed-by: Pratyush Anand <panand@redhat.com>
