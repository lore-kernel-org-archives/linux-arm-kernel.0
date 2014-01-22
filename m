From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 22 Jan 2014 23:43:16 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140122222641.GD29184@titan.lakedaemon.net> (Jason Cooper's
 message of "Wed, 22 Jan 2014 17:26:41 -0500")
References: <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net>
Message-ID: <87mwin4ozf.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Jason Cooper <jason@lakedaemon.net> writes:

> On Wed, Jan 22, 2014 at 11:23:23PM +0100, Arnaud Ebalard wrote:
>> With the patch applied on top of 3.13.0 kernel recompiled w/
>> CONFIG_PCI_MSI enabled, I cannot reproduce the bug. I guess
>> you can add my:
>> 
>>  Reported-and-tested-By: Arnaud Ebalard <arno@natisbad.org>
>> 
>> Since you'll have to push the patch to -stable team at least for 3.13,
>> I wonder if it would not make sense to extend that at least to 3.12.
>> and possibly 3.10 (3.2 is still widely used but I wonder if it makes
>> sense to go that far).
>
> Can you pinpoint the commit that introduced the regression?

f5182b4155b9d686c5540a6822486400e34ddd98 "xhci: Disable MSI for some Fresco Logic hosts."

Technically, this is not per se the commit which introduced the
regression but the one that *partially* fixed it by introducing the XHCI
quirk to skip MSI enabling for Fresco Logic chips. The thing is it
should have included the FL1009 in the targets. Sarah, can you confirm
this?

Jason, the logic is summarized here, AFAICT:

commit 455f58925247e8a1a1941e159f3636ad6ee4c90b
Author: Oliver Neukum <oneukum@suse.de>
Date:   Mon Sep 30 15:50:54 2013 +0200

    xhci: quirk for extra long delay for S4
    
    It has been reported that this chipset really cannot
    sleep without this extraordinary delay.
    
    This patch should be backported, in order to ensure this host functions
    under stable kernels.  The last quirk for Fresco Logic hosts (commit
    bba18e33f25072ebf70fd8f7f0cdbf8cdb59a746 "xhci: Extend Fresco Logic MSI
    quirk.") was backported to stable kernels as old as 2.6.36.
    
    Signed-off-by: Oliver Neukum <oneukum@suse.de>
    Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
    Cc: stable at vger.kernel.org


commit bba18e33f25072ebf70fd8f7f0cdbf8cdb59a746
Author: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Date:   Wed Oct 17 13:44:06 2012 -0700

    xhci: Extend Fresco Logic MSI quirk.
    
    Ali reports that plugging a device into the Fresco Logic xHCI host with
    PCI device ID 1400 produces an IRQ error:
    
     do_IRQ: 3.176 No irq handler for vector (irq -1)
    
    Other early Fresco Logic host revisions don't support MSI, even though
    their PCI config space claims they do.  Extend the quirk to disabling
    MSI to this chipset revision.  Also enable the short transfer quirk,
    since it's likely this revision also has that quirk, and it should be
    harmless to enable.
    
    <SNIP>

    This patch should be backported to stable kernels as old as 2.6.36, that
    contain the commit f5182b4155b9d686c5540a6822486400e34ddd98 "xhci:
    Disable MSI for some Fresco Logic hosts."
    
    Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
    Reported-by: A Sh <smr.ash1991@gmail.com>
    Tested-by: A Sh <smr.ash1991@gmail.com>
    Cc: stable at vger.kernel.org


commit f5182b4155b9d686c5540a6822486400e34ddd98
Author: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Date:   Thu Jun 2 11:33:02 2011 -0700

    xhci: Disable MSI for some Fresco Logic hosts.
    
    Some Fresco Logic hosts, including those found in the AUAU N533V laptop,
    advertise MSI, but fail to actually generate MSI interrupts.  Add a new
    xHCI quirk to skip MSI enabling for the Fresco Logic host controllers.
    Fresco Logic confirms that all chips with PCI vendor ID 0x1b73 and device
    ID 0x1000, regardless of PCI revision ID, do not support MSI.
    
    This should be backported to stable kernels as far back as 2.6.36, which
    was the first kernel to support MSI on xHCI hosts.
    
    Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
    Reported-by: Sergey Galanov <sergey.e.galanov@gmail.com>
    Cc: stable at kernel.org
