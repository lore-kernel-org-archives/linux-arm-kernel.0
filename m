From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 14:19:53 +0200
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <554D1649.2030106@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
Message-ID: <2067273.o6GGiUQkQC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 13:02:17 Jonathan Richardson wrote:
> On 15-05-01 12:40 PM, Arnd Bergmann wrote:
> > On Friday 01 May 2015 20:30:04 One Thousand Gnomes wrote:
> >>
> >>> channel control, unless I'm missing something. If people are flexible
> >>> with extending that I could propose something. Let me know which way you
> >>> prefer to go. Thanks.
> >>
> >> I would strongly favour fixing PTP to do this right. Otherwise we will
> >> have 2 or 3 adhoc drivers, then end up moving them to PTP and then end up
> >> dealing with the compat mess.
> > 
> > Agreed. I was hoping that there was already a subsystem in the kernel that
> > could be extended to work with this driver. If all that is needed is to
> > pass more fields of the existing timex to ptp drivers, that should be
> > fairly easy to do.
> > 
> > We also have some padding bytes available in struct timex in case some
> > extra data needs to be passed, or we could add another clock_* system call
> > if it's absolutely required to have another entry into the driver, and
> > connect that through struct k_clock and posix_clock_operations(). I would
> > hope we don't even need that.
> > 
> > 	Arnd
> > 
> 
> Thanks Arnd/Alan for the feedback. I looked into PTP further to see what
> exactly would need changing.
> 
> For the clock functions I think we can use the existing framework
> unchanged with one exception: ptp_clock_adjtime() doesn't allow negative
> time adjustments and we would like to allow this.

Ah, very good. Extending this one function should be fairly straightforward,
just discuss with the PTP maintainer how to best do it.

> The other client events (set IRQ interval, enable client, set client
> divider, get client timestamp) could be handled as follows:
> 
> IRQ interval: I mentioned before that we may be able to calculate the
> isochronous interrupt rate automatically but this isn't possible because
> the DTE doesn't know the frequency of the clients. One solution is to
> use the 'PTP_PEROUT_REQUEST' ioctl to set a periodic timer frequency.
> Not really a timer but good enough for our purposes.
>
> Enable Client: The external timestamping channel handling in PTP allows
> channels to be enabled so we can re-use this (PTP_EXTTS_REQUEST ioctl).

In each case, it might be better to add a new ioctl command instead, if
the existing command does not fit perfectly. This again would be up to
Richard.
 
> Set divider: There is no ability to set a frequency or do anything to a
> channel. We could re-use the PTP_EXTTS_REQUEST ioctl but extend 'struct
> ptp_extts_request' by using the reserved field rsv to allow setting an
> integer value representing either a frequency or divider value in our
> case - some value to configure a channel. A new flag would have to be
> added to the existing PTP_ENABLE_FEATURE, RISING and FALLING EDGE.

Seems reasonable, or again you could add a new command with 
a different structure if Richard prefers that.

> Get timestamp: This is a bit more complicated. Currently the PTP driver
> does list management for timestamps from external timestamp channels.
> Timestamps from all channels go into the same list. In our driver we
> have a s/w FIFO for each client and it closely matches the h/w FIFO and
> handles any overflow. We would like to keep it this way because it also
> allows multiple user space processes to only fetch timestamps for the
> client it's handling. We could add a new ioctl to get a timestamp from
> the driver instead of doing it through ptp_read() but it would be nice
> if we could let ptp_read() allow the driver to do timestamp management
> instead of PTP. Maybe provide an option to obtain the timestamps from a
> container in the driver instead of the one managed by PTP. I like being
> able to use read/poll to obtain data instead of polling the kernel with
> ioctls as we are currently doing. Also, avoiding the kmalloc in ptp_read
> would be nice because this of the frequency it would be called at. Do
> you have any preference on how to handle this?
> 
> I've tried to minimize the changes to PTP.

On Tuesday 12 May 2015 18:03:40 Jonathan Richardson wrote:
> Using read() we can't specify a channel to get the timestamp for. It
> would imply that one user space process would have to read timestamps
> for all channels/clients and then leave it up to user space IPC to get
> them to other processes, which isn't great. That means either we
> introduce an ioctl such as the DTE_GET_TIMESTAMP we had before which
> allows us to specify a channel, or we need to look at creating one dev
> node per external timestamping channel.
> 
> The ioctl limitation is that it pounds the kernel polling for timestamps
> and the multiple dev nodes per channel is a big change to PTP. I will
> have to look further into this to really have a good idea of what the
> implications would be. Advice/ideas?

Would it help if you register each channel as a separate ptp clock? That
way you could open them separately from user space in order to just
read from one of them.

	Arnd
