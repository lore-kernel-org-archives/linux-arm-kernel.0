From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Dec 2014 15:00:25 +0100
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
In-Reply-To: <CACxGe6sR4N38N=p4O7smc4s9_RRUoj89o-jphJ85R2EuuqSF1g@mail.gmail.com>
References: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
 <20141210121325.GC13994@e104818-lin.cambridge.arm.com>
 <20141210122210.GE13994@e104818-lin.cambridge.arm.com>
 <20141210133106.GH13994@e104818-lin.cambridge.arm.com>
 <CACxGe6sR4N38N=p4O7smc4s9_RRUoj89o-jphJ85R2EuuqSF1g@mail.gmail.com>
Message-ID: <CAKv+Gu__9yaq=+bvMXADqjsoq0vkcJLuGfsaX0dpV-ZXXjXffg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2014 at 14:50, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, Dec 10, 2014 at 1:31 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On Wed, Dec 10, 2014 at 12:22:10PM +0000, Catalin Marinas wrote:
>>> On Wed, Dec 10, 2014 at 12:13:26PM +0000, Catalin Marinas wrote:
>>> > On Wed, Dec 10, 2014 at 12:04:23PM +0000, Catalin Marinas wrote:
>>> > > Ard,
>>> > >
>>> > > I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
>>> > > on your commit above and reverting it gets things going again. I
>>> > > initially thought it has something to do with the hardware crypto since
>>> > > you added some crc32_be() calls but disabling arm64 hw crypto didn't
>>> > > make any difference.
>>> >
>>> > Commenting out crc32_be() in early_init_dt_verify() allows it to boot.
>>> > Some printk, it shows:
>>> >
>>> > initial_boot_params = 0xffffffc01fe00000
>>> > fdt_totalsize(initial_boot_params) = 2108105
>>> >
>>> > Isn't it quite big?
>>>
>>> We assume that the DT blob is maximum 2MB in the initial kernel mapping.
>>> I'm not sure why it is that big here but early_init_dt_verify() most
>>> likely doesn't have the areas around initial_boot_params mapped, only
>>> 2MB section. The crc probably triggers a very early data abort.
>>
>> For now, I blame my Juno firmware or dtb file. I'll let you know.
>
> Blech. I've not sent my pull request to Linus yet, so I'll revert this
> patch before I ask him to pull.
>

Actually, it seems the patch is fine, it just uncovers an issue on
Juno where the initial fixed FDT mapping of 2 megs is smaller than
fdt_totalsize(). As most of those >2 megs of FDT contents are probably
padding anyway, it is not a surprise that crc'ing the thing is the
only way you will hit this issue.

-- 
Ard.
