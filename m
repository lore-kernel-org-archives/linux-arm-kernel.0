From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 16 Oct 2012 12:13:22 -0500
Subject: [PATCH v3] ARM: vfp: fix save and restore when running on
 pre-VFPv3 and CONFIG_VFPv3 set
In-Reply-To: <20121015175317.GE15569@atomide.com>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com>
 <20121013090255.GT28061@n2100.arm.linux.org.uk>
 <yw1xr4p2myre.fsf@unicorn.mansr.com>
 <20121013133654.GU28061@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1210150157400.16624@utopia.booyaka.com>
 <CAG5Tg6XqpeRppWbr9-yBmsf+2TobhE5ateMX4crs10grn-tuAA@mail.gmail.com>
 <alpine.DEB.2.00.1210150523190.15973@utopia.booyaka.com>
 <20121015175317.GE15569@atomide.com>
Message-ID: <507D95B2.3020506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/15/2012 12:53 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [121014 22:26]:
>>
>> After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: fix
>> saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP board
>> started crashing during boot with omap2plus_defconfig:
>>
>> [    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
>> [    3.915954]  mmcblk0: p1
>> [    4.086639] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>> [    4.093719] Modules linked in:
>> [    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
>> [    4.103149] PC is at vfp_reload_hw+0x1c/0x44
>> [    4.107666] LR is at __und_usr_fault_32+0x0/0x8
>>
>> It turns out that the context save/restore fix unmasked a latent bug
>> in commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Make
>> VFPv3 usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel is
>> booted on a pre-VFPv3 core, the code attempts to save and restore the
>> d16-d31 VFP registers.  These are only present on non-D16 VFPv3+, so
>> this results in an undefined instruction exception.  The code didn't
>> crash before commit 846a136 because the save and restore code was
>> only touching d0-d15, present on all VFP.
>>
>> Fix by implementing a request from Russell King to add a new HWCAP
>> flag that affirmatively indicates the presence of the d16-d31
>> registers:
>>
>>    http://marc.info/?l=linux-arm-kernel&m=135013547905283&w=2
>>
>> and some feedback from M?ns to clarify the name of the HWCAP flag.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Cc: M?ns Rullg?rd <mans.rullgard@linaro.org>
> 
> This fixes the error above on my 2430sdp:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Fixes same error on 2420 H4.

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
