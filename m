From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 01:34:39 +0100
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20130924124122.64834b2a@armhf>
References: <20130924124122.64834b2a@armhf>
Message-ID: <20131018003439.GG2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:

> This patch adds S/PDIF input/output for mvebu DT boards.

This got less discussion than I was expecting and then slipped under a
lot of other patches in my queue while that was timing out, sorry...  in
any case, this still has the issue that it used a single DAI and a
single DAI link to represent two physical DAIs and their links.

Please as covered in the prior threads on this either implement DPCM or
implement two traditional DAIs which can't be used simultaneously (which
should be simpler and can then be built on incrementally).

The last set of DPCMish patches was reported to work so should be a
fairly small refactoring away from being OK - the main thing is to
create back end DAIs for the physical links and then put the widgets
that manage the enable of the S/PDIF and I2S interfaces between the FE
and BE DAIs instead of directly connecting them to widgets on the CODEC.

For two traditional DAIs it should just be a case of duplicating the DAI
with a differnet ID then setting the enable bits based on the ID of the
DAI in use and ideally adding some code to check that they're not both
active (or that limit can be enforced by only having machine drivers
that use one or the other).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/48776b99/attachment.sig>
