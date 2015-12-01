From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Dec 2015 18:16:43 +0000
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151201122212.474afce5@gandalf.local.home>
References: <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
 <20151201161944.GX8644@n2100.arm.linux.org.uk>
 <20151201114929.655433a2@gandalf.local.home>
 <20151201171014.GY8644@n2100.arm.linux.org.uk>
 <20151201122212.474afce5@gandalf.local.home>
Message-ID: <20151201181643.GZ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 12:22:12PM -0500, Steven Rostedt wrote:
> On Tue, 1 Dec 2015 17:10:14 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > Another suggestion - maybe recordmcount, which fstat()s the file,
> > should check the st_nlink before modifying the file, and error out
> > with a helpful error message telling people not to use hardlinks,
> > which would stop nasty surprises (and make it a rule that this should
> > be implemented as a general principle for good build behaviour) - iow,
> 
> Actually I like this solution the best.
> 
> > something like this (untested):
> 
> Can you test it to see if it gives you the error, otherwise I need to
> set up a CCACHE_HARDLINK environment :-)

It does indeed:

  CC      init/do_mounts_initrd.o
file is hard linked: init/do_mounts_initrd.o
/home/rmk/git/linux-rmk/scripts/Makefile.build:258: recipe for target 'init/do_mounts_initrd.o' failed
make[2]: *** [init/do_mounts_initrd.o] Error 1

> I guess another solution is to do a copy instead of modifying in place
> if it detects the multiple hard link?

That would be the "transparent" solution.  If you think it's worth
persuing, I'll have a go at fixing recordmcount to do that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
