From: john.stultz@linaro.org (John Stultz)
Date: Tue, 21 Aug 2018 12:38:09 -0700
Subject: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
In-Reply-To: <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
Message-ID: <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 3:22 AM, James Morse <james.morse@arm.com> wrote:
> On 08/21/2018 05:39 AM, John Stultz wrote:
>>
>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>
>> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>> reserve_memblock_reserved_regions+0xd4/0x13c
...
>>  From skimming the patch, it seems this is maybe expected? Or should
>> this warning raise eyebrows? I can't quite figure it out.
>
> Ugh, sorry for the noise! This is warning that there is something wrong
> with our assumptions about what types of memory exist.
>
>
>> It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.
>
>
> ... pmem ...
>
>>
>> /proc/iomem now has:
>> ...
>> 07410000-21efffff : System RAM
>>    11000000-1113cfff : reserved
>
>
>> 21f00000-21ffffff : reserved
>
>
> ^ This entry is what triggered the warning.
>
> It expects that meblock_reserved() memory is also described as memory.
> (memblock keeps them as separate lists, so its possible to reserve
> memory that doesn't exist... which it looks like your system is doing)

So yea, I suspect the hikey dts isn't quite right here then. I've
always thought how it setup the memory was a bit strange:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts#n30

So from your mail, I suspect the hole in the memory map for the pstore
buffer isn't correct, and we should rework that.

I'll give that a shot here and make sure pstore still works properly.

thanks
-john
