From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jun 2016 20:20:00 +0200
Subject: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
In-Reply-To: <20160530112350.GI29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
 <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
 <CAOMqctS0AD6rHGt3wjxxyidee=_5xqby95t5TGuozAA12DdPjQ@mail.gmail.com>
 <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
 <20160530112350.GI29837@sirena.org.uk>
Message-ID: <20160601182000.GC4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, May 30, 2016 at 12:23:50PM +0100, Mark Brown wrote:
> On Fri, May 27, 2016 at 03:10:11PM +1000, Julian Calaby wrote:
> > On Fri, May 27, 2016 at 3:05 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> 
> > >> Also, should the changes for the drivers be in two separate patches also?
> 
> > > That's basically the same driver with different constants so I guess not.
> 
> > Fair enough, I withdraw my comment then.
> 
> If it's the same driver with different constants it should really
> actually be the same driver - I did ask this when the drivers were
> originally merged...

I think we already had this discussion a few times :)

The thing is that the SPI framework now deals pretty well with the SPI
controllers, and you basically only have the probe function and how to
start a transfer. Which is nice.

However, the sun4i and sun6i SPI controllers have very significant
register layout differences: the registers offset are different, some
registers in the sun4i have been split in several in the sun6i. So
while I concur that they look alike, merging the two in a single
driver would complicate a lot the code, while we would not be able to
share most of the code, so I am really not sure it's worth it.

Where the issue really lies is that they've been both written at the
same time, and share the same flaws, especially in their probe
method. But that's not really related to the controller itself, but
more because the code has been close to copy/pasted.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160601/1248687a/attachment.sig>
