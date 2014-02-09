From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 9 Feb 2014 10:22:19 +0100
Subject: [PATCH RFC 0/2] drivers/base: simplify simple DT-based components
In-Reply-To: <20140207202351.GH26684@n2100.arm.linux.org.uk>
References: <cover.1391793068.git.moinejf@free.fr>
 <20140207202351.GH26684@n2100.arm.linux.org.uk>
Message-ID: <20140209102219.3ab40b5e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Feb 2014 20:23:51 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Here's my changes to the TDA998x driver to add support for the component
> helper.  The TDA998x driver retains support for the old way so that
> drivers can be transitioned.  For any one DRM "card" the transition to

I rewrote the tda998x as a simple encoder+connector (i.e. not a
slave_encoder) with your component helper, and the code is much clearer
and simpler: the DRM driver has nothing to do except to know that the
tda998x is a component and to set the possible_crtcs.

AFAIK, only the tilcdc drm driver is using the tda998x as a
slave_encoder. It does a (encoder+connector) conversion to
(slave_encoder). Then, in your changes in the TDA998x, you do a
(slave_encoder) translation to (encoder+connector).
This seems rather complicated!

I think it would be easier to use your component helper and rewrite
(remove?) tilcdc_slave.c.

> And yes, I'm thinking that maybe moving compare_of() into the component
> support so that drivers can share this generic function may be a good
> idea.

This function exists already in drivers/of/platform.c as
of_dev_node_match(). It just needs to be exported.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
