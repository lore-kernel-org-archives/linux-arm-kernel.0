From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Apr 2016 15:42:19 +0200
Subject: [PATCH v5 1/2] serial: fsl_lpuart: Add DMA quirk
In-Reply-To: <3b2da30d16238b852b3792b1c62cea23@agner.ch>
References: <1459806792-7729-1-git-send-email-andrew@lunn.ch>
 <1459806792-7729-2-git-send-email-andrew@lunn.ch>
 <3b2da30d16238b852b3792b1c62cea23@agner.ch>
Message-ID: <20160405134219.GD30881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:01:12PM -0700, Stefan Agner wrote:
> On 2016-04-04 14:53, Andrew Lunn wrote:
> > Using DMA with the vf610 and other Vybrid devices results in a corrupt
> > serial stream. Add a quirk to disable the use of DMA.
> > 
> > Refactor the existing code to add a 32 bit access quirk for the
> > fsl,ls1021a-lpuart.
> 
> Hi Andrew,
> 
> [also added Greg and Jiri, maintainers of the tty subsystem]
> 
> Well, I am not sure if that is the right approach. Quirks are usually
> used to hint to issues in the hardware. However, in this case we deal
> with (a) software issue(s)...

I've been lazy and not investigated what is happening. I'm using the
serial port for console, so don't need performance. However, when it
does corrupt the stream, minicom tends to go crazy, and i have to
reset it to get a working console.

Have you investigated it sufficiently to be sure it is a software
issue?

> At Toradex we were carry a patch which disabled DMA by default using a
> module parameter:
> http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.4-next&id=f5baad61b77dd4b0ac0c7beeee284e12d49ba442

Module parameters are frowned upon. Also, once this issue is fixed,
they often leave cruft behind, e.g. in bootloaders configuration. The
advantage of the quirk is that it purely in the driver. When the
driver is fixed, the quirk code can be cleanly removed.

> This allowed to re-enable the DMA easily for testing... Not sure if that
> is the better approach.

If you are testing, you are modifying the driver anyway. It is very
easy to remove the quirk bit to re-enable DMA.

> IMHO we can just omit adding such a disable work around, people lived
> with the current situation since 3.13, one more release probably doesn't
> really matter... :-)

People lived with it by hacking the dts file with empty dma
nodes. Compared to that, a quirk is cleaner.

       Andrew
