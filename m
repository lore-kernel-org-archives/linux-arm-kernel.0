From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 24 Sep 2009 20:00:02 +0100
Subject: S3C6410 SDHCI driver crash
In-Reply-To: <4ABB9115.4030609@gmail.com>
References: <4ABB9115.4030609@gmail.com>
Message-ID: <20090924190002.GG31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 05:32:37PM +0200, Maurus Cuelenaere wrote:
> Hi,
> 
> I'm currently experiencing an SDHCI bug in 2.6.31 and linux-next, which 
> didn't
> seem to appear in 2.6.31-rc8.
> 
> This is on a new S3C6410 platform (SmartQ 7, see [1]) and it seems to be
> consistently happening right after displaying "Loading hardware drivers" (in
> user-space; Ubuntu-based).
> 
> The relevant kernel log lines are:
> 
> blk: request botched
> kernel BUG at drivers/mmc/host/sdhci.c:298!

Having a look at the code in mainline, this is being triggered in 
sdhci_write_block_pio(), by the following code:

296     while (blksize) {
297             if (!sg_miter_next(&host->sg_miter))
298                     BUG();

Which suggests that the size of the transfer was bigger than the sg list
passed to the transfer, which is worrying as this seems to suggest there
is a problem with the PIO code writing insufficient data to the card.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
