From: mikebrady@eircom.net (Mike Brady)
Date: Mon, 22 Oct 2018 20:08:05 +0100
Subject: [PATCH] staging: bcm2835-audio: interpolate audio delay
In-Reply-To: <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
References: <20181018105715.GA6660@ubuntu>
 <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
Message-ID: <20181022190805.GA4551@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kirill.

The problem that this patch seeks to resolve is that when userland asks for the
delay -- the time to hear -- the driver responds with a figure that is only updated
when a GPU interrupt occurs, now approximately every 10 milliseconds.

As far as I am aware, there is no way to get a more up-to-date delay number on request,
hence the present patch to interpolate based on the time of the last update, the time of
the request and the nominal frame rate.

It does have the drawback of relying on the accuracy of the CPU clock and on the
nominal rate but on reasonable assumptions, it will not be in error over
the approximately 10 ms interval.

As you'll probably know, this is the built-in DAC in the full-sized Raspberry Pi devices and
is widely used. As a developer of Shairport Sync, I have noticed that the "slop" in
delay on the Pi's built-in DAC is very large by comparison with other DACs. FYI, there is
a discussion of the effects of a downstream equivalent of this suggested patch at:
https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016.

Best wishes
Mike

On Thu, Oct 18, 2018 at 09:48:36PM +0200, Kirill Marinushkin wrote:
> Hello Mike,
> 
> On 10/18/18 12:57, Mike Brady wrote:
> > +	ktime_t now = ktime_get();
> > +
> > +	/* Give userspace better delay reporting by interpolating between GPU
> > +	 * notifications, assuming audio speed is close enough to the clock
> > +	 * used for ktime
> > +	 */
> > +
> > +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
> > +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
> > +		u64 interval =
> > +			(ktime_to_ns(ktime_sub(now,
> > +				alsa_stream->interpolate_start)));
> > +		u64 frames_output_in_interval =
> > +			div_u64((interval * runtime->rate), 1000000000);
> > +		snd_pcm_sframes_t frames_output_in_interval_sized =
> > +			-frames_output_in_interval;
> > +		runtime->delay = frames_output_in_interval_sized;
> > +	}
> 
> This doesn't look like a good solution for me. More like a workaround. What is
> the root cause of the delay?
> 
> Best Regards,
> Kirill
