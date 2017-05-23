From: angus@akkea.ca (Angus Ainslie)
Date: Tue, 23 May 2017 16:46:33 -0600
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
 <20170522070117.mwk4gm34o7idedye@flea.home>
 <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
 <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
Message-ID: <6da4225205128b8f5bb920c7c3375752@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-23 13:52, Maxime Ripard wrote:
> On Mon, May 22, 2017 at 10:32:42AM -0600, Angus Ainslie wrote:
>> Hi Maxime
>> 
>> On 2017-05-22 01:01, Maxime Ripard wrote:
>> >
>> > This just made me realise, this is also the time where the clocks are
>> > disabled, and we changed our clock implementation in 4.11.
>> >
>> > And using the 4.4 DT will keep the old driver...
>> >
>> > Did you test in 4.11? If it's also broken, could you try to revert
>> > 1f4ce3b6ca79 and 6b48644b1d29 (I'm not sure it's going to be a trivial
>> > revert, but in that order it should work).
>> >
>> 
>> Thanks reverting those two allow the kernel to boot and mount the 
>> NAND.
> 
> Ok, good.
> 
> If you unrevert those patches, and add clk_ignore_unused to the kernel
> command line, is it still broken?
> 
> Maxime

Putting those back in with the changed command line doesn't work

[    5.840000] UBI error: cannot open mtd 4, error -19
[    5.840000] hctosys: unable to open rtc device (rtc0)
[    5.860000] clk: Not disabling unused clocks
[    5.860000] vcc3v0: disabling
[    5.870000] ALSA device list:
[    5.870000]   #0: sun4i-codec
[    5.880000] VFS: Cannot open root device "ubi0:rootfs" or 
unknown-block(0,0): error -19
[    5.890000] Please append a correct "root=" boot option; here are the 
available partitions:
[    5.910000] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(0,0)
[    5.910000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.12.0-rc2TNCPro #14
[    5.910000] Hardware name: Allwinner sun4i/sun5i Families
[    5.910000] [<c010e440>] (unwind_backtrace) from [<c010b01c>] 
(show_stack+0x10/0x14)
[    5.910000] [<c010b01c>] (show_stack) from [<c0372cac>] 
(dump_stack+0x84/0x98)
[    5.910000] [<c0372cac>] (dump_stack) from [<c01ad0b0>] 
(panic+0xdc/0x248)
[    5.910000] [<c01ad0b0>] (panic) from [<c0a01208>] 
(mount_block_root+0x198/0x270)
[    5.910000] [<c0a01208>] (mount_block_root) from [<c0a014a8>] 
(prepare_namespace+0x9c/0x198)
[    5.910000] [<c0a014a8>] (prepare_namespace) from [<c0a00e40>] 
(kernel_init_freeable+0x1d8/0x1e8)
[    5.910000] [<c0a00e40>] (kernel_init_freeable) from [<c0711e74>] 
(kernel_init+0x8/0x110)
[    5.910000] [<c0711e74>] (kernel_init) from [<c0107578>] 
(ret_from_fork+0x14/0x3c)
[    5.910000] ---[ end Kernel panic - not syncing: VFS: Unable to mount 
root fs on unknown-block(0,0)
[    6.430000] g_cdc gadget: high-speed config #1: CDC Composite (ECM + 
ACM)
