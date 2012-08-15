From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Aug 2012 07:12:09 -0400
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
Message-ID: <20120815111209.GB22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 09:36:57AM +0100, Alan M Butler wrote:
> 
> On 15 Aug 2012, at 00:56, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > On Tue, Aug 14, 2012 at 09:06:16PM +0100, Ownerx35 wrote:
> >> I have created a patch and have tested it myself that create a board
> >> setup file for the Iomega StoreCenter IX2-200, create a dts file and
> >> insert the appropriate lines into the common.h, makefile,
> >> makefile.boot, kconfig and board-ft files.
> > 
> > Awesome!
> > 
> >> But am unsure how to properly submit it should i just post it here? or
> >> is there a specific place i should post?
> > 
> > Take a look at /path/to/linux_src/Documentation/SubmittingPatches .
> > 
> > If you prefer working with git, the two commands I use are format-patch
> > and then send-email.
> > 
> > Assuming the board is ARM based (most likely), then you've found the
> > correct list.
> > 
> > Just post the series here and we'll offer helpful comments ;-)
> > 
> > Also, please check MAINTAINERS for the directories you are changing and
> > include the maintainers in the CC: or TO:.  Most likely, that'll be
> > myself and Andrew Lunn (kirkwood / orion boards).
> > 
> > hth,
> > 
> > Jason.
> 
> Sorry i meant board-dt in the previous message and the name just
> getting used to the mail program on os x aswel. I have run through the
> checkpatch.pl script and it tells me there are no errors but i just
> found out a few minutes ago theres a fix for the 2 sata ports not
> working (on all kirkwood devices as far as i know) so i am going to
> test that now as it envolves modifying a line in the dts file.

Ok.  Please let everyone know in the comment portion of the patch (after
the --- line) that your patch depends on this fix.  I haven't seen the
patch you're referring to yet.  I'll keep my eye out for it.

> Also it is defiantly an arm kirkwood device. My patch also does not
> modify any driver's or anything else just create's the appropriate
> file in the arch/am/boot/dts directory and the board config in the
> arch/arm/mach-kirkwood directory along with adding the lines to the
> appropriate files in that directory. So do i need to inform anyone
> else? the maintainers file is pretty long and i am unsure of what /
> who i am looking for in it.

Nope, sounds like you can just send it to the list, myself, and Andrew
Lunn.  Are you using git to generate the patch?  If not, I highly
recommend it.  I'm not sure about Apple Mail in particular, but most
graphical mail clients tend to mangle patches.

Here's a quick and dirty on what I do with git:

git clone \
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

cd linux

git checkout -b my_new_board v3.6-rc1

hack, hack, hack

mkdir /tmp/patches

git format-patch -o /tmp/patches/ --thread=shallow --cover-letter \
v3.6-rc1..HEAD

# edit /tmp/patches/0000-cover-letter.patch

./scripts/checkpatch.pl /tmp/patches/*.patch
	# ignore errors about patch 0000-cover-letter.patch
	# it's not a patch.

git send-email --to="$MY_EMAIL_ADDR" --smtp-server=$EMAIL_SRV \
--no-chain-reply-to --from="$MY_EMAIL_ADDR" /tmp/patches/*.patch
	# send to yourself first to make sure it looks correct,
	# applies properly from your email client, and is threaded
	# properly

# if it looks good, change the --to and --cc's in the above command to
# send it to me and Andrew, and cc the linux-arm-kernel list.

that's it.  If the list suggests any changes it's a lot easier to make
those changes once you have git set up.  Especially with a series of
patches.

hth,

Jason.
