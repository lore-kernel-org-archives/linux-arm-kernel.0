From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Feb 2014 17:13:07 +0100
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140217155419.682F7C401D4@trevor.secretlab.ca>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140217155419.682F7C401D4@trevor.secretlab.ca>
Message-ID: <1418981.0py7JxXCp8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 February 2014 15:54:19 Grant Likely wrote:
> On Wed, 12 Feb 2014 11:20:00 -0700, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> > On Wed, Feb 12, 2014 at 12:45:54PM -0500, Jason Cooper wrote:
> > 
> > > The bootloader would then load this file into ram, and pass the
> > > address/size to the kernel either via dt, or commandline.  kaslr (run in
> > > the decompressor) would consume some of this randomness, and then
> > > random.c would consume the rest in a non-crediting initialization.
> > 
> > Sure is a neat idea, but I think in general it would probably be smart
> > to include the entire FDT blob in the early random pool, that way you
> > get MACs and other machine unique data too.
> 
> I applied a patch that did exactly that (109b623629), and then reverted
> it (b920ecc82) shortly thereafter because add_device_randomness() is
> a rather slow function and FDTs can get large. I'd like to see someone
> do a reasonable analysis on the cost of using an FDT for randomness
> before I reapply a patch doing something similar. An awful lot of the
> FDT data is not very random, but there are certainly portions of it that
> are appropriate for the random pool.

Could we use a faster hash function that scans the entire device tree and
then just feed the output of that into add_device_randomness? We probably
can't expect that there is a lot of entropy in the DT blob, so the
result wouldn't be all that different in terms of quality of the random
seed.

	Arnd
