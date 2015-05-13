From: jonathar@broadcom.com (Jonathan Richardson)
Date: Wed, 13 May 2015 12:50:02 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <20150513153544.GC2065@localhost.localdomain>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com> <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
 <20150513153544.GC2065@localhost.localdomain>
Message-ID: <5553AAEA.30503@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-13 08:35 AM, Richard Cochran wrote:
> On Fri, May 08, 2015 at 01:02:17PM -0700, Jonathan Richardson wrote:
>> For the clock functions I think we can use the existing framework
>> unchanged with one exception: ptp_clock_adjtime() doesn't allow negative
>> time adjustments and we would like to allow this.
> 
> ???
> 
> /**
>  * struct ptp_clock_info - decribes a PTP hardware clock
>    ...
> 
>  * @adjtime:  Shifts the time of the hardware clock.
>  *            parameter delta: Desired change in nanoseconds.
>    ...
> 
> 	int (*adjtime)(struct ptp_clock_info *ptp, s64 delta);
> 
> That s64 is 's' as in "signed".

ptp_clock_adjtime() casts it to an unsigned and returns an error:

   if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
       return -EINVAL;
>  
>> IRQ interval: I mentioned before that we may be able to calculate the
>> isochronous interrupt rate automatically but this isn't possible because
>> the DTE doesn't know the frequency of the clients. One solution is to
>> use the 'PTP_PEROUT_REQUEST' ioctl to set a periodic timer frequency.
>> Not really a timer but good enough for our purposes.
> 
> As I said in my other reply, I don't understand what the problem is.

See reply to previous email. We can use this ioctl or add a new one as
Arnd suggested. It doesn't matter to me.

>  
>> Set divider: There is no ability to set a frequency or do anything to a
>> channel. We could re-use the PTP_EXTTS_REQUEST ioctl but extend 'struct
>> ptp_extts_request' by using the reserved field rsv to allow setting an
>> integer value representing either a frequency or divider value in our
>> case - some value to configure a channel. A new flag would have to be
>> added to the existing PTP_ENABLE_FEATURE, RISING and FALLING EDGE.
> 
> I don't get this, either.

See reply to previous email.

>  
>> Get timestamp: This is a bit more complicated. Currently the PTP driver
>> does list management for timestamps from external timestamp channels.
>> Timestamps from all channels go into the same list. In our driver we
>> have a s/w FIFO for each client and it closely matches the h/w FIFO and
>> handles any overflow. We would like to keep it this way because it also
>> allows multiple user space processes to only fetch timestamps for the
>> client it's handling. 
> 
> But having many readers is less efficient and more complex.
> 
> Also, we can adjust the buffer if needed to prevent HW FIFO overflows.
> 
>> We could add a new ioctl to get a timestamp from
>> the driver instead of doing it through ptp_read() but it would be nice
>> if we could let ptp_read() allow the driver to do timestamp management
>> instead of PTP. Maybe provide an option to obtain the timestamps from a
>> container in the driver instead of the one managed by PTP. I like being
>> able to use read/poll to obtain data instead of polling the kernel with
>> ioctls as we are currently doing.
> 
> The PTP interface supports poll/read just fine already.

Yes that's why I wanted to re-use it. As it currently is, it's not going
to work for reasons I explained in previous follow up yesterday:

http://marc.info/?l=linux-kernel&m=143147907431947&w=2

> 
>> Also, avoiding the kmalloc in ptp_read
>> would be nice because this of the frequency it would be called at. Do
>> you have any preference on how to handle this?
> 
> Originally I had the buffer on the stack, but DaveM didn't like it,
> saying performance is no excuse for not doing it "the right way".
> 
> Thanks,
> Richard
> 
