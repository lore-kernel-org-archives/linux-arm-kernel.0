From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 29 Aug 2013 12:28:43 +0100
Subject: [PATCH v2] ARM: xen: only set pm function ptrs for Xen guests
In-Reply-To: <CAPnVf8xczxPDucWMPcJ-Rre9uBXWAtHA0NkT62xu5ZghvpsFRg@mail.gmail.com>
References: <1377714003-22096-1-git-send-email-robherring2@gmail.com>
 <CAPnVf8xczxPDucWMPcJ-Rre9uBXWAtHA0NkT62xu5ZghvpsFRg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1308291227420.6397@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Aug 2013, Julien Grall wrote:
> On 28 August 2013 19:20, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > xen_pm_init was unconditionally setting pm_power_off and arm_pm_restart
> > function pointers. This breaks multi-platform kernels. Make this
> > conditional on running as a Xen guest and make it a late_initcall to
> > ensure it is setup after platform code for Dom0.
> >
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> >  arch/arm/xen/enlighten.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index 8a6295c..13a7d1f 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -273,12 +273,15 @@ core_initcall(xen_guest_init);
> >
> >  static int __init xen_pm_init(void)
> >  {
> > +       if (!of_find_compatible_node(NULL, NULL, "xen,xen"))
> > +               return -ENODEV;
> > +
> 
> You should use the macro xen_domain() to check if we are running
> in a Xen guest.

Yep.
Aside from that the patch is fine. Thanks for spotting and fixing this
issue.
I'll add the next version of this patch to the xen queue.
