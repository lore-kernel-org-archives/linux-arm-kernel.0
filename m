From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 6 Oct 2015 11:29:34 +0100
Subject: [PATCH v2 21/22] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1
 to sysfs
In-Reply-To: <20151006102548.GC26433@leverpostej>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-22-git-send-email-suzuki.poulose@arm.com>
 <20151006090959.GO21513@n2100.arm.linux.org.uk>
 <CAPvkgC31-gUmetN0S=t9yJ30M8=x7Y7prxO40tiEB=zJiUvwBg@mail.gmail.com>
 <20151006102548.GC26433@leverpostej>
Message-ID: <CAPvkgC3gcS+Hpp28-dxTZLEcYbhethfYAtsQ5p1Fmb1WZw6Yrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2015 at 11:25, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Oct 06, 2015 at 11:18:42AM +0100, Steve Capper wrote:
>> On 6 October 2015 at 10:09, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Oct 05, 2015 at 06:02:10PM +0100, Suzuki K. Poulose wrote:
>> >> +static int __init cpuinfo_regs_init(void)
>> >> +{
>> >> +     int cpu, ret;
>> >> +
>> >> +     for_each_present_cpu(cpu) {
>> >> +             struct device *dev = get_cpu_device(cpu);
>> >> +
>> >> +             if (!dev)
>> >> +                     return -1;
>> >
>> > NAK.  Go figure out why, I'm too lazy to tell you.
>>
>> I will correct the return code to be -ENODEV.
>> Was that the reasoning behind the NAK?
>
> I suspect the half-initialised sysfs groups also have something to do
> with it...

Okay, cheers Mark, I see what you mean.

>
> Mark.
>
>>
>> >
>> >> +
>> >> +             ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
>> >> +             if (ret)
>> >> +                     return ret;
>> >> +     }
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +device_initcall(cpuinfo_regs_init);
>> >> --
>> >> 1.7.9.5
>>
