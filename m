From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Feb 2012 14:36:55 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120221132216.GJ19696@mudshark.cambridge.arm.com>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
 <201202210124.23028.paul@codesourcery.com>
 <20120221083612.GG22562@n2100.arm.linux.org.uk>
 <20120221100041.GA19696@mudshark.cambridge.arm.com>
 <20120221101052.GH22562@n2100.arm.linux.org.uk>
 <20120221105250.GC19696@mudshark.cambridge.arm.com>
 <20120221113548.GK22562@n2100.arm.linux.org.uk>
 <20120221132216.GJ19696@mudshark.cambridge.arm.com>
Message-ID: <20120224143655.GH13504@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 01:22:16PM +0000, Will Deacon wrote:
> On Tue, Feb 21, 2012 at 11:35:48AM +0000, Russell King - ARM Linux wrote:
> > I don't think fixing this in mainline until we know the full story behind
> > this is the right thing to be doing.  There's no point fixing a feature
> > which no one's using.
> 
> Understood. Paul - would you please be able to confirm that:
> 
> (a) GDB is currently broken on uclinux? (it certainly looks that way)
> (b) My proposed patch fixes the problem?
> 
> If you don't have an environment set up, I wonder if there's somebody else
> we can poke who's playing with this stuff.

Well in the meantime I had a play with the latest CodeSourcery tools:

GNU gdbserver (Sourcery G++ Lite 2011.03-46) 7.2.50.20100908-cvs
Copyright (C) 2010 Free Software Foundation, Inc.
gdbserver is free software, covered by the GNU General Public License.
This gdbserver was configured as "arm-uclinuxeabi"

on the target and

GNU gdb (Sourcery G++ Lite 2011.03-46) 7.2.50.20100908-cvs
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=arm-uclinuxeabi".

on the host.

It seems as though my ptrace patch makes *no difference* because these
tools don't even use the PT_ADDR_TEXT etc magic offsets! As a result,
trying to set a breakpoint by symbol fails miserably because it tries to
poke the symbol offset directly, without adding on the base address of the
text.

Are there any tools available that use these magic numbers or are mine just
too old? Given that the whole thing dies after a while with:

[  909.062821] [430] gdbserver: obsolete system call 02b37558.

I'm not entirely convinced by the stability of what I'm using (that syscall
number looks like an address to me).

Will
