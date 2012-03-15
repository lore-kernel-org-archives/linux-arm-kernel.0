From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 10:44:44 +0000
Subject: [PATCH v3 1/6] regmap: add support for 7_25 format
In-Reply-To: <1331757790-10583-2-git-send-email-marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
 <1331757790-10583-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120315104443.GC3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 07:43:05AM +1100, Marc Reilly wrote:
> This adds support for devices with 7 address bits and 25 data bits.
> The initial intended user for this are the mc13xxx mfds in spi mode.
> (The 25th data bit is actually a dummy bit)
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>

It looks like this should be using the pad_bits parameter, though
currently we only actually support pad bytes and integer sized register
values.  Ugh.  We also have some entertainment because this device
contains a touchscreen so I imagine you want readback but devices using
odd register sizes don't do readback right now.

What I think we want to do here is use pad_bits then internally to the
API notice that reg_bits + pad_bits is a byte and therefore set up for 8
bit registers and set a new value reg_shift in the map which shifts the
register address left, either teaching the register format functions
about it or just making a new one.  This should work better from a
framework point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/5fbd7597/attachment.sig>
