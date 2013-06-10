From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 22:15:16 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
 <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
Message-ID: <20130610211516.GZ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 05:01:18PM -0400, Rob Clark wrote:
> I would like to get at least some of the driver upstream.  I'd hate
> for it to have to live completely out of tree.  I can think of a
> couple possibilities.
> 
> 1) the best would be, if there was some way for the drm driver to know
> the upper/lower bounds of the carveout, then it could bounds-check
> against this.  And then in worst case, userspace can just screw up
> other "graphics" buffers

The bounds check does what?  Check that the buffer object's physical
address is within another driver's range?  Fine, but all that it's
doing is preventing it being associated with a buffer object which can
_only_ be used for _read_ access by the LCD controller.  There is no
write access to the GEM objects by anything that this DRM driver talks
to.

So all it'll do is prevent you passing rogue addresses to the LCD
controller for scanout.

And how do we get that information into the driver from other random
drivers?  Hack in random inter-driver specific APIs to do it?  Come
up with yet another different way to try and identify whether a
particular resource is a block of reserved memory for this driver's
usage as a linear region or one of the others?  How.  Really, please
think about the problem.

The benefit vs the complexity involved really isn't worth it.
