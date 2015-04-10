From: lhikichi@broadcom.com (Lori Hikichi)
Date: Thu, 9 Apr 2015 19:06:22 -0700
Subject: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
In-Reply-To: <20150408192309.GI6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
 <20150331064209.GD2869@sirena.org.uk> <551D8EB6.1050004@broadcom.com>
 <20150406161939.GJ6023@sirena.org.uk> <552492E1.3050207@broadcom.com>
 <20150408192309.GI6023@sirena.org.uk>
Message-ID: <5527301E.6070906@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-04-08 12:23 PM, Mark Brown wrote:
> On Tue, Apr 07, 2015 at 07:30:57PM -0700, Lori Hikichi wrote:
>> On 15-04-06 09:19 AM, Mark Brown wrote:
> 
>>> OK, so that seems fragile - what happens if we're slightly late
>>> processing an interrupt or miss one entirely?  Most hardware has some
>>> way to read back the current position which tends to be more reliable,
>>> is that not an option here?
> 
>> The hardware updates a read pointer (rdaddr) which we feed to ALSA via the
>> ".pointer" hook. So yes, the hardware does have a register that tells us its
>> progress.  This routine (ringbuf_inc) actually updates a write pointer
>> (wraddr) which is a misnomer.  The write pointer doesn?t actually tell us
>> where we are writing to ? ALSA keeps track of that. The wraddr only prevents
>> the hardware from reading past it.  We just use it, along with a low water
>> mark configuration register, to keep the periodic interrupts firing.  The
>> hardware is tracking the distance between rdaddr and wraddr and comparing
>> that to the low water mark.
> 
> The code has handling for both read and write so it's not just updating
> a write pointer.  Is there no flexibility in the hardware regarding
> interrupt generation?
> 
>> Being late processing the interrupt is okay since there are more samples to
>> read.  That is, it was only a low water mark interrupt and we have one
>> period of valid data still (we configure low water to be one period).
>> Missing an interrupt is okay since the hardware will just stop reading from
>> buffer when rdaddr has hit wraddr.
> 
> Stopping if we miss an interrupt is precisely the sort of situation we
> want to avoid if we can - if the application is sufficiently far ahead
> of the hardware everything should continue to work fine.  The minimal
> period size appears to be very small so this is a potential issue, if an
> application tries to use many very small periods it's both more
> vulnerable to some other interrupt taking longer than might be desirable
> and likely that things would be fine as the application is hopefully
> more than one period ahead of where the hardware is at.
> 
> If the hardware is always going to halt at the end of the period there's
> not a huge amount we can do about this except possibly raise the minimum
> period if systems are running into trouble but if there's a way to avoid
> doing that then that would be even better.
> 
Makes sense, thanks for clarifying the desired behaviour, I will make the 
necessary adjustments to keep the hardware supplied with valid data even if 
interrupts are held off past a whole period.
