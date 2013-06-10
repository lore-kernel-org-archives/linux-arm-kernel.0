From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Jun 2013 18:49:06 -0400
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610211516.GZ18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
 <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
 <20130610211516.GZ18614@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 5:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 10, 2013 at 05:01:18PM -0400, Rob Clark wrote:
>> I would like to get at least some of the driver upstream.  I'd hate
>> for it to have to live completely out of tree.  I can think of a
>> couple possibilities.
>>
>> 1) the best would be, if there was some way for the drm driver to know
>> the upper/lower bounds of the carveout, then it could bounds-check
>> against this.  And then in worst case, userspace can just screw up
>> other "graphics" buffers
>
> The bounds check does what?  Check that the buffer object's physical
> address is within another driver's range?  Fine, but all that it's
> doing is preventing it being associated with a buffer object which can
> _only_ be used for _read_ access by the LCD controller.  There is no
> write access to the GEM objects by anything that this DRM driver talks
> to.

I was assuming there was a global carveout pool, so it would be just
one upper/lower check.  But from what you said and looking at the
allocation code in your driver, I guess this is not actually the case.

> So all it'll do is prevent you passing rogue addresses to the LCD
> controller for scanout.
>
> And how do we get that information into the driver from other random
> drivers?  Hack in random inter-driver specific APIs to do it?  Come
> up with yet another different way to try and identify whether a
> particular resource is a block of reserved memory for this driver's
> usage as a linear region or one of the others?  How.  Really, please
> think about the problem.
>
> The benefit vs the complexity involved really isn't worth it.

yeah, that suggestion was based on a wrong assumption about how the
phys contig buffers are allocated and passed.  So disregard it.

I guess in the short term, the best I can think is keep those phys
ioctls as a small patch on top of the upstream driver.  It is ok to
leave place-holder ioctl #'s in the upstream driver so that the ioctl
#'s don't shift when you rebase.  And then try to get the vendor to
add support for dmabuf so that the patch on top of upstream can
eventually be dropped.  Maybe someone else has a better suggestion,
but I don't think we can merge those phys ioctls upstream, and I'd
really hate to 'throw the baby out with the bathwater' in this case
and not at least get the modesetting part of the driver merged.

BR,
-R
