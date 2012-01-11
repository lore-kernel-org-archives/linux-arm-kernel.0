From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Wed, 11 Jan 2012 18:27:18 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <20120111165508.GC1068@n2100.arm.linux.org.uk>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
Message-ID: <201201111827.18890.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012, Russell King - ARM Linux wrote:
> > @@ -49,9 +49,9 @@ static int at91_enter_idle(struct cpuidle_device *dev,
> >       else if (index == 1) {
> >               asm("b 1f; .align 5; 1:");
> >               asm("mcr p15, 0, r0, c7, c10, 4");      /* drain write buffer */
> > -             saved_lpr = sdram_selfrefresh_enable();
> > +             sdram_selfrefresh_enable(&rs);
> 
> What's the point of draining the write buffer if you then pass a buffer
> to this function to write data to?
> 
> If the requirement is that the write buffer is drained before issue a
> wait-for-interrupt instruction (in cpu_do_idle()) then this code
> violates that.

Does that mean the existing AT91SAM9G45 version of sdram_selfrefresh_enable
is broken already? It writes to the static saved_lpr1 variable after
the write buffers are drained, which is what this patch was trying to
clean up.

	Arnd
