From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 26 Mar 2014 00:28:05 -0700
Subject: [RFC 00/47] mtd: nand: Add new driver supporting ST's BCH h/w
In-Reply-To: <20140325220045.GA12185@arch.cereza>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <20140325125050.GB665@arch.cereza> <20140325131139.GB24823@lee--X1>
 <20140325220045.GA12185@arch.cereza>
Message-ID: <20140326072805.GB31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 07:00:45PM -0300, Ezequiel Garcia wrote:
> After taking a quick glance at the whole driver I noticed you have something
> strange going on. AFAIK, the typical NAND driver probe() should be one of
> these two:
> 
> * Call nand_scan() which calls nand_scan_ident() + nand_scan_tail().
> 
> * Call nand_scan_ident() to identify the NAND device geometry, do some
>   driver specific initialization, fill some hooks, and finally call
>   nand_scan_tail() to complete the initialization.
> 
> You driver call nand_scan_ident() and then does some bad block scan, and
> fills some callbacks on its own, but never calls nand_scan_tail().
> 
> The call to nand_scan_tail() would remove the need to export those NAND
> core functions, and remove the need to scan and print the bad blocks.
> I don't know if you have a real reason for not doing it this way, or
> maybe it's the way this driver was originally written.
> 
> Care to review this and re-spin the driver? You'll have a more nicer
> driver, and more framework-compliant.

A hearty +1 to this. You are avoiding much of the core of the NAND
framework by avoiding the nand_chip callbacks and nand_scan_tail(), and
by reimplementing the BBT. I will have to NAK to some of the patches
that EXPORT the nand_base private core (e.g., nand_get_device()), and I
will most likely NAK the custom BBT implementation (please improve
nand_bbt.c as needed).

> Also, if you plan to target v3.16 on this, I'd suggest that you pick
> some pack of features and submit those first, reducing the amount of code
> to be reviewed. For instance, you may choose to leave some of the ECC bits
> aside for now.
> 
> It's just a suggestion to get at least some of the code merged quicker,
> don't take me too seriously on this.

That's a possible approach if it still leaves your driver functional.
But I wouldn't trim the driver too much just for sake of reviewing.

BTW, why do you call this driver stm_nand_bch? BCH is a particular type
of ECC algorithm, not unique at all to ST's hardware. Can you drop the
_bch and make it just stm_nand? Also, you might want to change the
namespacing on some of your functions; for instance, I don't think you
can own the name bch_write(). Possibly prefix things with stm_* or
stm_nand_* where reasonable.

Brian
