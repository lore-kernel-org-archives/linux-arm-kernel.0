From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 10 Apr 2015 13:50:56 +0000
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150410135056.GB28873@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Boris,

On Thu, Apr 09, 2015 at 04:58:41PM +0200, Boris Brezillon wrote:
> I know we usually try to adapt existing drivers instead of replacing them
> by new ones, but after trying to refactor the mv_cesa driver I realized it
> would take longer than writing an new one from scratch.

I'm sorry, but this makes me *very* uncomfortable.  Any organization
worth it's salt will do a very careful audit of code touching
cryptographic material and sensitive (decrypted) data.  From that point
on, small audits of the changes to the code allow the organization to
build a comfort level with kernel updates.  iow, following the git
history of the driver.

By apply this series, we are basically forcing those organizations to
either a) stop updating, or b) expend significant resources to do
another full audit.

In short, this series breaks the audit chain for the mv_cesa driver.

Maybe I'm the only person with this level of paranoia.  If so, I'm sure
others will override me.

>From my POV, it looks like the *only* reason we've chosen this route is
developer convenience.  I don't think that's sufficient reason to break
the change history of a driver handling sensitive data.

For an example of how I use the git history and binary differences to
audit a series of changes to cryptographic code, please take a look at
objdiff [1]. You can even duplicate my audit of my submission for the
skein/threefish driver currently in the staging tree, starting at [2]
and going up to [3].

thx,

Jason.

[1] scripts/objdiff [4]
[2] 449bb8125e3f "staging: crypto: skein: import code from Skein3Fish.git"
[3] 0264b7b7fb44 "staging: crypto: skein: rename macros"
[4] There are better tools out there for auditing actual code changes,
    radare (http://radare.org/r/) is one of them.  objdiff is good only
    at validating object code *hasn't* been changed by style commits.
