From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 21 Dec 2011 02:56:26 +0000
Subject: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
In-Reply-To: <4EF0D556.3030701@gmail.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-2-git-send-email-b29396@freescale.com>
 <4EF0D556.3030701@gmail.com>
Message-ID: <7FE21149F4667147B645348EC605788505C474@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: Wednesday, December 21, 2011 2:35 AM
> To: Dong Aisheng-B29396
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at stericsson.com; s.hauer at pengutronix.de; Guo Shawn-R65073;
> kernel at pengutronix.de; grant.likely at secretlab.ca; devicetree-
> discuss at lists.ozlabs.org; cjb at laptop.org; w.sang at pengutronix.de
> Subject: Re: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
> Importance: High
> 
> On 12/20/2011 11:40 AM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > Currently most code to get child count in kernel are almost same, add
> > a helper to implement this function for dt to use.
> >
> > ---
> > Changes v1->v2:
> >  * change the name from of_get_child_number to of_get_child_count
> >
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> 
> I assume you want this to go in with the rest of the series? If not, let me know.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Rob
>
Yes, since other patches in this series depend on this patch.
Thanks for the review.

Regards
Dong Aisheng 
> > ---
> >  include/linux/of.h |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h index
> > 4948552..d0d91a1 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -189,6 +189,17 @@ extern struct device_node *of_get_next_child(const struct
> device_node *node,
> >  	for (child = of_get_next_child(parent, NULL); child != NULL; \
> >  	     child = of_get_next_child(parent, child))
> >
> > +static inline int of_get_child_count(const struct device_node *np) {
> > +	struct device_node *child = NULL;
> > +	int num = 0;
> > +
> > +	while ((child = of_get_next_child(np, child)))
> > +		num++;
> > +
> > +	return num;
> > +}
> > +
> >  extern struct device_node *of_find_node_with_property(
> >  	struct device_node *from, const char *prop_name);  #define
> > for_each_node_with_property(dn, prop_name) \ @@ -262,6 +273,11 @@
> > static inline bool of_have_populated_dt(void)  #define
> > for_each_child_of_node(parent, child) \
> >  	while (0)
> >
> > +static inline int of_get_child_count(const struct device_node *np) {
> > +	return -ENOSYS;
> > +}
> > +
> >  static inline int of_device_is_compatible(const struct device_node *device,
> >  					  const char *name)
> >  {
