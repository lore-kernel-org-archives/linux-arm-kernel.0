From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Apr 2014 16:59:11 -0400
Subject: [PATCH RESEND 3/3] irqchip: orion: reverse irq handling priority
In-Reply-To: <535EB4C1.9090603@gmail.com>
References: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398540855-27367-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.DEB.2.02.1404282137240.6261@ionos.tec.linutronix.de>
 <535EB4C1.9090603@gmail.com>
Message-ID: <20140428205911.GC28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 10:06:25PM +0200, Sebastian Hesselbarth wrote:
> On 04/28/2014 09:39 PM, Thomas Gleixner wrote:
> > On Sat, 26 Apr 2014, Sebastian Hesselbarth wrote:
> > 
> >> Non-DT irq handlers were working through irq causes from most-significant
> >> to least-significant bit, while DT irqchip driver does it the other way
> >> round. This revealed some more HW issues on Kirkwood peripheral IP, where
> >> spurious sdio irqs can happen although IP's irq enable registers are all
> >> zero. Although, not directly related with the described issue, reverse
> >> irq bit handling back to original order by replacing ffs() with fls().
> > 
> > So why are we reverting to the original order?
> > 
> > The explanation above is just confusing.
> 
> Actually, I first wanted to reply "The original order worked for
> years, so get back to it." But then I thought about finding a better
> answer and remembered some comment of Russell a while ago.
> 


> I disassembled the generated binary and the original order saves two
> instructions for each bit count using clz.
> 
> With this patch:
>   60:   e3a07001        mov     r7, #1
>   64:   e16f3f14        clz     r3, r4
>   68:   e263301f        rsb     r3, r3, #31
>   6c:   e1c44317        bic     r4, r4, r7, lsl r3
>   70:   e5951004        ldr     r1, [r5, #4]
> 
> Without this patch:
>   60:   e3a06001        mov     r6, #1
>   64:   e2643000        rsb     r3, r4, #0
>   68:   e0033004        and     r3, r3, r4
>   6c:   e16f3f13        clz     r3, r3
>   70:   e263301f        rsb     r3, r3, #31
>   74:   e1c44316        bic     r4, r4, r6, lsl r3
>   78:   e5971004        ldr     r1, [r7, #4]


> You want me to reword the commit message accordingly?

Please do.  I would even quote the above.

thx,

Jason.
