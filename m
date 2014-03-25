From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 25 Mar 2014 19:00:45 -0300
Subject: [RFC 00/47] mtd: nand: Add new driver supporting ST's BCH h/w
In-Reply-To: <20140325131139.GB24823@lee--X1>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <20140325125050.GB665@arch.cereza> <20140325131139.GB24823@lee--X1>
Message-ID: <20140325220045.GA12185@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 25, Lee Jones wrote:
> On Tue, 25 Mar 2014, Ezequiel Garcia wrote:
> 
> > Hi Lee,
> > 
> > On Mar 25, Lee Jones wrote:
> > > 
> > > This patch-set was written against kernel version v3.4, but applies
> > > cleanly to v3.13-rc7 which it is currently based. I understand that
> > > the core has changed significantly since and that some of the
> > > infrastructure this driver provides is now available either through
> > > the framework or similar means. I'm looking for someone with inside
> > > knowledge to draw attention to those areas so we can align with the
> > > most recent API.
> > > 
> > 
> > Please push a git branch. It will be nice to have a way of seeing the 'big
> > picture' without applying the 47 patches.
[..]
> 
>   git://git.linaro.org/people/lee.jones/linux-3.0-ux500.git tb-st-mtd-nand-bch
> 

Lee,

After taking a quick glance at the whole driver I noticed you have something
strange going on. AFAIK, the typical NAND driver probe() should be one of
these two:

* Call nand_scan() which calls nand_scan_ident() + nand_scan_tail().

* Call nand_scan_ident() to identify the NAND device geometry, do some
  driver specific initialization, fill some hooks, and finally call
  nand_scan_tail() to complete the initialization.

You driver call nand_scan_ident() and then does some bad block scan, and
fills some callbacks on its own, but never calls nand_scan_tail().

The call to nand_scan_tail() would remove the need to export those NAND
core functions, and remove the need to scan and print the bad blocks.
I don't know if you have a real reason for not doing it this way, or
maybe it's the way this driver was originally written.

Care to review this and re-spin the driver? You'll have a more nicer
driver, and more framework-compliant.

Also, if you plan to target v3.16 on this, I'd suggest that you pick
some pack of features and submit those first, reducing the amount of code
to be reviewed. For instance, you may choose to leave some of the ECC bits
aside for now.

It's just a suggestion to get at least some of the code merged quicker,
don't take me too seriously on this.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
