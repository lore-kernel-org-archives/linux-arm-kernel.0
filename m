From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 8 Sep 2015 12:30:52 -0700
Subject: [PATCH 1/3] sysfs: Fix is_visible() support for binary attributes
In-Reply-To: <20150908191002.GB10156@kroah.com>
References: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1441714066-5599-2-git-send-email-emilio.lopez@collabora.co.uk>
 <20150908153013.GA6758@roeck-us.net>
 <20150908191002.GB10156@kroah.com>
Message-ID: <20150908193052.GA11106@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 12:10:02PM -0700, Greg KH wrote:
> On Tue, Sep 08, 2015 at 08:30:13AM -0700, Guenter Roeck wrote:
> > Emilio,
> > 
> > On Tue, Sep 08, 2015 at 09:07:44AM -0300, Emilio L?pez wrote:
> > > According to the sysfs header file:
> > > 
> > >     "The returned value will replace static permissions defined in
> > >      struct attribute or struct bin_attribute."
> > > 
> > > but this isn't the case, as is_visible is only called on
> > > struct attribute only. This patch adds the code paths required
> > > to support is_visible() on binary attributes.
> > > 
> > > Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> > > ---
> > >  fs/sysfs/group.c | 22 ++++++++++++++++++----
> > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > > index 39a0199..eb6996a 100644
> > > --- a/fs/sysfs/group.c
> > > +++ b/fs/sysfs/group.c
> > > @@ -37,10 +37,10 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> > >  {
> > >  	struct attribute *const *attr;
> > >  	struct bin_attribute *const *bin_attr;
> > > -	int error = 0, i;
> > > +	int error = 0, i = 0;
> > >  
> > >  	if (grp->attrs) {
> > > -		for (i = 0, attr = grp->attrs; *attr && !error; i++, attr++) {
> > > +		for (attr = grp->attrs; *attr && !error; i++, attr++) {
> > >  			umode_t mode = (*attr)->mode;
> > >  
> > >  			/*
> > > @@ -73,13 +73,27 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> > >  	}
> > >  
> > >  	if (grp->bin_attrs) {
> > > -		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
> > > +		for (bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
> > > +			umode_t mode = (*bin_attr)->attr.mode;
> > > +
> > >  			if (update)
> > >  				kernfs_remove_by_name(parent,
> > >  						(*bin_attr)->attr.name);
> > > +			if (grp->is_visible) {
> > > +				mode = grp->is_visible(kobj,
> > > +						       &(*bin_attr)->attr, i);
> > 
> > With this, if 'n' is the number of non-binary attributes,
> > 
> > for i < n:
> > 	The index passed to is_visible points to a non-binary attribute.
> > for i >= n:
> > 	The index passed to is_visible points to the (index - n)th binary
> > 	attribute.
> > 
> > Unless I am missing something, this is not explained anywhere, but it is
> > not entirely trivial to understand. I think it should be documented.
> 
> I agree, make i the number of the bin attribute and that should solve
> this issue.
> 
No, that would conflict with the "normal" use of is_visible for non-binary
attributes, and make the index all but useless, since the is_visible function
would have to search through all the attributes anyway to figure out which one
is being checked.

Guenter
