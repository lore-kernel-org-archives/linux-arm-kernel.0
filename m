From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 16:50:09 +0200
Subject: [PATCH] drivers: brcmaxi: provide amba axi functionality in
	separate module
In-Reply-To: <op.vuallvn63ri7v4@arend-laptop>
References: <1303331669-31293-1-git-send-email-arend@broadcom.com>
	<201104211612.49805.arnd@arndb.de> <op.vuallvn63ri7v4@arend-laptop>
Message-ID: <201104211650.09213.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Arend van Spriel wrote:
> >
> > This list to me is a strong hint that the cores behind the AXI bridge
> > should normally be actual devices in Linux, i.e. the approach that
> > Rafa? suggested.  The vast majority of these is something that in Linux
> > would be operated by a device driver. The exceptions that I can see
> > are CPU cores and bus bridges, both of which we typically also represent
> > as devices in the flattened device tree, even though they typically
> > don't have a Linux driver attached to them.
> 
> Fine. Your providing the kind of feedback I was looking for. The  
> OFDM_CORE_ID is also an exception.
> 
> So could a device driver claim multiple cores/devices to assure other  
> drivers are not accessing those? I would prefer that over having  
> exceptions coded in the axi bus driver, like the chipcommon core  
> (CC_CORE_ID). I assume it can be done by the device table. Is that correct?

You can bind any number of devices to one driver, and the match table
can contain entries for different classes of devices. You can also
have multiple drivers list the same ID and return an error from the
probe() function for those devices that don't actually match the
driver, based on additional properties. E.g you could have multiple
ethernet drivers bind to ENET_CORE_ID, but then have each one check
if the ethernet hardware is actually the one that the driver was written
for.

A much harder thing to do would be having one device managed by multiple
drivers simultaneously. This usually requires to have some kind of abstraction
driver that provides interfaces to other drivers, or something like MFD that creates
devices as children of the main device, and lets those be bound to individual
drivers.

	Arnd
