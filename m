From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 13:10:42 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over SMBus
In-Reply-To: <534D1DDA.40207@free-electrons.com>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk>
 <534CE16D.8010508@free-electrons.com>
 <20140415100922.GN12304@sirena.org.uk>
 <534D1DDA.40207@free-electrons.com>
Message-ID: <20140415121042.GV12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 01:54:02PM +0200, Boris BREZILLON wrote:
> On 15/04/2014 12:09, Mark Brown wrote:

> > OK, so if this a realistic issue then it seems like it's better to
> > implement three different buses - there is not really any common code
> > between the various paths.

> Okay, I'll create 4 different busses (one for each access type).
> BTW, should I keep these implementations in the same source file
> (regmap-smbus.c) ?
> And, should I keep one method to register an smbus regmap or should I
> provide one method per access type and get rid of the
> regmap_smbus_transfer_type enum ?

Do something that looks tasteful in implementation.

> >   This would also mean that you avoid having
> > gather write when it can't be implemented.

> Correct me if I'm wrong, but they all support gather write.

Everything except for the block transfers is writing one register at a
time, actually looking again everything that can only write one register
at a time ought not to be implementing the buffer based stuff at all and
should instead be hooked into reg_read() and reg_write() - it's not able
to implement the API properly in any of the cases, it's unpacking the
buffer which the upper level code already supports.

> > The code is also not validating the lengths for two byte values.

> I'm not sure I get this one.
> Do you mean I should check that val_size is a 2 byte multiple ?
> If this is what you meant, then I should also check it for block transfers.

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/63eff8cd/attachment.sig>
