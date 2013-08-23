From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Aug 2013 11:11:14 +0100
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <87li3tvnj8.fsf@linaro.org>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
 <87li3tvnj8.fsf@linaro.org>
Message-ID: <20130823101114.GM6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 06:54:35AM -0700, Kevin Hilman wrote:
> This patch causes a conflict with Russell's DEBUG_LL cleanup, which is
> already in linux-next.
> 
> For v3.12, I suggest you drop this patch and rework your new DEBUG_LL
> support on top of Russell's cleanup.  Have a look at that and see if you
> can reuse the the generic 8250 stuff added by Russell.  While there, you
> might look at imx.S as well.

I'm not sure why you think imx.S may be able to use the generic 8250
stuff, it doesn't seem to have the same register layout or even the
same bit positions as 8250:

                .macro  senduart,rd,rx
                str     \rd, [\rx, #0x40]       @ TXDATA

                .macro  busyuart,rd,rx
1002:           ldr     \rd, [\rx, #0x98]       @ SR2
                tst     \rd, #1 << 3            @ TXDC
                beq     1002b                   @ wait until transmit done

I did convert everything which I considered convertable@the time.
