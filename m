From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2017 01:12:42 +0000
Subject: [PATCH V10 07/10] efi: print unrecognized CPER section
In-Reply-To: <58AC9093.5020303@arm.com>
References: <1487188282-2568-1-git-send-email-tbaicar@codeaurora.org>
 <1487188282-2568-8-git-send-email-tbaicar@codeaurora.org>
 <58AC9093.5020303@arm.com>
Message-ID: <20170222011241.GX21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 07:10:11PM +0000, James Morse wrote:
> Hi Tyler,
> 
> On 15/02/17 19:51, Tyler Baicar wrote:
> > +	} else {
> > +		const void *unknown_err;
> > +
> > +		unknown_err = acpi_hest_generic_data_payload(gdata);
> > +		printk("%ssection type: %pUl\n", newpfx, sec_type);
> > +		printk("%ssection length: %d\n", newpfx,
> 
> Nit: please use the "%s""section... that this file consistently uses. This means
> this code will still work as expected when someone adds '%ss' support to printk!

No.  That is wrong:

"%s""section" is stored in memory as bytes containing:

'%' 's' 's' 'e' 'c' 't' 'i' 'o' 'n'

whereas "%ssection" is stored in memory as bytes containing:

'%' 's' 's' 'e' 'c' 't' 'i' 'o' 'n'

They're exactly the same, so when printk() comes to parse the string, it
sees exactly the same byte sequence.  So, the only thing that's happening
is code obfuscation for no good reason what so ever.

If you don't believe me, run some build tests and look at the resulting
strings... also look at the C standard.  "Adjacent string literal tokens
are concatenated."

Please get rid of this obfuscation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
