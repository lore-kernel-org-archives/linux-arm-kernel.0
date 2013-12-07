From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 7 Dec 2013 11:56:06 +0100 (CET)
Subject: [PATCH v2 4/9] clocksource/cadence_ttc: Use enable/disable_irq
In-Reply-To: <f6d25456-8e30-4792-b184-21eb02dfaa1c@AM1EHSMHS001.ehs.local>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-5-git-send-email-soren.brinkmann@xilinx.com>
 <52972F3A.9090103@linaro.org>
 <alpine.DEB.2.02.1311281507280.30673@ionos.tec.linutronix.de>
 <b2ed3cbc-c9df-4235-8137-93514c05bffa@DB8EHSMHS031.ehs.local>
 <alpine.DEB.2.02.1311281939000.30673@ionos.tec.linutronix.de>
 <f6d25456-8e30-4792-b184-21eb02dfaa1c@AM1EHSMHS001.ehs.local>
Message-ID: <alpine.DEB.2.02.1312071151340.30673@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Dec 2013, S?ren Brinkmann wrote:
> On Thu, Nov 28, 2013 at 08:07:10PM +0100, Thomas Gleixner wrote:
> > There is a solution to this. We can identify the broadcast device in
> > the core and serialize all callers including interrupts on a different
> > cpu against the update. So no need for the disable/enable_irq() dance.
> 
> IIUC, and please correct me if I'm wrong, with the patch I'd simply call
> 'clockevents_update_freq() without having to disable IRQs. But I'm not
> sure whether periodic mode is covered. I found, that I had to reprogram
> the timer interval in my clock notifier callback when the timer
> frequency changes. I think 'clockevents_update_freq()' only handles
> oneshot mode. For that reason I call 'ttc_set_interval()' in the clock
> notifier in case the timer is in periodic mode. For that call we'd still
> have possible races. I guess the best solution would be to move that
> functionality into 'clockevents_update_freq()'?

Indeed.
