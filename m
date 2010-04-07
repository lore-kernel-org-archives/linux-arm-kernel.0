From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Apr 2010 13:03:50 +0200
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <20100402104241.GC27613@sirena.org.uk>
References: <4BB22576.1070108@epfl.ch> <20100331083415.GR2241@pengutronix.de>
	<4BB4C362.3000803@epfl.ch> <20100402095358.GZ2241@pengutronix.de>
	<20100402104241.GC27613@sirena.org.uk>
Message-ID: <20100407110350.GD3688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 11:42:42AM +0100, Mark Brown wrote:
> On Fri, Apr 02, 2010 at 11:53:58AM +0200, Sascha Hauer wrote:
> > On Thu, Apr 01, 2010 at 06:01:38PM +0200, Valentin Longchamp wrote:
> 
> > > The thing is that I get a less than a second sound loop (I use aplay to  
> > > test, so userspace app should be ok), as if the buffer that the fiq asm  
> > > interrupt (from ssi_fiq.S) copies to the SSI hardware never was updated.
> 
> > > If I have understood the fiq behaviour correctly, you have a asm fiq  
> > > interrupt that does copy a larger tx buffer into the SSI hardware.  
> > > Besides it, you have the imx_ssi_timer_callback that checks when the tx  
> > > buffer was completely copied. If it is the case, then a new buffer tx  
> > > buffer is "issued" with the snd_pcm_period_elapsed call (and then  
> > > snd_pcm_update_hw_ptr0). Is this behaviour correct ?
> 
> > Yes.
> 
> What sample rate are you trying to play and what buffer size?  In my
> testing the FIQ was really struggling with most applications at sample
> rates over ~16kHz since you need each audio period to be long enough to
> at least fill the interval between timer polls but applications wanted
> to select buffer sizes that were consumed faster than the timer tick.

I just stumbled upon a board which had something in /etc/asound.conf
which decreased the buffer sizes. The result was choppy sound and a cpu
utilisation of ~40%.

After deleting the file I could play sounds (and record simultaniously)
with rates up to 44100kHz without visible cpu utilisation.

Looking at it I realised that poll_time is 0, so the timer gets reloaded
with the actual jiffies value which of course is a bad idea. We should
probably use a hrtimer here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
