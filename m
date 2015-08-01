From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 31 Jul 2015 18:50:58 -0700
Subject: [PATCH v9 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <e0e476c1106c814c4eaadf1b7e5e2b47@agner.ch>
References: <1438361581-2702-1-git-send-email-stefan@agner.ch>
 <1438361581-2702-3-git-send-email-stefan@agner.ch>
 <20150731230901.GK10676@google.com>
 <9dd7975072cf16dd6ea1947bd4ae830a@agner.ch>
 <20150731234718.GO10676@google.com>
 <e0e476c1106c814c4eaadf1b7e5e2b47@agner.ch>
Message-ID: <20150801015058.GA11837@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 01, 2015 at 02:28:06AM +0200, Stefan Agner wrote:
> Did the measurement:
> 
> As is:
> ...
> [   30.955675] mtd_speedtest: testing eraseblock write speed
> [  143.349572] mtd_speedtest: eraseblock write speed is 4641 KiB/s
> [  143.355606] mtd_speedtest: testing eraseblock read speed
> [  183.816690] mtd_speedtest: eraseblock read speed is 12893 KiB/s
> [  185.874702] mtd_speedtest: testing page write speed
> [  302.608719] mtd_speedtest: page write speed is 4468 KiB/s
> [  302.614229] mtd_speedtest: testing page read speed
> [  343.831663] mtd_speedtest: page read speed is 12656 KiB/s
> ...
> 
> Unconditionally read OOB:
> ...
> [   29.076983] mtd_speedtest: testing eraseblock write speed
> [  140.829920] mtd_speedtest: eraseblock write speed is 4667 KiB/s
> [  140.835960] mtd_speedtest: testing eraseblock read speed
> [  181.594498] mtd_speedtest: eraseblock read speed is 12798 KiB/s
> [  183.652793] mtd_speedtest: testing page write speed
> [  299.772069] mtd_speedtest: page write speed is 4492 KiB/s
> [  299.777583] mtd_speedtest: testing page read speed
> [  341.283668] mtd_speedtest: page read speed is 12568 KiB/s
> ...
> 
> And with conditional OOB again, reading OOB if required in
> vf610_nfc_correct_data.
> ...
> [   29.907147] mtd_speedtest: testing eraseblock write speed
> [  141.146171] mtd_speedtest: eraseblock write speed is 4689 KiB/s
> [  141.152185] mtd_speedtest: testing eraseblock read speed
> [  181.644380] mtd_speedtest: eraseblock read speed is 12883 KiB/s
> [  183.703198] mtd_speedtest: testing page write speed
> [  299.423179] mtd_speedtest: page write speed is 4507 KiB/s
> [  299.428671] mtd_speedtest: testing page read speed
> [  340.695925] mtd_speedtest: page read speed is 12640 KiB/s
> [  342.747510] mtd_speedtest: testing 2 page write speed
> ...
> 
> The last test is probably pointless since we never read a empty page in
> the speedtest. So performance hit is measurable but small (somewhat
> below 100KiB/s).
> 
> This is with 64 bytes OOB. Since OOB sizes are only getting bigger, I
> would rather still consider it... What do you think?

If the code isn't that ugly, then keep the conditional OOB. But I'd
consider that performance difference almost negligible, given the noise
for the write tests is on the order of 40 KB/s.

Brian
