From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 9 Mar 2018 23:18:34 +0100
Subject: Nokia N900: refcount_t underflow, use after free
In-Reply-To: <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com>
 <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
Message-ID: <20180309221834.GA15476@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-03-09 16:13:36, Suman Anna wrote:
> On 03/09/2018 06:08 AM, Robin Murphy wrote:
> > On 08/03/18 18:50, Pavel Machek wrote:
> >> Hi!
> >>
> >>>> * Pavel Machek <pavel@ucw.cz> [180308 14:31]:
> >>>>> Hi!
> >>>>>
> >>>>> I'm getting this warning... Has anyone seen/debugged that before?
> >>>>> Unfortunately the backtrace does not seem to be too useful :-(.
> >>>>
> >>>> Adding Suman to Cc, as it points to arm_iommu_release_mapping().
> >>>
> >>> Hmm, we need to find out if the failure paths in isp_probe() are
> >>> mismatched, or if this is coming from some mismatch between the OMAP
> >>> IOMMU driver and the DMA plumbing. AFAIK, the cleanup paths in this
> >>
> >> Well, camera only started to work on N900 pretty recently. Let me add
> >> some debug printks...
> >>
> >> Camera does not work in 4.16.0-rc4-next-20180308-dirty.
> >>
> >> I see this. It looks like problem in isp error paths, indeed:
> > 
> > Well, there certainly seems to be an obvious bug wherein
> > isp_detach_iommu() just releases the mapping directly without calling
> > arm_iommu_detach_device() to balance the equivalent attach. That can't
> > be helping.
> 
> Indeed, I have been able to reproduce the same warning using a
> standalone test module, and the missing arm_iommu_detach_device() is
> causing the warning after probe (during failure path) or during
> remove.

Ok do you have an idea how to fix the isp error paths? Untested patch
would be fine... But it seems that you know what needs to be fixed and
I don't.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/d5d56f16/attachment.sig>
