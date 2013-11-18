From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 18 Nov 2013 15:29:54 +0200
Subject: [PATCH 0/3] omapdss: venc: Add support for bypass and acbias.
In-Reply-To: <F97741D2-FC6F-4DBD-A0DD-E35304501993@goldelico.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <CAAfyv34j+YhEjtHyf7zg5oBoCV5ROEXow8VV0PQNHLTF5uDZJg@mail.gmail.com>
 <5280DBA6.50303@ti.com> <FB10035C-B13C-4A03-BE9C-0576806F2577@goldelico.com>
 <5280E617.3000004@ti.com>
 <F97741D2-FC6F-4DBD-A0DD-E35304501993@goldelico.com>
Message-ID: <528A1652.4000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-11 16:30, Dr. H. Nikolaus Schaller wrote:

> Maybe it looks as if it is an unsolvable problem. The OPA works only if acbias
> and bypass are enabled, but is not allowed to tell that it is there.

That's why the board file or dts file is there, to have "glue" data to
make different pieces work together.

The perfect (?) solution would be a CDF like data. The idea would be
that in the board file, you would describe configuration options for
VENC and for OPA. In this particular case, you'd tell VENC that it needs
to enable acbias and bypass when OPA is to be connected to VENC. Then
there could be more entries for VENC, saying disable acbias and bypass
when BAR is to be connected to VENC.

However, we don't have such support (yet).

For now, I hope it's enough if we handle VENC in a "single
configuration" manner, i.e. you'll tell VENC to enable acbias and bypass
when VENC is enabled. This means you can't have board setups where you'd
change the VENC->OPA connection to some other analog tv output at
runtime. I hope that's the case (i.e. OPA is always in use on that board).

If so, then I think you can just pass the acbias and bypass
configuration values via omapdss platform data. And VENC driver will use
them to configure those. OPA doesn't know anything about this at all.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/0cbad3b4/attachment.sig>
