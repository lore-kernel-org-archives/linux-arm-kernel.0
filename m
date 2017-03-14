From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 14 Mar 2017 19:26:35 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170312193745.636df0bf@vento.lan>
References: <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170311231456.GH21222@n2100.armlinux.org.uk>
 <20170312212904.GA7995@amd> <20170312193745.636df0bf@vento.lan>
Message-ID: <20170314182635.GA3744@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Mid-layer is difficult... there are _hundreds_ of possible
> > pipeline setups. If it should live in kernel or in userspace is a
> > question... but I don't think having it in kernel helps in any way.
> 
> Mid-layer is difficult, because we either need to feed some
> library with knowledge for all kernel drivers or we need to improve
> the MC API to provide more details.
> 
> For example, several drivers used to expose entities via the
> generic MEDIA_ENT_T_DEVNODE to represent entities of different
> types. See, for example, entities 1, 5 and 7 (and others) at:
>
> > https://mchehab.fedorapeople.org/mc-next-gen/igepv2_omap3isp.png

Well... we provide enough information, so that device-specific code
does not have to be in kernel.

There are few types of ENT_T_DEVNODE there. "ISP CCP2" does not really
provide any functionality to the user. It just has to be there,
because the pipeline needs to be connected. "ISP Preview" provides
format conversion. "ISP Resizer" provides rescaling.

I'm not sure if it ever makes sense to use "ISP Preview
output". Normally you take data for display from "ISP Resizer
output". (Would there be some power advantage from that?)

> A device-specific code could either be hardcoding the entity number
> or checking for the entity strings to add some logic to setup
> controls on those "unknown" entities, a generic app won't be able 
> to do anything with them, as it doesn't know what function(s) such
> entity provide.

Generic app should know if it wants RGGB10 data, then it can use "ISP
CCDC output", or if it wants "cooked" data suitable for display, then
it wants to use "ISP Resizer output". Once application knows what
output it wants, there's just one path through the system. So being
able to tell the ENT_T_DEVNODEs apart does not seem to be critical.

OTOH, for useful camera application, different paths are needed at
different phases.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/bf43497f/attachment.sig>
