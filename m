From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 10:39:16 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F54053F.9070502@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
Message-ID: <20120306103916.GE17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:
> Russell King - ARM Linux wrote:
> > On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
> >> Russell King - ARM Linux wrote:
> >>> Is the SCR shared between capture and playback?  In that case, what
> >>> makes this read-modify-write thread safe?
> >>
> >> What's "SCR"?
> >
> > I assumed you knew the code you were commenting on.
> >
> >                  clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
> >
> > The register these functions seem to be used on appears to be called
> > 'SCR'.
> 
> Oh, I didn't know you were referencing a specific register on the part. 
> There are multiple uses of clrsetbits_be32 (and its variants) in the function.
> 
> To answer your question: I was lead to believe that the individual ALSA 
> callback functions are atomic.  So one thread should not be trying to 
> start playback while another thread is simultaneously trying to stop it.

Atomic with respect to what though?  The substream?  The PCM?  All PCMs?
Reading through the code, it turns out that the answer is the PCM, so
calls into the low level driver are serialized by a per-PCM mutex.

However, this is not true of the trigger callback - the trigger callback
does not take this mutex, but instead takes a spinlock (or two.)  Whether
this is enough to stop the capture and playback substream triggers being
called simultaneously seems to depend on whether the substreams are part
of the same group (which they probably aren't.)

So, in theory you could have the trigger method being called for the
capture device while the playback device is in the middle of being opened.
Luckily, for this case, the startup method only touches the hardware if
its the first substream being opened, and shutdown only touches the
hardware if its the last substream being closed.

However, I'm left wondering whether two trigger callbacks, one for the
playback substream and one for the capture substream could be called
simultaneously on two different CPUs.  I see nothing which prevents
this happening.
