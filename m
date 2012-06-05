From: oleg.matcovschi@ti.com (Matcovschi, Oleg)
Date: Tue, 5 Jun 2012 18:28:24 +0000
Subject: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
In-Reply-To: <20120604061357.GV12766@atomide.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
 <20120604061357.GV12766@atomide.com>
Message-ID: <E0D6B3D7803B1A49AC7CEA9958379F6303752BF9@DFLE36.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>* Oleg Matcovschi <oleg.matcovschi@ti.com> [120515 14:40]:
>> Use omap_disable_channel_irq() function instead of directly accessing CICR.
>> The omap_disable_chanel_irq() function clears pending interrupts and 
>> disables interrupt on channel.
>> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear 
>> interrupt status register.

>Looking at this again, I'll apply this into cleanup-dma instead of fixes.

>If it fixes something that I can't see, please reply with a description what it fixes and I'll move it into fixes.
>Regards,
>Tony

Sure, cleanup-dma sounds ok.

Code covers:
- my test case for 4460:
      I could reproduce 2 interrupts @ omap-pcm driver after omap_stop_dma function call.
         1st irq CSR: 0x42 (half & drop)
         2nd irq CSR: 0x02 (drop)
      Only 1 interrupt occurs after applying this patch(overnight test results)
      Test case was created to reproduce problem reported by customer(without clear description):
          contiguous playback of 0.5 wav file (frequent start/stop audio transitions)
          contiguous data transfers on 15 self-linked dma channels.

- omap_request_dma could cause spurious interrupt
         (enable irq, clear irq status instead of clear irq status, enable irq)

thanks,
 Oleg
