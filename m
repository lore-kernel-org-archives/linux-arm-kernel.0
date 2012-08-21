From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 21 Aug 2012 17:28:25 +0100
Subject: dreamplug spi partitions
In-Reply-To: <20120816142005.GS22226@titan.lakedaemon.net>
References: <1344498477.11783.38.camel@dagon.hellion.org.uk>
 <20120816142005.GS22226@titan.lakedaemon.net>
Message-ID: <1345566505.6821.115.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-16 at 10:20 -0400, Jason Cooper wrote:
> On Thu, Aug 09, 2012 at 08:47:57AM +0100, Ian Campbell wrote:
> > Hi all,
> > 
> > I've been using "fw_printenv" and "fw_setenv" from the u-boot-tools
> > package on my DreamPlug which work fine with this /etc/fw_env.config:
> >         # Configuration file for fw_(printenv/saveenv) utility.
> >         # Up to two entries are valid, in this case the redundant
> >         # environment sector is assumed present.
> >         # MTD device name       Device offset   Env. size       Flash sector size
> >         /dev/mtd1               0x00000000      0x00001000      0x00001000
> >         
> > This corresponds roughly, but not exactly, with:
> >         # cat /proc/mtd 
> >         dev:    size   erasesize  name
> >         mtd0: 00080000 00001000 "u-boot"
> >         mtd1: 00010000 00001000 "u-boot env"
> >         mtd2: 00010000 00001000 "dtb"
> > 
> > But notice how "Env. size" and mtd1's size don't match -- if I use
> > 0x10000 in fw_env.cfg then the tools don't work (checksums don't match).
> 
> I've always seen the u-boot environment set to 4k.

Right, so it seems like that is the right size for the kernel to report
then?

>   The kernel
> partitions came out of my head.  When I added support for the dreamplug
> to u-boot, I found out there was a bug in the factory supplied u-boot
> which only allowed it to see the first 1MB of the 2MB flash.  Also, the
> factory supplied kernel didn't even have support for the flash.
> 
> So, I fixed u-boot, and figured the extra 1MB was too small for a
> kernel, wasn't used by anybody else, and imho, the factory location of
> the environment didn't leave much room for new u-boots.
> 
> I decided to move the environment and make a place for the dtb.  As I
> didn't want to constrain either one, I split the extra space between the
> two.
> 
> Was that the best decision?  Well, no one yelled at me and I was new to
> the whole process, so that's how it went down.

;-)

I'm not saying the partitioning scheme is wrong or trying to criticize,
I just noticed that upstream u-boot and the kernel are inconsistent.

I haven't looked at the factory u-boot, I wouldn't be too torn up if it
matched neither of the other two though.

> As it is right now, if you configure your own u-boot to have, say
> 0x10000 bytes for the environment, you don't need to change your kernel
> to support it.  Just set the size and write it.
> 
> I'm open to suggestions and patches...

I think upstream u-boot and the kernel should match, but I'm not really
sure which one should be changed to match the other.

At this point I suppose it is generally easier for people to change
their kernel so that should be the one to change?

Ian.
-- 
Ian Campbell
Current Noise: Crowbar - Counting Daze

* gb notes that fdisk thinks his cdrom can store one terabyte
		-- Seen on #Linux
