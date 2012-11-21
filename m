From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Nov 2012 10:31:34 +0900
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <20121120215429.B621F3E1821@localhost>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
Message-ID: <20121121013133.GE4673@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:54:29PM +0000, Grant Likely wrote:
> On Sat, 17 Nov 2012 19:55:45 +0900, Alexandre Courbot <acourbot@nvidia.com> wrote:

> > With the advent of the device tree and of ARM kernels that are not
> > board-tied, we cannot rely on these board-specific hooks anymore but

> This isn't strictly true. It is still perfectly fine to have board
> specific code when necessary. However, there is strong encouragement to
> enable that code in device drivers as much as possible and new board
> files need to have very strong justification.

This isn't the message that's gone over, and even for device drivers
everyone seems to be taking the whole device tree thing as a move to
pull all data out of the kernel.  In some cases there are some real
practical advantages to doing this but a lot of the people making these
changes seem to view having things in DT as a goal in itself.

> I'm thinking about the scripts as trivial-to-parse ascii strings that
> have a very simple set of commands. The commands use resources already
> defined in the node. ie. 'g0' refers to the first entry in the gpios
> property. 'r0' for the regulator, 'p0' for the pwms, 'd' means delay. By
> no means take this as the format to use, it is just an example off the
> top of my head, but it is already way easier to work with than putting
> each command into a node.

It does appear to have some legibility challenges, especially with using
the indexes into the arrays of resources.  On the other hand the arrays
should be fairly small.

> > +Platform Data Format
> > +--------------------
> > +All relevant data structures for declaring power sequences are located in
> > +include/linux/power_seq.h.

> Hmm... If sequences are switched to a string instead, then platform_data
> should also use it. The power sequence data structures can be created at
> runtime by parsing the string.

Seems like a step backwards to me - why not let people store the more
parsed version of the data?  It's going to be less convenient for users
on non-DT systems.

As I said in my earlier reviews I think this is a useful thing to have
as a utility library for drivers independantly of the DT bindings, it
would allow drivers to become more data driven.  Perhaps we can rework
the series so that the DT bindings are added as a final patch?  All the
rest of the code seems OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/da33be77/attachment-0001.sig>
