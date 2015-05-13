From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 13 May 2015 22:27:16 +0200
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <5553AAEA.30503@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com>
 <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
 <20150513153544.GC2065@localhost.localdomain>
 <5553AAEA.30503@broadcom.com>
Message-ID: <20150513202716.GA15878@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 12:50:02PM -0700, Jonathan Richardson wrote:
> ptp_clock_adjtime() casts it to an unsigned and returns an error:
> 
>    if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
>        return -EINVAL;

The value of a timeval is the sum of its fields, but the field tv_usec
must always be non-negative.  The tv_sec field can be negative.  So,
your application simply needs to do this:

	if (tx.time.tv_usec < 0) {
		tx.time.tv_sec  -= 1;
		tx.time.tv_usec += 1000000000;
	}

> >> IRQ interval: I mentioned before that we may be able to calculate the
> >> isochronous interrupt rate automatically but this isn't possible because
> >> the DTE doesn't know the frequency of the clients. One solution is to
> >> use the 'PTP_PEROUT_REQUEST' ioctl to set a periodic timer frequency.
> >> Not really a timer but good enough for our purposes.
> > 
> > As I said in my other reply, I don't understand what the problem is.
> 
> See reply to previous email. We can use this ioctl or add a new one as
> Arnd suggested. It doesn't matter to me.

Still makes no sense.  Why should the interrupt rate depend on the
clock frequency?

If the ISR is delivering batches of time stamps, then the interrupt
rate aught to be the highest rate that the system can support.

> >> Set divider: There is no ability to set a frequency or do anything to a
> >> channel. We could re-use the PTP_EXTTS_REQUEST ioctl but extend 'struct
> >> ptp_extts_request' by using the reserved field rsv to allow setting an
> >> integer value representing either a frequency or divider value in our
> >> case - some value to configure a channel. A new flag would have to be
> >> added to the existing PTP_ENABLE_FEATURE, RISING and FALLING EDGE.
> > 
> > I don't get this, either.
> 
> See reply to previous email.

Didn't help me too much :(

> > The PTP interface supports poll/read just fine already.
> 
> Yes that's why I wanted to re-use it. As it currently is, it's not going
> to work for reasons I explained in previous follow up yesterday:
> 
> http://marc.info/?l=linux-kernel&m=143147907431947&w=2

You said:

   one user space process would have to read timestamps for all
   channels/clients and then leave it up to user space IPC to get them
   to other processes, which isn't great.

I disagree.  I think having tons of fifos isn't great.

Ideally, there will be kernel consumers for most of the channels, and
they will forward the time stamps in a way appropriate to their
subsystem.  For example, network devices will use so_timestamping. 
Any "leftover" channels can go through the generic PTP interface.


Thanks,
Richard
