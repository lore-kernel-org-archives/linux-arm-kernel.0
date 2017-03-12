From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sun, 12 Mar 2017 19:37:56 -0300
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170312212904.GA7995@amd>
References: <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170311231456.GH21222@n2100.armlinux.org.uk>
 <20170312212904.GA7995@amd>
Message-ID: <20170312193745.636df0bf@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Sun, 12 Mar 2017 22:29:04 +0100
Pavel Machek <pavel@ucw.cz> escreveu:

> Mid-layer is difficult... there are _hundreds_ of possible
> pipeline setups. If it should live in kernel or in userspace is a
> question... but I don't think having it in kernel helps in any way.

Mid-layer is difficult, because we either need to feed some
library with knowledge for all kernel drivers or we need to improve
the MC API to provide more details.

For example, several drivers used to expose entities via the
generic MEDIA_ENT_T_DEVNODE to represent entities of different
types. See, for example, entities 1, 5 and 7 (and others) at:
	https://mchehab.fedorapeople.org/mc-next-gen/igepv2_omap3isp.png

A device-specific code could either be hardcoding the entity number
or checking for the entity strings to add some logic to setup
controls on those "unknown" entities, a generic app won't be able 
to do anything with them, as it doesn't know what function(s) such
entity provide.

Also, on some devices, like the analog TV decoder at:
	https://mchehab.fedorapeople.org/mc-next-gen/au0828_test/mc_nextgen_test-output.png

May have pads with different signals on their output. In such
case, pads 1 and 2 provide video, while pad 3 provides audio using a
different type of output.

The application needs to know such kind of things in order to be able
to properly setup the pipeline [1].

[1] this specific device has a fixed pipeline, but I'm aware of SoC with
flexible pipelines that have this kind of issue (nobody upstreamed the
V4L part of those devices yet).

Thanks,
Mauro
