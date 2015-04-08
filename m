From: lhikichi@broadcom.com (Lori Hikichi)
Date: Tue, 7 Apr 2015 19:30:57 -0700
Subject: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
In-Reply-To: <20150406161939.GJ6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
 <20150331064209.GD2869@sirena.org.uk> <551D8EB6.1050004@broadcom.com>
 <20150406161939.GJ6023@sirena.org.uk>
Message-ID: <552492E1.3050207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-04-06 09:19 AM, Mark Brown wrote:
> On Thu, Apr 02, 2015 at 11:47:18AM -0700, Lori Hikichi wrote:
>> On 15-03-30 11:42 PM, Mark Brown wrote:
>
>>>> +config SND_SOC_CYGNUS
>>>> +	tristate "SoC platform audio for Broadcom Cygnus chips"
>>>> +	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
>>>> +	default ARCH_BCM_CYGNUS
>
>> Okay.
>
> You don't need to reply to every single comment, the general assumption
> will be that if there's no other followup all review comments will be
> addressed.  It's better to just reply to things where there's something
> more detailed to say, if you explicitly reply to everything then that
> makes it easier for actual replies to be missed since there's a lot of
> there's a lot of the mail that's just going to be skipped through.
>
>>>> +static void ringbuf_inc(void __iomem *audio_io, bool is_playback,
>>>> +			const struct ringbuf_regs *p_rbuf)
>
>>> So it looks like we're getting an interrupt per period and we have to
>>> manually advance to the next one?
>
>> Yes.
>
> OK, so that seems fragile - what happens if we're slightly late
> processing an interrupt or miss one entirely?  Most hardware has some
> way to read back the current position which tends to be more reliable,
> is that not an option here?
>
The hardware updates a read pointer (rdaddr) which we feed to ALSA via 
the ".pointer" hook. So yes, the hardware does have a register that 
tells us its progress.  This routine (ringbuf_inc) actually updates a 
write pointer (wraddr) which is a misnomer.  The write pointer doesn?t 
actually tell us where we are writing to ? ALSA keeps track of that. 
The wraddr only prevents the hardware from reading past it.  We just use 
it, along with a low water mark configuration register, to keep the 
periodic interrupts firing.  The hardware is tracking the distance 
between rdaddr and wraddr and comparing that to the low water mark.

Being late processing the interrupt is okay since there are more samples 
to read.  That is, it was only a low water mark interrupt and we have 
one period of valid data still (we configure low water to be one 
period).  Missing an interrupt is okay since the hardware will just stop 
reading from the ring buffer when rdaddr has hit wraddr.
