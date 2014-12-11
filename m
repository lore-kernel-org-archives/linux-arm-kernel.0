From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 11 Dec 2014 13:55:50 +0000
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
In-Reply-To: <20141211122521.GF31456@e104818-lin.cambridge.arm.com>
References: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
 <20141210121325.GC13994@e104818-lin.cambridge.arm.com>
 <20141210122210.GE13994@e104818-lin.cambridge.arm.com>
 <20141210133106.GH13994@e104818-lin.cambridge.arm.com>
 <CACxGe6sR4N38N=p4O7smc4s9_RRUoj89o-jphJ85R2EuuqSF1g@mail.gmail.com>
 <20141210140115.GI13994@e104818-lin.cambridge.arm.com>
 <20141211122521.GF31456@e104818-lin.cambridge.arm.com>
Message-ID: <CACxGe6siV=R-E6J_VZVjuapCcorjwzNSJUvEdtUqdpLhM-nd5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 12:25 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Dec 10, 2014 at 02:01:15PM +0000, Catalin Marinas wrote:
>> On Wed, Dec 10, 2014 at 01:50:12PM +0000, Grant Likely wrote:
>> > On Wed, Dec 10, 2014 at 1:31 PM, Catalin Marinas
>> > <catalin.marinas@arm.com> wrote:
>> > > On Wed, Dec 10, 2014 at 12:22:10PM +0000, Catalin Marinas wrote:
>> > >> On Wed, Dec 10, 2014 at 12:13:26PM +0000, Catalin Marinas wrote:
>> > >> > On Wed, Dec 10, 2014 at 12:04:23PM +0000, Catalin Marinas wrote:
>> > >> > > Ard,
>> > >> > >
>> > >> > > I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
>> > >> > > on your commit above and reverting it gets things going again. I
>> > >> > > initially thought it has something to do with the hardware crypto since
>> > >> > > you added some crc32_be() calls but disabling arm64 hw crypto didn't
>> > >> > > make any difference.
>> > >> >
>> > >> > Commenting out crc32_be() in early_init_dt_verify() allows it to boot.
>> > >> > Some printk, it shows:
>> > >> >
>> > >> > initial_boot_params = 0xffffffc01fe00000
>> > >> > fdt_totalsize(initial_boot_params) = 2108105
>> > >> >
>> > >> > Isn't it quite big?
>> > >>
>> > >> We assume that the DT blob is maximum 2MB in the initial kernel mapping.
>> > >> I'm not sure why it is that big here but early_init_dt_verify() most
>> > >> likely doesn't have the areas around initial_boot_params mapped, only
>> > >> 2MB section. The crc probably triggers a very early data abort.
>> > >
>> > > For now, I blame my Juno firmware or dtb file. I'll let you know.
>> >
>> > Blech. I've not sent my pull request to Linus yet, so I'll revert this
>> > patch before I ask him to pull.
>>
>> As I said, I wouldn't blame this patch, it just causes the fault early
>> but the dtb totalsize that gets to the kernel is definitely wrong.
>>
>> The juno.dtb in firmware is 10185 bytes at the dtb totalsize agrees with
>> this. However, /sys/firmware/fdt (after I comment out the crc32 checks)
>> shows a totalsize of 2108105 and it's encoded accordingly in the second
>> word of the file.
>>
>> I think that UEFI is somehow corrupting the dtb totalsize field before
>> it gets to the kernel. Still looking into this.
>
> It looks like there is a bug in our UEFI when booting non-EFI kernels.
> With some firmware update, I can at least boot EFI Linux with this patch
> applied. So I don't think you should revert it.
>
> We'll add a patch to make sure all the dtb is mapped in head.S even if
> it is greater than 2MB, it helps with debugging (though we still require
> it to be in the first 512MB of RAM).

Okay, good. I'll send my pull request without the revert.

g.
