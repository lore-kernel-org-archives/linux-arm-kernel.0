From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 26 Jul 2014 13:11:50 -0700
Subject: [PATCH 4/5] [SCSI] Do not use platform_bus as a parent
In-Reply-To: <1406299616.1789.13.camel@jarvis.lan>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-4-git-send-email-pawel.moll@arm.com>
 <1406299616.1789.13.camel@jarvis.lan>
Message-ID: <20140726201150.GA21870@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 07:46:56AM -0700, James Bottomley wrote:
> On Fri, 2014-07-25 at 15:23 +0100, Pawel Moll wrote:
> > The host devices without a parent were "forcefully adopted"
> > by platform bus. This patch removes this assignment. In
> > effect the dev_dev may be NULL now, which means ISA.
> > 
> > Cc: James E.J. Bottomley <JBottomley@parallels.com>
> > Cc: linux-scsi at vger.kernel.org
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> > 
> > This patch is a part of effort to remove references to platform_bus
> > and make it static.
> > 
> > James, could you please have a look and advice if the change is
> > correct? Would you happen to know the "real reasons" behind
> > using the root platform_bus device a parent?
> 
> Yes, for DMA purposes, the parent cannot now be NULL; we'll get a panic
> in the DMA transfers if it is.  A lot of the legacy ISA device on x86
> and I thought some ARM SOC devices don't pass in the parent device, so
> we hang them off a known parent.

The "generic" platform bus device is not a "known parent".  I don't
understand the difference between just setting the parent to be NULL,
which will then have a "proper" parent pointer filled in by the driver
core when the device is registered, or faking it out here.  What is the
difference?

In the end, the device always ends up with a parent pointer, right?

thanks,

greg k-h
