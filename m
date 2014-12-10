From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Dec 2014 14:31:16 +0100
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
In-Reply-To: <20141210131345.GF13994@e104818-lin.cambridge.arm.com>
References: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
 <20141210121325.GC13994@e104818-lin.cambridge.arm.com>
 <20141210122210.GE13994@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8r570eqEZQb=BP-L6NBGjMebv5jnzEEBmhDb9MDJnipg@mail.gmail.com>
 <20141210131345.GF13994@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8MoGxiS0Wh9yPtesjrZro_74_bYQxr865ZYXH8FOiASw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2014 at 14:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Dec 10, 2014 at 12:31:57PM +0000, Ard Biesheuvel wrote:
>> On 10 December 2014 at 13:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Wed, Dec 10, 2014 at 12:13:26PM +0000, Catalin Marinas wrote:
>> >> On Wed, Dec 10, 2014 at 12:04:23PM +0000, Catalin Marinas wrote:
>> >> > Ard,
>> >> >
>> >> > I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
>> >> > on your commit above and reverting it gets things going again. I
>> >> > initially thought it has something to do with the hardware crypto since
>> >> > you added some crc32_be() calls but disabling arm64 hw crypto didn't
>> >> > make any difference.
>> >>
>> >> Commenting out crc32_be() in early_init_dt_verify() allows it to boot.
>> >> Some printk, it shows:
>> >>
>> >> initial_boot_params = 0xffffffc01fe00000
>> >> fdt_totalsize(initial_boot_params) = 2108105
>> >>
>> >> Isn't it quite big?
>> >
>> > We assume that the DT blob is maximum 2MB in the initial kernel mapping.
>> > I'm not sure why it is that big here but early_init_dt_verify() most
>> > likely doesn't have the areas around initial_boot_params mapped, only
>> > 2MB section. The crc probably triggers a very early data abort.
>> >
>>
>> Looking at the patch history, I just noticed that the crc() call got
>> moved to before fdt_check_header(), which means initial_boot_params
>> may point to something else than an FDT.
>> How exactly that may happen, and how the system ends up booting after
>> all is not clear to me, but the crc32() call should be moved down
>> regardless
>
> In linux-next, it looks ok to me, crc32 is called after
> fdt_check_header():
>
> bool __init early_init_dt_verify(void *params)
> {
>         if (!params)
>                 return false;
>
>         /* check device tree validity */
>         if (fdt_check_header(params))
>                 return false;
>
>         /* Setup flat device-tree pointer */
>         initial_boot_params = params;
>         of_fdt_crc32 = crc32_be(~0, initial_boot_params,
>                                 fdt_totalsize(initial_boot_params));
>         return true;
> }
>

OK, as it turns out, this patch

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=50ba08f301a1b0310775deeed00c9b24ba75fe8a

is new as well, and apparently Grant had to fix up my patch to make it
apply. So indeed, the above is correct.

So is the FDT actually >2 megs? That would perfectly explain why the
header check would succeed but the crc32() would fail, but it sounds
ludicrous.

-- 
Ard.
