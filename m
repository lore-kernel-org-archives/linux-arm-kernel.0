From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 29 Jan 2014 15:46:20 -0300
Subject: [RFC PATCH v2 08/14] mtd: nand: add sunxi NAND flash controller
 support
In-Reply-To: <20140129175641.GF1427@obsidianresearch.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-9-git-send-email-b.brezillon.dev@gmail.com>
 <20140129175641.GF1427@obsidianresearch.com>
Message-ID: <20140129184619.GC27143@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 10:56:42AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2014 at 03:34:18PM +0100, Boris BREZILLON wrote:
> 
> [..]
> 
> > +static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
> [..]
> > +       ret = sunxi_nand_chip_init_timings(chip, np);
> > +       if (ret)
> > +               return ret;
> [..]
> > +       ret = nand_scan_ident(mtd, nsels, NULL);
> 
> This ordering looks a bit problematic, will onfi_get_async_timing_mode
> ever return anything other than ONFI_TIMING_MODE_UNKNOWN if it is
> called before nand_scan_ident ? What sets clk_rate to non-zero if there
> is no DT property?
> 
> For a flow that uses onfi_get_async_timing_mode rather than DT the
> driver should set the interface to timing mode 0 (slowest) and then
> call nand_scan_ident, and then reset the interface to the detected
> timing mode.
> 

Yes. And I believe this is a requirement from the ONFI 2.1 spec:

"""
4.1.4.3. Source Synchronous to Asynchronous
[..]

The host shall transition to the asynchronous data interface. Then the
host shall issue the Reset (FFh) command described in the previous paragraph
using asynchronous timing mode 0, thus the host transitions to the asynchronous
data interface prior to issuing the Reset (FFh). A device in any timing mode is
required to recognize a Reset (FFh) command issued in asynchronous timing
mode 0.

[..]

After CE# has been pulled high and then transitioned low again, the host
should issue a Set Features to select the appropriate asynchronous timing mode.
"""

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
