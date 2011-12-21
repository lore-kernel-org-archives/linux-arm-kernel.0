From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 21 Dec 2011 07:05:40 +0100
Subject: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
In-Reply-To: <7FE21149F4667147B645348EC605788505C544@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-2-git-send-email-b29396@freescale.com>
 <201112202047.10308.marek.vasut@gmail.com>
 <7FE21149F4667147B645348EC605788505C544@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20209.30516.772365.586920@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng-B29396 writes:
> > -----Original Message-----
> > From: Marek Vasut [mailto:marek.vasut at gmail.com]
> > Sent: Wednesday, December 21, 2011 3:47 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Dong Aisheng-B29396; linux-kernel at vger.kernel.org;
> > linus.walleij at stericsson.com; s.hauer at pengutronix.de; w.sang at pengutronix.de;
> > rob.herring at calxeda.com; grant.likely at secretlab.ca; kernel at pengutronix.de;
> > cjb at laptop.org; devicetree-discuss at lists.ozlabs.org; Guo Shawn-R65073
> > Subject: Re: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
> > Importance: High
> > 
> > > From: Dong Aisheng <dong.aisheng@linaro.org>
> > >
> > > Currently most code to get child count in kernel are almost same, add
> > > a helper to implement this function for dt to use.
> > >
> > > ---
> > > Changes v1->v2:
> > >  * change the name from of_get_child_number to of_get_child_count
> > >
> > > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > ---
> > >  include/linux/of.h |   16 ++++++++++++++++
> > >  1 files changed, 16 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/include/linux/of.h b/include/linux/of.h index
> > > 4948552..d0d91a1 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -189,6 +189,17 @@ extern struct device_node
> > > *of_get_next_child(const struct device_node *node, for (child =
> > > of_get_next_child(parent, NULL); child != NULL; \
> > >  	     child = of_get_next_child(parent, child))
> > >
> > > +static inline int of_get_child_count(const struct device_node *np) {
> > > +	struct device_node *child = NULL;
> > > +	int num = 0;
> > > +
> > > +	while ((child = of_get_next_child(np, child)))
> > 
> > The assignment in this condition really looks eerie, maybe just rewrite it to do
> > { } while () ? Also, aren't the parenthesis unnecessary?
> > 
> Yes, one more parenthesis. I will remove it. Thanks.
> For the condition, it's a little trick but I guess for a helper function
> it's ok right? And there're already many places using like this.
> 
It's a bad habit to use an assignment as an expression. It always
looks like someone used '=' instead of '=='.

You should make it clear that that's not the case like:
|	   while ((child = of_get_next_child(np, child)) != NULL)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
