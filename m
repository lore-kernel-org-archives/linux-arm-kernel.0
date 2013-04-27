From: syin@broadcom.com (Sherman Yin)
Date: Sat, 27 Apr 2013 00:54:52 +0000
Subject: Adding a void * to pinctrl_pin_desc
In-Reply-To: <CACRpkdYxJOWYMfwmrEGhqgjushVjWyc=FyKMaZNLnn=0jrTs9A@mail.gmail.com>
References: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYxJOWYMfwmrEGhqgjushVjWyc=FyKMaZNLnn=0jrTs9A@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BCF54B1@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  What do you think about expanding the struct to something like this:
> >
> > struct pinctrl_pin_desc {
> >         unsigned number;
> >         const char *name;
> >         void * pin_data;
> > };
> >
> > so that drivers can optionally use pin_data to hold other pin-specific
> information?
> 
> No don't do this.
> 
> Instead:
> 
> struct foo_pin_desc {
>       struct pinctrl_pin_desc desc;
>       ....
>       /* Insert my pindata here */
> };
> 
> Then use container_of() to dereference a struct foo_pin_desc pointer from
> the
> pointer at &foodesc->desc;

Hmm, while it would be easy to create a macro to fill the static foo_pin_desc array 
in the driver, this array would not be suitable for use with pinctrl_register().  
I would have to, in the probe function, loop through the foo_pin_desc array and 
create another pinctrl_pin_desc array to use for pinctrl_desc.pins.

I think I'll just use a separate struct in the driver to keep track of other pin-specific data.

Thanks,
Sherman
