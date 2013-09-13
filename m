From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 13 Sep 2013 10:37:53 +0100
Subject: arm mach-virt kernel doesn't initialize clocks from device tree (was
 Re: [PATCH v7 0/3] hw/arm: Add 'virt' platform)
Message-ID: <CAFEAcA8MhL9ds3uxsbfKyHPYwY34HmYqpP1wYPhk_1ojMtJRLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Will suggested I add arm-linux-kernel to this discussion
since it's moved into what the right fix is for "mach-virt
doesn't initialize clocks from the device tree".]

On 12 September 2013 17:29, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Sep 12, 2013 at 11:17:50AM +0100, Peter Maydell wrote:
>> This [QEMU] patch series adds a 'virt' platform which uses the
>> kernel's mach-virt (fully device-tree driven) support
>> to create a simple minimalist platform intended for
>> use for KVM VM guests.

>> *** NOTE *** to get the PL011 to work you'll need to
>> tweak the kernel a bit:
>>
>> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
>> index b184e57..2b6aceb 100644
>> --- a/arch/arm/mach-virt/virt.c
>> +++ b/arch/arm/mach-virt/virt.c
>> @@ -21,11 +21,13 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/smp.h>
>> +#include <linux/clk-provider.h>
>>
>>  #include <asm/mach/arch.h>
>>
>>  static void __init virt_init(void)
>>  {
>> +       of_clk_init(NULL);
>>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>
>>
>> Otherwise the kernel doesn't ever add the clock to its
>> list, and then it refuses to probe for the PL011.
>> (I'm told this isn't really the right fix, though, and
>> ideally the call should be done in some generic location
>> rather than in every machine's init function.)

Specifically, what Will Deacon said was:
# Since the ultimate goal is to delete the mach-virt
# directory, I'd rather the of_clk_init call was put in
# core code (e.g. in time_init). The problem there is that
# many platforms call this function from different callbacks
# in the machine descriptor (->init_irq, ->init_time,
# ->init_machine), so we'd need to check for machines
# without an ->init_time callback and work out (a) whether
# it's safe to call of_clk_init twice and (b) whether the
# ordering is actually important for that platform.

>> The alternative would be for the kernel to be fixed to
>> follow its own device tree binding documentation and not
>> require clocks/clock-names properties on the pl011 node.
>
> Is anyone taking a look at a proper fix as far as you know?

Will said he didn't have time to write it but would be
happy to review code...

thanks
-- PMM
