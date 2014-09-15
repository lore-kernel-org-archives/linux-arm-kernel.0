From: shijie8@gmail.com (Huang Shijie)
Date: Mon, 15 Sep 2014 22:43:02 +0800
Subject: [PATCH] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20140913173841.GA18093@brian-ubuntu>
References: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140911120928.GA1585@localhost.localdomain>
 <20140911143616.3ebb025a@bbrezillon>
 <20140911142511.GA2543@localhost.localdomain>
 <20140911163847.5e2f85c7@bbrezillon>
 <20140912004550.GB26904@shldeISGChi005.sh.intel.com>
 <20140912143050.014ad4c3@bbrezillon>
 <20140913153622.GA10132@localhost.localdomain>
 <20140913173841.GA18093@brian-ubuntu>
Message-ID: <20140915144259.GA1947@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 10:38:41AM -0700, Brian Norris wrote:
> On Sat, Sep 13, 2014 at 11:36:24PM +0800, Huang Shijie wrote:
> > On Fri, Sep 12, 2014 at 02:30:50PM +0200, Boris BREZILLON wrote:
> > > This test validates what's returned by ecc_strength file in sysfs
> > > (which in turn is specified by the NAND controller when initializing
> > > the NAND chip).
> > > 
> > > Doing this should not imply knowing the ECC algorithm in use in the
> > > NAND controller or the layout used to store data on NAND.
> > the difficulty is that the ECC parity area can be not byte aligned.
> 
> Is there a problem with just rounding up to the nearest byte alignment
> and ignoring the few bits that are wasted?

I feel a little confused with the two hooks.

does the ecc->write_page_raw need to write the ECC parity data?

The page's layout after an ecc->write_page  will look like this:
                                              (Block Mark)
                                                    |      |
                                                    |  D   |
                                                    |<---->|
                                                    V      V
     +---+----------+-+----------+-+----------+-+----------+-+
     | M |   data   |E|   data   |E|   data   |E|   data   |E|
     +---+----------+-+----------+-+----------+-+----------+-+

What will the page's layout look like after the ecc->write_page_raw?


thanks
Huang Shijie
