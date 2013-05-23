From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Thu, 23 May 2013 15:00:39 +0200
Subject: mxsfb: DATA_FORMAT_24_BIT flag outputs invalid colours
In-Reply-To: <519E03B0.1080006@digi.com>
References: <519E03B0.1080006@digi.com>
Message-ID: <20130523130039.GF8595@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

On Thu, May 23, 2013 at 01:55:28PM +0200, Hector Palacios wrote:
> Hello,
> 
> I'm using an i.MX28 based board with lcd connected with 18bits data bus.
> My platform uses 32 bits per pixel:
> 
> 	mxsfb_pdata.default_bpp = 32;
> 	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
> 
> With these settings the mxsfb.c driver sets flag DATA_FORMAT_24_BIT
> at HW_LCDIF_CTRL register in function mxsfb_set_par():
> 
> 	case 32:
> 		dev_dbg(&host->pdev->dev, "Setting up RGB888/666 mode\n");
> 		ctrl |= CTRL_SET_WORD_LENGTH(3);
> 		switch (host->ld_intf_width) {
> 		case STMLCDIF_8BIT:
> 			dev_dbg(&host->pdev->dev,
> 					"Unsupported LCD bus width mapping\n");
> 			return -EINVAL;
> 		case STMLCDIF_16BIT:
> 		case STMLCDIF_18BIT:
> 			/* 24 bit to 18 bit mapping */
> 			ctrl |= CTRL_DF24; /* ignore the upper 2 bits in
> 					    *  each colour component
> 					    */
> 			break;
> 		case STMLCDIF_24BIT:
> 			/* real 24 bit */
> 			break;
> 		}
> 
> According to the manual, this flag does:
> 	0x0: ALL_24_BITS_VALID: Data input to the block is in 24 bpp
> format, such that all RGB 888 data is contained in 24 bits.
> 	0x1: DROP_UPPER_2_BITS_PER_BYTE ? Data input to the block is
> actually RGB 18 bpp, but there is 1 colour per byte, hence the upper
> 2 bits in each byte do not contain any useful data, and should be
> dropped.
> 
> The setting of this flag is producing bad colours with true colour
> images (i.e. the Linux penguin is displayed ok, but QT applications
> or images displayed with fbv are not).
> I believe the setting of this flag is not correct (after all, if my
> bpp is 32, then all 24bit colours are useful and dropping the upper
> 2 bits is a bad idea).
> If I don't set it, then true colour images are displayed correctly.
> The only problem is that the Linux penguin is displayed much darker
> than usual (correct colours, but darker). Perhaps the 224 colour
> format of this image justifies it?
> 
> I noticed the cfa10049 platform also uses the same configuration (18
> bits data bus and 32bpp) and was wondering if true colour images are
> correctly displayed in this platform with this flag set (for example
> with fbv application [1]).

I had the exact same problem, and suggested the exact same solution a
few weeks back.

https://patchwork.kernel.org/patch/2470441/

The conclusion of that discussion what that the userspace applications
were not honouring the bitfield correctly set by the mxsfb driver, and
as such, it was not a bug in the driver.

While this is correct, I wonder, now that since we had that same problem
in a very short amount of time, if we couldn't set this behaviour
dependant of some (dt? kernel argument?) property so that one could
customise it anyway he want.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
