From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 3 Feb 2015 13:03:03 +0100
Subject: [PATCH 03/14] drm/bridge: make bridge registration independent
 of drm flow
In-Reply-To: <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-4-git-send-email-ajaykumar.rs@samsung.com>
 <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
Message-ID: <20150203120301.GB15068@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:37:19AM -0500, Rob Clark wrote:
> On Tue, Jan 20, 2015 at 11:38 AM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> > Currently, third party bridge drivers(ptn3460) are dependent
> > on the corresponding encoder driver init, since bridge driver
> > needs a drm_device pointer to finish drm initializations.
> > The encoder driver passes the drm_device pointer to the
> > bridge driver. Because of this dependency, third party drivers
> > like ptn3460 doesn't adhere to the driver model.
> >
> > In this patch, we reframe the bridge registration framework
> > so that bridge initialization is split into 2 steps, and
> > bridge registration happens independent of drm flow:
> > --Step 1: gather all the bridge settings independent of drm and
> >           add the bridge onto a global list of bridges.
> > --Step 2: when the encoder driver is probed, call drm_bridge_attach
> >           for the corresponding bridge so that the bridge receives
> >           drm_device pointer and continues with connector and other
> >           drm initializations.
> >
> > The old set of bridge helpers are removed, and a set of new helpers
> > are added to accomplish the 2 step initialization.
> >
> > The bridge devices register themselves onto global list of bridges
> > when they get probed by calling "drm_bridge_add".
> >
> > The parent encoder driver waits till the bridge is available
> > in the lookup table(by calling "of_drm_find_bridge") and then
> > continues with its initialization.
> >
> > The encoder driver should also call "drm_bridge_attach" to pass
> > on the drm_device to the bridge object.
> >
> > drm_bridge_attach inturn calls "bridge->funcs->attach" so that
> > bridge can continue with drm related initializations.
> 
> ok, so I probably should have had a closer look at this before it
> landed in drm-next, so if it is too late to revert (and deal w/
> untangling subsequent patches that depend on this) some of these
> issues we'll just have to fix with follow-on patches.
> 
> 1) needs headerdoc for new fxns in drm_bridge.c, and needs to be added
> in drm.tmpl

drm_panel.c is missing kerneldoc as well, though I have a local patch to
add it. If nobody else steps up I'll take this.

> 2) as far as I can tell, the new approach to cleaning up bridge
> objects is to just let them leak !?!

With this series bridges are no longer part of the DRM device and it's
the driver that provides them that needs to free them (in ->remove()).
It's not a completely perfect solution yet, but with the registry patch
that I proposed a while back all the remaining issues should go away.
Now if I could get anybody to look at that patch...

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/443d0324/attachment.sig>
