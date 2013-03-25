From: illia.ragozin@grapecom.com (Elijah Ragozin)
Date: Mon, 25 Mar 2013 19:49:11 +0200
Subject: [PATCH] [ARM] Feroceon: fix kexec by setting outer_cache.inv_all
In-Reply-To: <20130325172113.GC16690@obsidianresearch.com>
References: <514E0D70.3060202@grapecom.com>
 <20130325172113.GC16690@obsidianresearch.com>
Message-ID: <51508E17.6010701@grapecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

thanks for your answer.

That's not about the boot path. I have zImage decompression error after 
kexec.

So on this stage boot process is not started yet, enable_l2 is called 
later - after zImage decompressed and started.

Please look at arch/arm/kernel/machine_kexec.c
Just before the run the code which load and run the new kernel we do:
         setup_mm_for_reboot(0);
         flush_cache_all();
         outer_flush_all(); // <- this has no map in cache-feroceon-l2.c 
, do nothing
         outer_disable(); // <- and this has no map in 
cache-feroceon-l2.c , do nothing
         cpu_proc_fin();
         outer_inv_all(); // <- and my patch is supposed to add this 
function, w/o the patch do nothing
         flush_cache_all();
         cpu_reset(reboot_code_buffer_phys);

So there is no actually disable and invalidation cache after the old 
kernel finished and the new one is not started yet, we're not safe to 
relocate and decompress the kernel.

If in your case everything is working could you please send for me 
.config and your kernel version, probably I also miss smth.
But I think the patch is necessary, it just adds the call of function 
used for other ARMs, but missed for Feroceon.
--
BR, Illia.

On 25.03.2013 19:21, Jason Gunthorpe wrote:
> On Sat, Mar 23, 2013 at 10:15:44PM +0200, Elijah Ragozin wrote:
>> Hello,
>>
>> I have a simple fix for kexec on Marvell Feroceon SoC.
>> Originally created and tested on kernel version 2.6.39.2,
>> but appliable for the 3.9 kernel as well.
>> Could you pls review. The patch is below.
> Hmm, I am using kexec on Kirkwood (a Feroceon SOC) and haven't had any
> problems with L2 coherency.. What exactly goes wrong here?
>
> The only reason I could think of that this would make a difference is
> if something along the boot path was turning on/off the L2? However if
> you turn off the L2 then it needs to be invalidated before it is
> turned on again. enable_l2 already does this properly..
>
> Is the decompressor fiddling with the L2?
>
> Jason
>
-- 
Best Regards,
Illia Ragozin.
