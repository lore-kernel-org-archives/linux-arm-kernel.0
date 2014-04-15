From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 19:50:25 +0100
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <2863495.Gjdj6NpOm9@phil>
References: <3748421.ND1tAjvgKS@typ> <2745802.Mh5myQIMrf@phil>
 <20140415175504.GG12304@sirena.org.uk> <2863495.Gjdj6NpOm9@phil>
Message-ID: <20140415185025.GH12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 08:39:24PM +0200, Heiko St?bner wrote:

> The register has 32 bit. The upper 16 bit [31:16] are a write enable mask, so 
> to change bit x, you also have to set (x+16) to 1.

Perhaps I'm missing something about why this is helpful but it does seem
like the hardware designers have good drugs here.

> To cite the relevant bits 31:16:
> 	bit0~bit15 write enable
> 	When bit 16=1, bit 0 can be written by software .
> 	When bit 16=0, bit 0 cannot be written by software;
> 	When bit 17=1, bit 1 can be written by software .
> 	When bit 17=0, bit 1 cannot be written by software;
> 	...

> And these "write enable" bits are reset to 0 after the write, so if you write 
> 0x30001 you will get something like 0x1 on the next read, without the mask.

For non-volatile registers this should work fine if the write enable
bits are just latched on at probe time, we'll never actually look at the
what the hardware reads back once things are in cache.  For ones that
are volatile we'll need to teach the framework about it...  a write
enable mask setting that we splat into the value perhaps?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/57db1d0a/attachment.sig>
