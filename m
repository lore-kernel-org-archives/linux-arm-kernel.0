From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Oct 2016 16:03:42 +0200
Subject: [RFC PATCH 1/5] of: introduce the overlay manager
In-Reply-To: <CANLsYkyszsn2TLYhUjHMt2ZnEUmE9eSc71W2KWBL0fWhh3PPBw@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <20161026145756.21689-2-antoine.tenart@free-electrons.com>
 <CANLsYkyszsn2TLYhUjHMt2ZnEUmE9eSc71W2KWBL0fWhh3PPBw@mail.gmail.com>
Message-ID: <20161027140342.kidk4gqxwbtphrbs@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mathieu,

On Wed, Oct 26, 2016 at 10:29:59AM -0600, Mathieu Poirier wrote:
> 
> Please find my comments below.

Thanks for the comments. I expected more distant reviews, on the overall
architecture to know if this could fit the needs of others. But anyway
your comments are helpful if we ever decide to go with an overlay
manager like this one.

> On 26 October 2016 at 08:57, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> > +
> > +/*
> > + * overlay_mgr_register_format()
> > + *
> > + * Adds a new format candidate to the list of supported formats. The registered
> > + * formats are used to parse the headers stored on the dips.
> > + */
> > +int overlay_mgr_register_format(struct overlay_mgr_format *candidate)
> > +{
> > +       struct overlay_mgr_format *format;
> > +       int err = 0;
> > +
> > +       spin_lock(&overlay_mgr_format_lock);
> > +
> > +       /* Check if the format is already registered */
> > +       list_for_each_entry(format, &overlay_mgr_formats, list) {
> > +               if (!strcpy(format->name, candidate->name)) {
> 
> This function is public to the rest of the kernel - limiting the
> lenght of ->name and using strncpy() is probably a good idea.

I totally agree. This was in fact something I wanted to do.

> > +
> > +/*
> > + * overlay_mgr_parse()
> > + *
> > + * Parse raw data with registered format parsers. Fills the candidate string if
> > + * one parser understood the raw data format.
> > + */
> > +int overlay_mgr_parse(struct device *dev, void *data, char ***candidates,
> 
> I'm pretty sure there is another way to proceed than using 3 levels of
> references.  It makes the code hard to read and a prime candidate for
> errors.

Sure. I guess we could allocate an array of fixed-length strings which
would be less flexible but I don't think we need something that flexible
here.

> 
> > +
> > +               format->parse(dev, data, candidates, n);
> 
> ->parse() returns an error code.  It is probably a good idea to check
> it.  If it isn't needed then a comment explaining why it is the case
> would be appreciated.

So the point of the parse function is to determine if the data read from
a source is a compatible header of a given format. Returning an error
doesn't mean the header won't be recognized by another one.

We could maybe handle this better, by returning an error iif different
that -EINVAL. Or we could have one function to check the compatibility
and one to parse it, if compatible.

> > +static int _overlay_mgr_apply(struct device *dev, char *candidate)
> > +{
> > +       struct overlay_mgr_overlay *overlay;
> > +       struct device_node *node;
> > +       const struct firmware *firmware;
> > +       char *firmware_name;
> > +       int err = 0;
> > +
> > +       spin_lock(&overlay_mgr_lock);
> > +
> > +       list_for_each_entry(overlay, &overlay_mgr_overlays, list) {
> > +               if (!strcmp(overlay->name, candidate)) {
> > +                       dev_err(dev, "overlay already loaded\n");
> > +                       err = -EEXIST;
> > +                       goto err_lock;
> > +               }
> > +       }
> > +
> > +       overlay = devm_kzalloc(dev, sizeof(*overlay), GFP_KERNEL);
> 
> Function devm_kzalloc() can sleep but you're holding a spinlock - I'm
> surprised the kernel didn't complain here.  Allocate the memory before
> holding the lock.  If the overly is already loaded simply free it on
> the error path.

Right.

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/ca58ff75/attachment.sig>
