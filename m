From: jonathar@broadcom.com (Jonathan Richardson)
Date: Tue, 12 May 2015 18:03:40 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <554D1649.2030106@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com> <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
Message-ID: <5552A2EC.2060804@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit more info is required here.

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

Using read() we can't specify a channel to get the timestamp for. It
would imply that one user space process would have to read timestamps
for all channels/clients and then leave it up to user space IPC to get
them to other processes, which isn't great. That means either we
introduce an ioctl such as the DTE_GET_TIMESTAMP we had before which
allows us to specify a channel, or we need to look at creating one dev
node per external timestamping channel.

The ioctl limitation is that it pounds the kernel polling for timestamps
and the multiple dev nodes per channel is a big change to PTP. I will
have to look further into this to really have a good idea of what the
implications would be. Advice/ideas?

Thanks.
