From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Apr 2010 11:42:42 +0100
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <20100402095358.GZ2241@pengutronix.de>
References: <4BB22576.1070108@epfl.ch> <20100331083415.GR2241@pengutronix.de>
	<4BB4C362.3000803@epfl.ch> <20100402095358.GZ2241@pengutronix.de>
Message-ID: <20100402104241.GC27613@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 11:53:58AM +0200, Sascha Hauer wrote:
> On Thu, Apr 01, 2010 at 06:01:38PM +0200, Valentin Longchamp wrote:

> > The thing is that I get a less than a second sound loop (I use aplay to  
> > test, so userspace app should be ok), as if the buffer that the fiq asm  
> > interrupt (from ssi_fiq.S) copies to the SSI hardware never was updated.

> > If I have understood the fiq behaviour correctly, you have a asm fiq  
> > interrupt that does copy a larger tx buffer into the SSI hardware.  
> > Besides it, you have the imx_ssi_timer_callback that checks when the tx  
> > buffer was completely copied. If it is the case, then a new buffer tx  
> > buffer is "issued" with the snd_pcm_period_elapsed call (and then  
> > snd_pcm_update_hw_ptr0). Is this behaviour correct ?

> Yes.

What sample rate are you trying to play and what buffer size?  In my
testing the FIQ was really struggling with most applications at sample
rates over ~16kHz since you need each audio period to be long enough to
at least fill the interval between timer polls but applications wanted
to select buffer sizes that were consumed faster than the timer tick.

Using an application like speaker-test which has minimal overhead and no
I/O to worry about helps too.

> > If then it looks like on my system, I have a problem with the  
> > snd_pcm_update_hw_ptr0 call.

> You could try reverting b4e82b5b785670b68136765059d1afc65c0ae023. Though
> I have tested it on my boards it may have some implications.

I was seeing similar behaviour before and after that patch too, the main
effect there was to improve the error handling when the FIQ and the
timer get out of sync with each other.
