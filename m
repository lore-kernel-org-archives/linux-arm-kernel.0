From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Nov 2013 19:53:13 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <528BBB85.8050507@wwwdotorg.org>
References: <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <528BB109.2060201@wwwdotorg.org>
 <20131119185212.GO16735@n2100.arm.linux.org.uk>
 <528BBB85.8050507@wwwdotorg.org>
Message-ID: <20131119195313.GQ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 12:27:01PM -0700, Stephen Warren wrote:
> On 11/19/2013 11:52 AM, Russell King - ARM Linux wrote:
> > The installation should just copy the blobs to a path in the filesystem
> > _or_ allow a distro to hook into the installation process, just like we
> > provide for the installation of the zImage.  That is our job done.  We
> > should do *nothing* more.
> 
> OK, if you're arguing that there should be absolutely zero renaming at
> all under any circumstances, I'm fine with that.

That's what I'm arguing for.  Consider what happens when we need to
identify a specific DT blob to be used for a board:

"For the Zynteknology Amazingboard, you need to use the DT file
imx6dl-amazingboard.dtb".

What happens if we have an installation system which renames the files?

"For the Zynteknology Amazingboard, you need to use the DT file
imx6dl-amazingboard.dtb, but this may also be named
zynteknology,amazingboard.dtb on installation".

Now, the user has to work out which of two filenames instead of just one,
and it becomes a lot harder - it's not difficult for _us_ developers, but
from the user point of view, it is, because there is now two things they
have to deal with, and a greater chance of making an error.

Now, as for using the compatible strings, if you look at the email I just
sent previously, I've shown why naming DT blobs by their compatible string
is a stupid thing to do.  I'll go further: it's an idiotic thing which
can't work.

We already have DT blobs which contain a _range_ of compatible strings.
Does that mean we always choose the first compatible string?  If you're
using that to match up a DT blob, you've just failed because what if
your platform needs to match against the second compatible string?

Use symlinks for all compatible strings?  Well, what if you have two DT
blobs which contain the same compatible string?  Yes, we do have lots
which fall into this case already.

Hence, naming files by compatible string _can't_ ever work sanely.  It
assumes that compatible strings are unique.  They plainly aren't.

So, I think we keep the existing naming scheme and just copy the files
as is to the installation location.  Anything more than that is a
"distro" choice - if a distro wants to offer the user a list of DT
images to use, the distro needs a tool which parses the compatible
strings, works out which of the files match the target, and present the
user with that choice - because we already have the case where there is
no 1:1 relationship between files and board.
