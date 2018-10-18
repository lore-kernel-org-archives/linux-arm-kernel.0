From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Thu, 18 Oct 2018 21:48:36 +0200
Subject: [PATCH] staging: bcm2835-audio: interpolate audio delay
In-Reply-To: <20181018105715.GA6660@ubuntu>
References: <20181018105715.GA6660@ubuntu>
Message-ID: <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 10/18/18 12:57, Mike Brady wrote:
> +	ktime_t now = ktime_get();
> +
> +	/* Give userspace better delay reporting by interpolating between GPU
> +	 * notifications, assuming audio speed is close enough to the clock
> +	 * used for ktime
> +	 */
> +
> +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
> +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
> +		u64 interval =
> +			(ktime_to_ns(ktime_sub(now,
> +				alsa_stream->interpolate_start)));
> +		u64 frames_output_in_interval =
> +			div_u64((interval * runtime->rate), 1000000000);
> +		snd_pcm_sframes_t frames_output_in_interval_sized =
> +			-frames_output_in_interval;
> +		runtime->delay = frames_output_in_interval_sized;
> +	}

This doesn't look like a good solution for me. More like a workaround. What is
the root cause of the delay?

Best Regards,
Kirill
