From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 17 Sep 2014 10:38:52 +0200
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
In-Reply-To: <20140916213043.GB6672@atomide.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <20140912224324.GK18849@atomide.com> <5416D2A0.5020407@linutronix.de>
 <541833C0.5020106@linutronix.de> <20140916164858.GA1580@atomide.com>
 <20140916213043.GB6672@atomide.com>
Message-ID: <5419489C.9090607@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 11:30 PM, Tony Lindgren wrote:
> Found one more issue when booting on 2420 n8x0, maybe something to do
> with runtime PM?
To some degree, yes.

> [    4.770507] Internal error: Oops - undefined instruction: 0 [#1]
SMP ARM

  e3a02000        mov     r2, #0
  ee072fba        mcr     15, 0, r2, cr7, cr10, {5}
  e3a01001        mov     r1, #1
  f5d3f000        pld     [r3]
=>e1d30f9f        ldrexb  r0, [r3]

That ldrexb is part of the xchg() function in serial8250_rpm_get_tx().
So it looks like 2420 n8x0 does not understand ldrexb but the inline
assembly decided that it should.

This OMAP2420 should be ARM1136 / ARMv6. The ARM1136J(F)-S TRM says for
ldrexb: "This command is only available from the rev1 (r1p0) release of
the ARM1136JF-S processor."

So it looks like the CPU should know what to do when this opcode comes
around.

> 
> Regards,
> 
> Tony
> 

Sebastian
