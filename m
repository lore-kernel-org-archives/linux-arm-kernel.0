From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Mar 2016 10:06:15 +0000
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <20160322100615.GA2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 06:39:51AM +0000, Lakshmi Sai Krishna Potthuri wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.  Please also avoid reflowing other text
into longer lengths, this makes things worse.

> >This isn't enough to add the feature - a client driver trying to make use of this
> >needs to be able to tell if the cycles are actually going to be inserted.  I'd
> >expect to see a capability flag that can be checked and some error checking so
> >that if we try to do a transfer with dummy cycles and can't support it we don't
> >silently ignore the dummy cycles, ideally also something that'll handle
> >multiples of 8 bits with SPI controllers that don't otherwise support this
> >feature.

> Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally works.
> But it can be vary based on the flash and the type of read command.
> Dummy bytes are taken care of in m25p80.c by adjusting the len field:
> Length = size of (command + address + dummy byte)

> There might be controllers (like ZynqMP GQSPI) that would be able to use
> the information that dummy byte(s) were added and the precise number
> of dummy cycles. This patch does not disturb the existing implementation
> of adjusting length (as described above). It adds an additional optional feature.
> So there is no harm to controllers that can't support it - they can ignore it and
> still work with the existing "length adjustment" implementation.
> If you think there value in adding a capability flag, please let me know.

This is really not what I'd expect to happen, I'd expect that these
dummy cycles would be in addition to the actual data (see my request for
better documentation...).  If they overlap with the data then what is
the point in specifying this?  It's more work for the host, what benefit
do we get from doing it over just handing it like a normal byte?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160322/a0ed364c/attachment.sig>
