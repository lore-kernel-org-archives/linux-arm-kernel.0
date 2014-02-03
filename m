From: monstr@monstr.eu (Michal Simek)
Date: Mon, 03 Feb 2014 13:13:30 +0100
Subject: [PATCH] ARM: zynq: Reserve not DMAable space in front of the
 kernel
In-Reply-To: <CAL_Jsq+4Ea7=WP+mj_k1Q3q7DKm-hk6WXpv2DOBQwefp-zxzjg@mail.gmail.com>
References: <780bb8c8fd752eeace2fd2fbe1d8ed8572dc0d76.1391170073.git.michal.simek@xilinx.com>
 <CAL_Jsq+4Ea7=WP+mj_k1Q3q7DKm-hk6WXpv2DOBQwefp-zxzjg@mail.gmail.com>
Message-ID: <52EF87EA.4010501@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:38 PM, Rob Herring wrote:
> On Fri, Jan 31, 2014 at 6:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Reserve space from 0x0 - __pa(swapper_pg_dir),
>> if kernel is loaded from 0, which is not DMAable.
>> It is causing problem with MMC driver and others
>> which want to add dma buffers to this space.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Jason: I don't think it is worth to bring 0x8000 magic
>> value and count minimum from it and phys_addr of swapper_pg_dir.
>> Full 512k of memory shouldn't be used by DMA.
>>
>> ---
>>  arch/arm/mach-zynq/common.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
> 
> The existing DT reserved range can't be used for this purpose?

I expect you are talking about memreserve.

Two cases which are valid for us which have the same DTS file
with this setup.

memreserve 0 - 0x4000
memory node 0x0 - 0x40000000


1. standard
kernel starting addr is 0x8000 and kernel is using 1GB memory which just works

2. AMP which we are also using
kernel starting for example from 0x10008000 and use just 768MB, 256MB for remoteproc.
With memreserve in DTS this ends in mark_bootmem BUG because reserved memory is not in memory
which Linux can handle (at least this is my theory).

Case 2 require one small fix which Russell is aware of,
I have to check status on it.

But with this current implementation both cases just work
without changing dts file because for both cases
dts file is just the same and user decides where kernel is placed
and how much memory user wants to use.

If you know how to fix this with any better dt description please
let me know. I am not aware about it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140203/17e879ac/attachment-0001.sig>
