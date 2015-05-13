From: jonathar@broadcom.com (Jonathan Richardson)
Date: Wed, 13 May 2015 16:25:49 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <20150513202716.GA15878@localhost.localdomain>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com> <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
 <20150513153544.GC2065@localhost.localdomain> <5553AAEA.30503@broadcom.com>
 <20150513202716.GA15878@localhost.localdomain>
Message-ID: <5553DD7D.8090905@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-13 01:27 PM, Richard Cochran wrote:
> On Wed, May 13, 2015 at 12:50:02PM -0700, Jonathan Richardson wrote:
>> ptp_clock_adjtime() casts it to an unsigned and returns an error:
>>
>>    if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
>>        return -EINVAL;
> 
> The value of a timeval is the sum of its fields, but the field tv_usec
> must always be non-negative.  The tv_sec field can be negative.  So,
> your application simply needs to do this:
> 
> 	if (tx.time.tv_usec < 0) {
> 		tx.time.tv_sec  -= 1;
> 		tx.time.tv_usec += 1000000000;
> 	}

That works, thanks.

> 
>>>> IRQ interval: I mentioned before that we may be able to calculate the
>>>> isochronous interrupt rate automatically but this isn't possible because
>>>> the DTE doesn't know the frequency of the clients. One solution is to
>>>> use the 'PTP_PEROUT_REQUEST' ioctl to set a periodic timer frequency.
>>>> Not really a timer but good enough for our purposes.
>>>
>>> As I said in my other reply, I don't understand what the problem is.
>>
>> See reply to previous email. We can use this ioctl or add a new one as
>> Arnd suggested. It doesn't matter to me.
> 
> Still makes no sense.  Why should the interrupt rate depend on the
> clock frequency?

The isochronous interrupt rate is just a way to poll the hardware FIFO
for timestamps and transfer them into a s/w FIFO where they're available
to be read from user space.

The rate depends on how frequently clients will be generating timestamps
at and the driver doesn't know that. That's why we set it from user
space. If the interrupt rate is too fast it could bog down the system,
and it can be very fast. The highest rate is almost always going to be
too fast. If it's set too slow then there will be FIFO overflows. Since
only user space knows the frequency of the input channel, it's up to the
user to set an appropriate rate. A good rate may be twice the frequency
of the highest frequency client. Since what clients are being used at
runtime is unknown to us and will vary from system to system we really
don't know what to set this rate to. One user may only be interested in
audio, another may only be interested in something connected to a GPIO.
One user may be running audio at a fast sample rate, another very slow,
etc.

The only way I can see it working is if we enabled a client (external
time stamping channel in PTP) with an expected frequency, then set the
IRQ interval to some pre-determined rate (ie- 2x) and then adjust the
rate as new clients are enabled and divider values are set.

> 
> If the ISR is delivering batches of time stamps, then the interrupt
> rate aught to be the highest rate that the system can support.

It to nanosecond precision so it can be ridiculously quick.

> 
>>>> Set divider: There is no ability to set a frequency or do anything to a
>>>> channel. We could re-use the PTP_EXTTS_REQUEST ioctl but extend 'struct
>>>> ptp_extts_request' by using the reserved field rsv to allow setting an
>>>> integer value representing either a frequency or divider value in our
>>>> case - some value to configure a channel. A new flag would have to be
>>>> added to the existing PTP_ENABLE_FEATURE, RISING and FALLING EDGE.
>>>
>>> I don't get this, either.
>>
>> See reply to previous email.
> 
> Didn't help me too much :(

Hope the description above helped. Timestamping can be controlled from
user space. Since we don't know which clients are being or the frequency
of the input, we don't know what to set the divider to. The user knows
what they have hooked up to a channel, the rate of it, and the rate they
want timestamps generated at (divided down to).

> 
>>> The PTP interface supports poll/read just fine already.
>>
>> Yes that's why I wanted to re-use it. As it currently is, it's not going
>> to work for reasons I explained in previous follow up yesterday:
>>
>> http://marc.info/?l=linux-kernel&m=143147907431947&w=2
> 
> You said:
> 
>    one user space process would have to read timestamps for all
>    channels/clients and then leave it up to user space IPC to get them
>    to other processes, which isn't great.
> 
> I disagree.  I think having tons of fifos isn't great.

Maybe an example will help. We have user space process A interested in
channel 1, and B in channel 2. A timestamp for channel 2 is in the FIFO
(the FIFO holds timestamps for all channels). What happens if client A
does a read for a timestamp and it's for channel 2? The timestamp has
been pulled out of the s/w FIFO in the driver. What do we do with it now?

Having separate FIFO's allows process A to only retrieve channel 1
timestamps.

Our original non PTP driver ioctl (DTE_GET_TIMESTAMP) solved that
problem because we could specify a channel. We're now trying to adapt it
to PTP so we don't have to write a new "DTE" user and kernel side API.

> 
> Ideally, there will be kernel consumers for most of the channels, and
> they will forward the time stamps in a way appropriate to their
> subsystem.  For example, network devices will use so_timestamping. 
> Any "leftover" channels can go through the generic PTP interface.

I'll look more into so_timestamping to see how that's used but we wanted
one generic interface to get timestamps from channels because anything
can be hooked up to a channel.

> 
> 
> Thanks,
> Richard
> 
