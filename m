From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 18:53:43 +0200
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <20130605192019.GG18614@n2100.arm.linux.org.uk>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <20130605073418.15758.93704.sendpatchset@w520>
 <20130605192019.GG18614@n2100.arm.linux.org.uk>
Message-ID: <201306061853.44135.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013, Russell King - ARM Linux wrote:
> On Wed, Jun 05, 2013 at 04:34:18PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Introduce SHMOBILE_FIXUP() as a helper function to
> > allow boards to specify their memory base and size.
> 
> No.  I really don't like this idea (we've had people doing this in the
> past and I went around removing all that crap, and adding command line
> options into the defconfig files for those boards.)
> 
> I also fail to understand why in 2013, some 11 years after ATAG stuff
> was created, people still can't get pass correct information into
> the kernel.
> 
> It's exactly this kind of issue which makes me believe that stuff like
> ACPI, UEFI and DT are doomed to fail on ARM because this kind of problem
> constantly crops up time and time again.  People have seem to have this
> total inability to get the pre-kernel environment right.

I think the problem in this case is that the pre-boot environment is
essentially nothing but mask rom jumping into head-shmobile.S, which
is something nobody else does.

My understanding is that you can also put a regular u-boot, kexec or
some other boot loader into the same place and get a running system with
correct ATAGS or DT information.

It's debatable whether booting the kernel directly without an upgradable
boot loader is a good idea, but since Renesas have come to depend on
this and it's been supported by Linux for ages (both on ARM and SH),
I would certainly not ask them to remove support for that.

What I think we can do however is move all that configuration into
one place of the kernel that is fairly separate from everything else.
head-shmobile.S already contains most of the special case, so
how about adding a configuration option that enables both the
head-shmobile.S code and contains the configuration for that in
a submenu?

	Arnd
