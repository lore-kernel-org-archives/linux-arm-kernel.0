From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2015 15:06:25 +0100
Subject: NFS/TCP/IPv6 acting strangely in 4.2
In-Reply-To: <1442386435.3756.282.camel@vitec.com>
References: <20150911113839.GO21084@n2100.arm.linux.org.uk>
 <1442386435.3756.282.camel@vitec.com>
Message-ID: <20150917140625.GR21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 06:53:57AM +0000, Damien Th?bault wrote:
> On Fri, 2015-09-11 at 12:38 +0100, Russell King - ARM Linux wrote:
> > I have a recent Marvell Armada 388 board here which uses the mvneta
> > driver.  I'm seeing some weird effects with NFS with it acting as a
> > client.
> 
> Hello,
> 
> I'm upgrading a Marvelle Armada 370 board using the mvneta driver from
> 4.0 to 4.2 and noticed issues with NFS booting.
> Basically, most of the time init returns with an error code, or
> programs segfault or throw illegal instructions.
> 
> Since it worked fine on 4.0 I bisected until I found commit
> a84e32894191cfcbffa54180d78d7d4654d56c20 "net: mvneta: fix refilling
> for Rx DMA buffers".
> 
> If I revert this commit, everything seems to get back to normal.
> Could you try it ? The two issues look very similar.

If you look at my original problem report, you'll see that has nothing
to do with the problem I'm seeing.

My problem is:

- TCP disconnects
- NFS tries to establish a new connection with the server, sending a SYN
- NFS server replies with a SYNACK
- NFS client immediately sends another SYN with a different sequence
   number, so it's a _new_ attempt to connect to the NFS server.

At this point, the socket for the previous SYNACK'd connection has been
destroyed mid-setup.

This is because the sunrpc code is horribly racy - it doesn't block a
second attempt to call kernel_connect() on a socket which is already in
the process of connecting to the NFS server.

Even if the SYNACK had been corrupted (due to mvneta's rx code), that
has no bearing on the race in the sunrpc layer that destroys the previous
socket before the TCP SYN/SYNACK/ACK handshake has had a chance to
complete.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
