From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Tue, 1 Jun 2010 18:53:54 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5844FB1@dbde02.ent.ti.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
	<AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
	<1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
	<AANLkTim4e5Sdj9tronOiI-sIMVGaUQdfRIhKHzZ4XfKp@mail.gmail.com>
	<AANLkTim3YdK3QDXC-20otTBPqYF_XX9rGHRX50cycqk6@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5844FB1@dbde02.ent.ti.com>
Message-ID: <AANLkTinEMbV1onbIZtNOvchP-CVsnVZsh_tKKkQUXmpJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 2:26 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Bjoern Brandenburg
>> Sent: Monday, May 31, 2010 6:46 AM
>> To: Catalin Marinas
>> Cc: bastoni at cs.unc.edu; Daniel Mack; linux-arm-kernel at lists.infradead.org; linus.ml.walleij at gmail.com
>> Subject: Re: 2.6.34 hangs during boot on PB11MPCore
>>
>> On Sun, May 30, 2010 at 9:04 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>> > On Sun, May 30, 2010 at 6:46 PM, Catalin Marinas
>> > <catalin.marinas@arm.com> wrote:
>> >> On Sun, 2010-05-30 at 22:38 +0100, Bjoern Brandenburg wrote:
>> >>> On Sun, May 30, 2010 at 5:05 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>> >>> > On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>> >>> >>
>> >>> >> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
>> >>> >> and 2.6.34-arm.
>> >>> >
>> >>> > Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
>> >>> > cherry-picking the following commits (which seemed relevant but
>> >>> > absent):
>> >>> >
>> >>> > 60060ca ARM: Handle instruction cache maintenance fault ?properly
>> >>> > 3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
>> >>> > 3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore
>> >>> >
>> >>> > Let's see which is the critical one...
>> >>>
>> >>> It's 3f64e83 "ARM errata: Eviction Buffer not empty after Cache Sync
>> >>> on L220" [1]. With this commit cherry-picked (on top of the 'rebased'
>> >>> branch in ARM's repository, i.e., 2.6.34-arm), the system boots to X11
>> >>> and runs some simple FS tests; the other ones don't make a difference.
>> >>>
>> >>> Are there plans for getting this and the other patches in the
>> >>> 'rebased' branch into mainline (for .35 or .36)?
>> >>
>> >> Thanks for the investigation. I recall I got something similar in the
>> >> past though I could no longer reproduce it with 2.6.34 (-arm) on the
>> >> PB11MPCore I have. Could you try reverting commit e7c5650f606 (ARM:
>> >> Change the mandatory barriers implementation) on a vanilla 2.6.34
>> >> kernel?
>> >
>> > That doesn't seem to help. v2.6.34 with e7c5650f606 reverted still hangs.
>>
>> Given that 2.6.34-arm contains patches for missing synchronization
>> primitives in the network driver, it is maybe not too surprising that
>> the vanilla kernel won't boot with an NFS root file system.
>>
>> I just tried 2.6.34-arm (i.e., the 'rebased' branch in the ARM repo)
>> with e7c5650f606 reverted (and without cherry-picking 3f64e83) ? and
>> that kernel boots ok!
>>
> We have similar observation on SPI based network driver. By playing with
> buffer alignment, the issue seems to be going away. Do you have link
> to " synchronization primitives in the network driver" ?patches ??

Hi  Santosh,

I was referring to the below patch. Without it, none of the tested
kernels could boot on our box.

- Bjoern

http://linux-arm.org/git?p=linux-2.6.git;a=commit;h=840cb637f8781516b9a4abc8f39508b30a63f1b0
commit 840cb637f8781516b9a4abc8f39508b30a63f1b0
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue Jun 1 10:05:05 2010 +0100

    smsc911x: Add spinlocks around registers access

    On SMP systems, the SMSC911x registers may be accessed by multiple CPUs
    and this seems to put the chip in an inconsistent state. The patch adds
    spinlocks to the smsc911x_reg_read, smsc911x_reg_write,
    smsc911x_rx_readfifo and smsc911x_tx_writefifo functions.

    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
