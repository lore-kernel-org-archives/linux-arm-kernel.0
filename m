From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jan 2016 01:31:40 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112011904.GC7690@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <20160111230059.GA12286@jirafa.cyrius.com>
 <20160111232231.GS6588@sirena.org.uk>
 <20160112000721.GB12286@jirafa.cyrius.com>
 <20160112004749.GT6588@sirena.org.uk>
 <20160112011904.GC7690@lunn.ch>
Message-ID: <20160112013140.GV6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 02:19:04AM +0100, Andrew Lunn wrote:

> When i played with this, i added a reschedule point at the end of the
> drivers transfer_one_message() function, to see if that would help. It
> did not, which is why i made a guess it has something to do with a
> lock.

The SPI core doesn't hold any locks while it pushes things into the
driver.  It has a spin lock to queue and deque messages but it drops
that before it hands off to the driver (many of which sleep so we'd
expect people to notice if we forgot to drop the lock).  It's possible
there's something going on there but I'd be very surprised if we messed
up the locking and only managed to notice over a period of years via an
interaction with another subsystem with no direct ties...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/bac3e762/attachment.sig>
