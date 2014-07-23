From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 23 Jul 2014 13:07:43 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware
 descriptor list support)
In-Reply-To: <3361994.F0HgAeJkR9@avalon>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com> <3361994.F0HgAeJkR9@avalon>
Message-ID: <28702317.aD0C1Ga3DS@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Expanding the CC list)

On Wednesday 23 July 2014 12:28:47 Laurent Pinchart wrote:
> On Tuesday 22 July 2014 19:17:23 Kuninori Morimoto wrote:
> > Hi Laurent
> > 
> > > The code has been tested by artificially lowering the maximum chunk size
> > > to 4096 bytes and running dmatest, which completed sucessfully.
> > > Morimoto- san, is there an easy way to test cyclic transfers with your
> > > audio driver ?
> > 
> > Thank you for your offer.
> > I tested this patchset with audio DMAC (= cyclic transfer)
> > but, it doesn't work for me.
> > 
> > First of all, this sound driver which is using cyclic transfer
> > was worked well in shdma-base driver.
> > I had sent audio DMA support plafrom side patches before.
> > But, of course I'm happy to update sound driver side.
> > 
> > I will re-send my audio DMAC support patches after this email.
> > 
> > My troubles are...
> 
> [snip]
> 
> > 2. cyclic transfer doesn't work
> > 
> >    I got attached error.
> 
> [snip]
> 
> I can reproduce that, but I have this error coming up before.
> 
> [   16.207027] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:103 [   16.215795] in_atomic(): 1, irqs_disabled():
> 128, pid: 1319, name: aplay [   16.222636] CPU: 0 PID: 1319 Comm: aplay Not
> tainted 3.16.0-rc5-02821-g12a72a3 #2501 [   16.230536] Backtrace:
> [   16.233056] [<c00121e4>] (dump_backtrace) from [<c0012598>]
> (show_stack+0x18/0x1c) [   16.240778]  r6:ffffffff r5:c04aa7c0 r4:00000000
> r3:00000000
> [   16.246593] [<c0012580>] (show_stack) from [<c032ea84>]
> (dump_stack+0x8c/0xc0) [   16.253967] [<c032e9f8>] (dump_stack) from
> [<c0049e98>] (__might_sleep+0xcc/0x108) [   16.261689]  r4:e8dd2000
> r3:00000093
> [   16.265357] [<c0049dcc>] (__might_sleep) from [<c0332134>]
> (mutex_lock+0x20/0x70) [   16.272990]  r5:00000000 r4:e900fe00
> [   16.276657] [<c0332114>] (mutex_lock) from [<c01fa4dc>]
> (regmap_lock_mutex+0x10/0x14) [   16.284644]  r4:e900fe00 r3:00000000
> [   16.288309] [<c01fa4cc>] (regmap_lock_mutex) from [<c01fb9dc>]
> (regmap_update_bits+0x2c/0x64) [   16.297009] [<c01fb9b0>]
> (regmap_update_bits) from [<c01fba90>] (regmap_fields_write+0x38/0x44) [  
> 16.305883]  r7:e8d9d990 r6:00000004 r5:00000040 r4:f0368200
> [   16.311701] [<c01fba58>] (regmap_fields_write) from [<bf0ec280>]
> (rsnd_write+0x30/0x4c [snd_soc_rcar]) [   16.321195]  r5:e93a4c00
> r4:e8d1f898
> [   16.324866] [<bf0ec250>] (rsnd_write [snd_soc_rcar]) from [<bf0ec884>]
> (rsnd_src_set_convert_rate.isra.6+0xf8/0x144 [snd_soc_rcar]) [   16.336940]
> [<bf0ec78c>] (rsnd_src_set_convert_rate.isra.6 [snd_soc_rcar]) from
> [<bf0ec8fc>] (rsnd_src_init_gen2+0x2c/0xc4 [snd_soc_rcar]) [   16.349624] 
> r6:00000004 r5:e8d9d810 r4:e8d1f898 r3:bf0ec8d0
> [   16.355438] [<bf0ec8d0>] (rsnd_src_init_gen2 [snd_soc_rcar]) from
> [<bf0ea640>] (rsnd_soc_dai_trigger+0x1cc/0x22c [snd_soc_rcar]) [  
> 16.367236]  r5:e8d9d810 r4:e8d9d824
> [   16.370916] [<bf0ea474>] (rsnd_soc_dai_trigger [snd_soc_rcar]) from
> [<bf0c51ec>] (soc_pcm_trigger+0xa8/0xf8 [snd_soc_core]) [   16.382271] 
> r10:00002000 r9:00002000 r8:e9290d00 r7:e8d9d700 r6:00000001 r5:e99fb500 [ 
>  16.390301]  r4:e8ef3810
> [   16.392910] [<bf0c5144>] (soc_pcm_trigger [snd_soc_core]) from
> [<bf094704>] (snd_pcm_do_start+0x34/0x38 [snd_pcm]) [   16.403467] 
> r8:bf09e050 r7:00000000 r6:00000003 r5:e99fb500 r4:bf09e050 r3:bf0c5144 [  
> 16.411421] [<bf0946d0>] (snd_pcm_do_start [snd_pcm]) from [<bf0941f8>]
> (snd_pcm_action_single+0x40/0x80 [snd_pcm]) [   16.422079] [<bf0941b8>]
> (snd_pcm_action_single [snd_pcm]) from [<bf09443c>]
> (snd_pcm_action+0xcc/0xd0 [snd_pcm]) [   16.432547]  r7:00000003
> r6:e99fb5c8 r5:bf09e4c0 r4:e99fb500
> [   16.438366] [<bf094370>] (snd_pcm_action [snd_pcm]) from [<bf097098>]
> (snd_pcm_start+0x1c/0x24 [snd_pcm]) [   16.448125]  r8:00000000 r7:e8dd2000
> r6:e93a4c00 r5:bf09e4c0 r4:e99fb500 r3:00002000 [   16.456083] [<bf09707c>]
> (snd_pcm_start [snd_pcm]) from [<bf09b094>] (snd_pcm_lib_write1+0x40c/0x4f0
> [snd_pcm]) [   16.466391] [<bf09ac88>] (snd_pcm_lib_write1 [snd_pcm]) from
> [<bf09b244>] (snd_pcm_lib_write+0x64/0x78 [snd_pcm]) [   16.476860] 
> r10:be91ea4c r9:e8dd2000 r8:e8d66488 r7:00000000 r6:0002c780 r5:00000800 [ 
>  16.484889]  r4:e99fb500
> [   16.487494] [<bf09b1e0>] (snd_pcm_lib_write [snd_pcm]) from [<bf096c38>]
> (snd_pcm_playback_ioctl1+0x134/0x4c8 [snd_pcm]) [   16.498583]  r6:00000000
> r5:be91ea4c r4:e99fb500
> [   16.503330] [<bf096b04>] (snd_pcm_playback_ioctl1 [snd_pcm]) from
> [<bf096ffc>] (snd_pcm_playback_ioctl+0x30/0x3c [snd_pcm]) [   16.514685] 
> r8:e8d66488 r7:be91ea4c r6:00000004 r5:e93d3880 r4:e93d3880 [   16.521575]
> [<bf096fcc>] (snd_pcm_playback_ioctl [snd_pcm]) from [<c00d7c10>]
> (do_vfs_ioctl+0x80/0x5c8) [   16.531163] [<c00d7b90>] (do_vfs_ioctl) from
> [<c00d8194>] (SyS_ioctl+0x3c/0x60) [   16.538618]  r10:00000000 r9:e8dd2000
> r8:00000004 r7:be91ea4c r6:400c4150 r5:e93d3880 [   16.546648]  r4:e93d3880
> [   16.549243] [<c00d8158>] (SyS_ioctl) from [<c000f8a0>]
> (ret_fast_syscall+0x0/0x30) [   16.556964]  r8:c000fa24 r7:00000036
> r6:00000000 r5:0002c498 r4:0002c448 r3:be91ea4c
> 
> The rsnd_soc_dai_trigger() function takes a spinlock, making the context
> atomic, which regmap doesn't like as it locks a mutex.
> 
> It might be possible to fix this by setting the fast_io field in both the
> regmap_config and regmap_bus structures in sound/soc/sh/rcar/gen.c. regmap
> will then use a spinlock instead of a mutex. However, even if I believe that
> change makes sense and should be done, another atomic context issue will
> come from the rcar-dmac driver which allocates memory in the
> prep_dma_cyclic function, called by rsnd_dma_start() from
> rsnd_soc_dai_trigger() with the spinlock help.
> 
> What context is the rsnd_soc_dai_trigger() function called in by the alsa
> core ? If it's guaranteed to be a sleepable context, would it make sense to
> replace the rsnd_priv spinlock with a mutex ?

Answering myself here, that's not an option, as the trigger function is called 
in atomic context (replacing the spinlock with a mutex produced a clear BUG) 
due to snd_pcm_lib_write1() taking a spinlock.

Now we have a core issue. On one side there's rsnd_soc_dai_trigger() being 
called in atomic context, and on the other side the function ends up calling 
dmaengine_prep_dma_cyclic() which needs to allocate memory. To make this more 
func the DMA engine API is undocumented and completely silent on whether the 
prep functions are allowed to sleep. The question is, who's wrong ?

Now, if you're tempted to say that I'm wrong by allocating memory with 
GFP_KERNEL in the DMA engine driver, please read on first :-) I've tried 
replacing GFP_KERNEL with GFP_ATOMIC allocations, and then ran into a problem 
more complex to solve.

The rcar-dmac DMA engine driver uses runtime PM. When not used, the device is 
suspended. The driver calls pm_runtime_get_sync() to resume the device, and 
needs to do so when a descriptor is submitted. This operation, currently 
performed in the tx_submit handler, could be moved to the prep_dma_cyclic or 
issue_pending handler, but the three operations are called in a row from 
rsnd_dma_start(), itself ultimately called from snd_pcm_lib_write1() with the 
spinlock held. This means I have no place in my DMA engine driver where I can 
resume the device.

One could argue that the rcar-dmac driver could use a work queue to handle 
power management. That's correct, but the additional complexity, which would 
be required in *all* DMA engine drivers, seem too high to me. If we need to go 
that way, this is really a task that the DMA engine core should handle.

Let's start by answering the background question and updating the DMA engine 
API documentation once and for good : in which context are drivers allowed to 
call the prep, tx_submit and issue_pending functions ?

-- 
Regards,

Laurent Pinchart
