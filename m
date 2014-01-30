From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 Jan 2014 14:15:12 -0700
Subject: recommended action for bootloaders regarding modifying
 device-tree nodes
In-Reply-To: <20140130204558.GC29184@titan.lakedaemon.net>
References: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
 <20140130204558.GC29184@titan.lakedaemon.net>
Message-ID: <20140130211512.GD13372@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 03:45:58PM -0500, Jason Cooper wrote:

> This is more of a process question:  Is there any information captured
> in your EEPROM that can't be represented in the dtb?  iow, at the point
> when you write the EEPROM, why not write the dtb to it as configured?

I can share what we do here.. In our systems the serial EEPROM is only
256 bytes, so storing things in DT format would be challenging.

What we do is have a master DTB that has the union of all our
configurations. The boot process has a very simple bit of code that
runs down the DTB in binary format and replaces entire
OF_DT_BEGIN_NODE->OF_DT_END_NODE regions with OF_DT_NOP.

The NOP approach is very simple, no other changes (eg offset
recalculation) needs to be done to the DT, so we can do this process
with a very small code footprint and without libfdt.

Choosing which sections to drop is done with some combination of
hardwired code and searching for specific property patterns. There are
also a few places where placeholder sections are directly fixed up, eg
a mac address is written into a placeholder of 0s, etc.

So an example might be

   optional_peripheral at 10000 {
      orc,board-style = <1>;
      [..]
   }

Eg The board-style number comes from the EEPROM and if board-style !=
1 then the entire stanza is replaced with NOP.

Jason
