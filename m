From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Apr 2012 14:44:31 +0800
Subject: imx sgtl5000:BUG: scheduling while atomic:
 speaker-test/1225/0x00000003
In-Reply-To: <20376.59099.336772.398425@ipc1.ka-ro>
References: <20120426023319.GC28063@b20223-02.ap.freescale.net>
 <20120426051212.GF28063@b20223-02.ap.freescale.net>
 <20376.59099.336772.398425@ipc1.ka-ro>
Message-ID: <20120426064430.GG28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 08:10:35AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> [added CC: Sascha Hauer as the SDMA driver author]
> 
> Richard Zhao writes:
> > On Thu, Apr 26, 2012 at 10:33:21AM +0800, Richard Zhao wrote:
> > > [   13.901890] eth0: no IPv6 routers present
> > > [   70.295079] BUG: scheduling while atomic: speaker-test/1225/0x00000003
> > > [   70.304293] Modules linked in:
> > > [   70.310389] [<c0015a68>] (unwind_backtrace+0x0/0xec) from [<c0585810>] (dump_stack+0x20/0x24)
> > > [   70.310421] [<c0585810>] (dump_stack+0x20/0x24) from [<c0585f6c>] (__schedule_bug+0x54/0x60)
> > > [   70.310452] [<c0585f6c>] (__schedule_bug+0x54/0x60) from [<c058db64>] (__schedule+0x84/0x748)
> > > [   70.310476] [<c058db64>] (__schedule+0x84/0x748) from [<c058e310>] (schedule+0x8c/0x90)
> > > [   70.310500] [<c058e310>] (schedule+0x8c/0x90) from [<c058c504>] (schedule_timeout+0x2fc/0x35c)
> > > [   70.310541] [<c058c504>] (schedule_timeout+0x2fc/0x35c) from [<c058d970>] (wait_for_common+0xd8/0x16c)
> > > [   70.310567] [<c058d970>] (wait_for_common+0xd8/0x16c) from [<c058da44>] (wait_for_completion_timeout+0x1c/0x20)
> > > [   70.310604] [<c058da44>] (wait_for_completion_timeout+0x1c/0x20) from [<c03352bc>] (sdma_run_channel+0x70/0x8c)
> > > [   70.310634] [<c03352bc>] (sdma_run_channel+0x70/0x8c) from [<c0335614>] (sdma_load_context+0x188/0x19c)
> > > [   70.310661] [<c0335614>] (sdma_load_context+0x188/0x19c) from [<c0335688>] (sdma_prep_dma_cyclic+0x60/0x1a8)
> > > [   70.310694] [<c0335688>] (sdma_prep_dma_cyclic+0x60/0x1a8) from [<c04760f4>] (snd_dmaengine_pcm_trigger+0xa0/0x134)
> > > [   70.310729] [<c04760f4>] (snd_dmaengine_pcm_trigger+0xa0/0x134) from [<c0483e68>] (soc_pcm_trigger+0x74/0xb0)
> > > [   70.310770] [<c0483e68>] (soc_pcm_trigger+0x74/0xb0) from [<c046e670>] (snd_pcm_do_start+0x34/0x40)
> > > [   70.310797] [<c046e670>] (snd_pcm_do_start+0x34/0x40) from [<c046e288>] (snd_pcm_action_single+0x48/0x74)
> > > [   70.310823] [<c046e288>] (snd_pcm_action_single+0x48/0x74) from [<c046e334>] (snd_pcm_action+0x80/0x8c)
> > > [   70.310850] [<c046e334>] (snd_pcm_action+0x80/0x8c) from [<c04707f0>] (snd_pcm_start+0x24/0x2c)
> > > [   70.310877] [<c04707f0>] (snd_pcm_start+0x24/0x2c) from [<c0474058>] (snd_pcm_lib_write1+0x2a8/0x340)
> > > [   70.310900] [<c0474058>] (snd_pcm_lib_write1+0x2a8/0x340) from [<c04741d0>] (snd_pcm_lib_write+0x70/0x7c)
> > > [   70.311007] [<c04741d0>] (snd_pcm_lib_write+0x70/0x7c) from [<c04703f8>] (snd_pcm_playback_ioctl1+0x114/0x428)
> > > [   70.311038] [<c04703f8>] (snd_pcm_playback_ioctl1+0x114/0x428) from [<c0470744>] (snd_pcm_playback_ioctl+0x38/0x44)
> > > [   70.311077] [<c0470744>] (snd_pcm_playback_ioctl+0x38/0x44) from [<c0107234>] (do_vfs_ioctl+0x4f4/0x568)
> > > [   70.311105] [<c0107234>] (do_vfs_ioctl+0x4f4/0x568) from [<c0107308>] (sys_ioctl+0x60/0x84)
> > > [   70.311138] [<c0107308>] (sys_ioctl+0x60/0x84) from [<c000df40>] (ret_fast_syscall+0x0/0x30)
> > > [   80.301928] ALSA sound/core/pcm_lib.c:1853 playback write error (DMA or IRQ trouble?)
> > > 
> > > 
> > > kernel: 3.4rc3 with ASoC/for-next and some my patches.
> > 
> > I found the cause.
> > snd_dmaengine_pcm_trigger --> dmaengine_pcm_prepare_and_submit
> > --> dmaengine_prep_dma_cyclic
> > 
> > The trigger function is in atomic context, but dmaengine_prep_dma_cyclic
> > tried to sleep.
> > 
> > From dma engine design, can device_prep_dma_cyclic sleep?
> > If yes, we may need to move it out of trigger functions.
> > 
> The root cause is that sdma_run_channel does a
> wait_for_completion_timeout() to wait for the special channel 0 to
> complete which is complete overkill from my point of view.
> channel 0 is used internally in the DMA engine and should always
> complete within a few microseconds. Thus a busy loop with a timeout
> would be fine here.
> 
> Furthermore a mutex is used to serialize access to channel data
> structures which also forbids the affected function to be used in
> interrupt context.
Only when dma engine declare dev_prep_xxx can not sleep, we need your patch.
> 
> The following patch would fix that:
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d3e38e2..fcab768 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -24,7 +24,7 @@
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> -#include <linux/wait.h>
> +#include <linux/delay.h>
>  #include <linux/sched.h>
>  #include <linux/semaphore.h>
>  #include <linux/spinlock.h>
> @@ -323,7 +323,7 @@ struct sdma_engine {
>  	dma_addr_t			context_phys;
>  	struct dma_device		dma_device;
>  	struct clk			*clk;
> -	struct mutex			channel_0_lock;
> +	spinlock_t			channel_0_lock;
>  	struct sdma_script_start_addrs	*script_addrs;
>  };
>  
> @@ -408,12 +408,21 @@ static int sdma_run_channel(struct sdma_channel *sdmac)
Since you're polling, change function name specific to channel 0?
>  	struct sdma_engine *sdma = sdmac->sdma;
>  	int channel = sdmac->channel;
>  	int ret;
> -
> -	init_completion(&sdmac->done);
> +	unsigned long timeout = 500;
I'm not sure. Did you test 500us is enough for loading firmware?
>  
>  	sdma_enable_channel(sdma, channel);
>  
You didn't disable the irq. mxc_sdma_handle_channel may be called.
> -	ret = wait_for_completion_timeout(&sdmac->done, HZ);
> +	while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
> +		if (timeout-- <= 0)
> +			break;
> +		udelay(1);
> +	}
> +	if (ret) {
> +		/* Clear the interrupt status */
> +		writel_relaxed(ret, sdma->regs + SDMA_H_INTR);
> +	} else {
> +		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
> +	}
>  
>  	return ret ? 0 : -ETIMEDOUT;
>  }
> @@ -425,17 +434,17 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
>  	void *buf_virt;
>  	dma_addr_t buf_phys;
>  	int ret;
> -
> -	mutex_lock(&sdma->channel_0_lock);
> +	unsigned long flags;
>  
>  	buf_virt = dma_alloc_coherent(NULL,
>  			size,
>  			&buf_phys, GFP_KERNEL);
>  	if (!buf_virt) {
> -		ret = -ENOMEM;
> -		goto err_out;
> +		return -ENOMEM;
>  	}
>  
> +	spin_lock_irqsave(&sdma->channel_0_lock, flags);
> +
>  	bd0->mode.command = C0_SETPM;
>  	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
>  	bd0->mode.count = size / 2;
> @@ -446,10 +455,9 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
>  
>  	ret = sdma_run_channel(&sdma->channel[0]);
>  
> -	dma_free_coherent(NULL, size, buf_virt, buf_phys);
> +	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
>  
> -err_out:
> -	mutex_unlock(&sdma->channel_0_lock);
> +	dma_free_coherent(NULL, size, buf_virt, buf_phys);
>  
>  	return ret;
>  }
> @@ -539,7 +547,7 @@ static void mxc_sdma_handle_channel(struct sdma_channel *sdmac)
>  	complete(&sdmac->done);
>  
>  	/* not interested in channel 0 interrupts */
> -	if (sdmac->channel == 0)
> +	if (WARN_ON(sdmac->channel == 0))
>  		return;
Move it before complete?

Thanks
Richard
>  
>  	if (sdmac->flags & IMX_DMA_SG_LOOP)
> @@ -659,6 +667,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	struct sdma_context_data *context = sdma->context;
>  	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
>  	int ret;
> +	unsigned long flags;
>  
>  	if (sdmac->direction == DMA_DEV_TO_MEM) {
>  		load_address = sdmac->pc_from_device;
> @@ -676,7 +685,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	dev_dbg(sdma->dev, "event_mask0 = 0x%08x\n", (u32)sdmac->event_mask[0]);
>  	dev_dbg(sdma->dev, "event_mask1 = 0x%08x\n", (u32)sdmac->event_mask[1]);
>  
> -	mutex_lock(&sdma->channel_0_lock);
> +	spin_lock_irqsave(&sdma->channel_0_lock, flags);
>  
>  	memset(context, 0, sizeof(*context));
>  	context->channel_state.pc = load_address;
> @@ -698,7 +707,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  
>  	ret = sdma_run_channel(&sdma->channel[0]);
>  
> -	mutex_unlock(&sdma->channel_0_lock);
> +	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
>  
>  	return ret;
>  }
> @@ -1297,7 +1306,7 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (!sdma)
>  		return -ENOMEM;
>  
> -	mutex_init(&sdma->channel_0_lock);
> +	spin_lock_init(&sdma->channel_0_lock);
>  
>  	sdma->dev = &pdev->dev;
>  
> 
> 
> 
> Lothar Wa?mann
> -- 
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
> 
