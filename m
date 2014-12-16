From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 16 Dec 2014 02:21:16 +0000
Subject: [RFC/PATCH 1/4 PATCH] ARM: mvebu: use dt_fixup to provide
 fallback for enable-method
In-Reply-To: <548F408E.3080302@alliedtelesis.co.nz>
References: <5488A2C0.5040804@alliedtelesis.co.nz>
 <548DFCEA.7000801@alliedtelesis.co.nz> <548E3209.20307@alliedtelesis.co.nz>
 <7947240.7yktm8fT2X@wuerfel> <548F408E.3080302@alliedtelesis.co.nz>
Message-ID: <548F971B.1040108@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2014 09:11 AM, Chris Packham wrote:
>
>
> On 12/15/2014 11:37 PM, Arnd Bergmann wrote:
>> On Monday 15 December 2014 00:57:49 Chris Packham wrote:
>>> On 12/15/2014 10:11 AM, Chris Packham wrote:
>>>>>> +
>>>>>> +CFLAGS_board-v7.o = -I$(src)/../../../scripts/dtc/libfdt
>>>>>> \ No newline at end of file
>>>>>
>>>>> Why is this needed? Can't you just include <linux/libfdt.h> ?
>>>>>
>>>>
>>>> I am already including linux/libfdt.h. Without the CFLAGS change I get
>>>> the following compile error.
>>>>
>>>>     In file included from include/linux/libfdt.h:6:0,
>>>>                      from arch/arm/mach-mvebu/board-v7.c:21:
>>>>     include/linux/../../scripts/dtc/libfdt/libfdt.h:54:24: fatal error:
>>>> libfdt_env.h: No such file or directory
>>>>
>>>> There seems to be precedence in other architectures/drivers
>>>>
>>>>     $ git grep -e '-I.*libfdt'
>>>>     arch/mips/cavium-octeon/Makefile:CFLAGS_octeon-platform.o =
>>>> -I$(src)/../../../scripts/dtc/libfdt
>>>>     arch/mips/cavium-octeon/Makefile:CFLAGS_setup.o =
>>>> -I$(src)/../../../scripts/dtc/libfdt
>>>>     arch/mips/mti-sead3/Makefile:CFLAGS_sead3-setup.o =
>>>> -I$(src)/../../../scripts/dtc/libfdt
>>>>     arch/powerpc/kernel/Makefile:CFLAGS_prom.o              =
>>>> -I$(src)/../../../scripts/dtc/libfdt
>>>>     drivers/firmware/efi/libstub/Makefile:CFLAGS_fdt.o    +=
>>>> -I$(srctree)/scripts/dtc/libfdt/
>>>>     drivers/of/Makefile:CFLAGS_fdt.o =
>>>> -I$(src)/../../scripts/dtc/libfdt
>>>>     drivers/of/Makefile:CFLAGS_fdt_address.o =
>>>> -I$(src)/../../scripts/dtc/libfdt
>>>>
>>
>> I still think we should not duplicate this but instead change the
>> header files to make the include hack unnecessary in all those places.
>>
>> Looking at the header file, it only contains
>>
>> #include <linux/libfdt_env.h>
>> #include "../../scripts/dtc/libfdt/fdt.h"
>> #include "../../scripts/dtc/libfdt/libfdt.h"
>>
>> so two of them get the headers from exactly that place, while the
>> libfdt_env.h file contains the linux-specific implementation of
>> a couple of functions instead of the baremetal implementation.
>>
>> It looks like the intention was that when you already include the
>> linux version of the header, you no longer need the other one, but
>> that assumption is broken by current implementation.
>>
>> One way to solve this would be
>>
>> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
>> index 73f49759a5e7..23c55baa8e18 100644
>> --- a/scripts/dtc/libfdt/libfdt.h
>> +++ b/scripts/dtc/libfdt/libfdt.h
>> @@ -51,7 +51,7 @@
>>    *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>    */
>>
>> -#include <libfdt_env.h>
>> +#include "libfdt_env.h"
>>   #include <fdt.h>
>>
>>   #define FDT_FIRST_SUPPORTED_VERSION    0x10
>>
>>
>> but I'm not sure if that is the best way.
>>
>
> I was hoping to limit the scope of my changes to mvebu code. But I can
> give it a whirl. I agree that propagating the hack isn't ideal.
>

Well I've sent something up to the devicetree/LKML so we'll see where
that goes.

Another alternative I that is not without precedence is to add a
of_fdt_xxx function (like of_fdt_limit_memory) to drivers/of/fdt.c
which already uses a custom CFLAGS.

>>>>> I think it would be good to first check whether you are running on
>>>>> Armada XP
>>>>> or Armada 370, because the latter does not require this.
>>>>>
>>>>>      Arnd
>>>>>
>>>>
>>>> Any suggestion as to what to check for. Based on the dts files in the
>>>> current source seem compatible == "marvell,armada370" seems like a good
>>>> choice. But I don't know for sure that there isn't a armada-xp variant
>>>> out using a .dts with this set.
>>>
>>> Adding the following at the top will do the trick (assuming
>>> "marvell,armada370" is the right compatible string to use).
>>>
>>>          unsigned long root = of_get_flat_dt_root();
>>>
>>>          if (of_flat_dt_is_compatible(root, "marvell,armada370"))
>>>                  return;
>>
>> Right. You could also add
>>
>>     if (!IS_ENABLED(CONFIG_SMP) || !of_flat_dt_is_compatible(root,
>> "marvell,armadaxp")))
>>
>> to again eliminate that check for uniprocessor kernels, and to not
>> propagate the fixup to future machines but make it clear that
>> it is only needed for armadaxp.
>
> OK makes sense.
>
>>
>>     Arnd
>>
