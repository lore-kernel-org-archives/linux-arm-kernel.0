From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 10 Dec 2013 19:04:00 +0400
Subject: [PATCH 08/20] mmc: host: pxamci: switch over to dmaengine use
In-Reply-To: <52A6F17D.4090902@gmail.com>
References: <1375889649-14638-9-git-send-email-zonque>
 <1386667657-26355-1-git-send-email-ynvich@gmail.com>
 <1386671112.7152.219.camel@host5.omatika.ru> <52A6F17D.4090902@gmail.com>
Message-ID: <1386687840.7152.245.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 11:48 +0100, Daniel Mack wrote:
> I'd say something like bonnie++ is a more deterministic test for such
> things, considering that the first fsck might have fixed things that the
> 2nd didn't have to touch.

The old driver:
Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
pac26          300M    41  81   280   1   246   2   278  96  3056  10  99.2  23
Latency              1424ms    1054ms     510ms   95978us   86277us    3510ms
Version  1.96       ------Sequential Create------ --------Random Create--------
pac26               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   354  42 16254  97   325  10   490  30 +++++ +++  1320  37
Latency              2354ms   48094us    6165ms    2979ms     586us    1116us
1.96,1.96,pac26,1,1386675098,300M,,41,81,280,1,246,2,278,96,3056,10,99.2,23,16,,,,,354,42,16254,97,325,10,490,30,+++++,+++,1320,37,1424ms,1054ms,510ms,95978us,86277us,3510ms,2354ms,48094us,6165ms,2979ms,586us,1116us

The new driver:
Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
pac26          300M    38  77     0   0   218   2   267  93  1762   6  84.0  19
Latency              2522ms 138668225     792ms   67960us     141ms   16313ms
Version  1.96       ------Sequential Create------ --------Random Create--------
pac26               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   304  38 14930  95   383  13   525  31 +++++ +++  1042  28
Latency             13481ms   49916us    7144ms    4075ms     624us     993us
1.96,1.96,pac26,1,1639,300M,,38,77,0,0,218,2,267,93,1762,6,84.0,19,16,,,,,304,38,14930,95,383,13,525,31,+++++,+++,1042,28,2522ms,138668225,792ms,67960us,141ms,16313ms,13481ms,49916us,7144ms,4075ms,624us,993us

I forgot to run 'time bonnie++', so there is no hard numbers about total
time. My impression is that the old and new driver tests have run for 30
and 60 minutes respectively.

> Apart from that, your findings are interesting. I only tested pxamci
> with a Wifi card connected via SDIO, and didn't see such a big
> difference in performance.
> 
> > Conclusions:
> > 1. The card itself is fine.
> > 
> > 2. There are issues with new DMA driver. I am ready to test patches,
> > without questions.
> > 
> > 3. There are issues with the MMC stack in my ARM device. Please drop a
> > pointer where to start digging.
> 
> Alright, thanks a lot for offering help! You could start having a look
> at the DMA descriptors and see whether they differ in size, compared to
> the old implementation. Taking time stamps to measure the turnaround
> cycle of the transfers would be another thing that you can try.
> 
> I'm not aware of any code in the mmp_pdma driver that would burn lots of
> CPU cycles, but that doesn't mean there aren't any.

I can test patches, but I am not sure I can provide any meaningful help
with performance. Sorry.

In point 3 I was talking about non-DMA related performance. The device
has been busy running bonnie++, so I haven't had a change to verify. It
looks like my device is working with 1-bit-wide bus instead of
4-bit-wide (Bad block checking ran at 19500000 bits per second which
matches bus clock speed).
