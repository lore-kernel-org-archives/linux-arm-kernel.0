From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 May 2013 10:34:17 -0600
Subject: [PATCH] ARM: bcm2835: override the HW UART periphid
In-Reply-To: <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
References: <519AD82A.6090809@wwwdotorg.org>
 <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
Message-ID: <519BA209.6050407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 12:02 AM, Jongsung Kim wrote:
> Stephen Warren reported the recent commit 78506f2 (add support for
> extended FIFO-size of PL011-r1p5) breaks the serial port on the
> BCM2835 ARM SoC.
> 
> A UART compatible with the ARM PL011-r1p5 should have 32-deep FIFOs.
> The BCM2835 UART just looks like an ARM PL011-r1p5, but has 16-deep
> FIFOs just like PL011-r1p4 or earlier revisions. As a workaround for
> this compatibility issue, this patch overrides the HW UART periphid
> register values with the actually compatible UART periphid 0x00241011
> (r1p3 or r1p4).
> 
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>

I know this will work, because I tried out the same thing last week.

However, I'm not convinced that it's the correct approach. What other
changes exist between r1p4 and r1p5; can you check in the TRM? Faking
the periphid would prevent the driver from taking account of any other
changes. Should we instead add a DT property solely to override the FIFO
size, and then set that for bcm2835? I guess if there really aren't any
other SW-visible changes in r1p5, this approach is fine.
