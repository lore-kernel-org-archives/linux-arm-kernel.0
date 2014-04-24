From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 14:30:36 +0100
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140423202546.GA3890@nuc.fastwebnet.it>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
 <20140418151551.GZ12304@sirena.org.uk>
 <20140423202546.GA3890@nuc.fastwebnet.it>
Message-ID: <20140424133036.GY12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 10:25:46PM +0200, Carlo Caione wrote:

> I'm having a really hard time with this problem, so any hint is welcome
> :) The small modification I'm using on top of the patches in this series
> is here: http://bpaste.net/show/228330/

> Unfortunately as I said I got this when booting:
> http://bpaste.net/show/nUhUTzELT32v9HNPathL/

Huh, actually the arizona drivers do show this (it was being masked in
my logs by another unrelated bug).  I guess the Wolfson guys aren't
working with upstream much (though Charles did write the orignal code
here...).

The issue is the MFD core, it shouldn't be using managed allocations
here - the error reported by the assert is entirely correct.  If the
CODEC driver is bound and unbound it'll not be possible to reload it
as things stand.  

Your driver is correct but the implementation needs to be fixed -
possibly with an API change on free since at the minute the cells to be
freed don't get passed back into the MFD core when deallocating.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/f92224c1/attachment-0001.sig>
