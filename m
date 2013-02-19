From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 17:47:41 +0200
Subject: [PATCH v2 0/5] Generic PHY Framework
In-Reply-To: <201302191528.17698.arnd@arndb.de>
References: <1361253198-7401-1-git-send-email-kishon@ti.com>
 <201302191434.40495.arnd@arndb.de>
 <20130219150500.GG4390@arwen.pp.htv.fi>
 <201302191528.17698.arnd@arndb.de>
Message-ID: <20130219154741.GH4390@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 03:28:17PM +0000, Arnd Bergmann wrote:
> On Tuesday 19 February 2013, Felipe Balbi wrote:
> > On Tue, Feb 19, 2013 at 02:34:40PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 19 February 2013, Felipe Balbi wrote:
> > > > On Tue, Feb 19, 2013 at 12:33:54PM +0000, Arnd Bergmann wrote:
> > > It's a fine line, but I think a phy is something that resembles a device
> > > more than an LED does. When I read patch 1, I also noticed and commented
> > > on the fact that it does use a 'class'. Now, according to Greg, we should
> > > use 'bus_type' instead of 'class' in new code. I originally disagreed with
> > > that concept, but he's the boss here and it's good if he has a vision
> > > how things should be lined out.
> > > 
> > > In practice, there is little difference between a 'bus_type' and a 'class',
> > > so just replace any instance of the former with the latter in your head
> > > when reading the code ;-)
> > 
> > it's not so simple :-) if we must use bus_type we need to introduce all
> > the device/driver matching mechanism which isn't necessary with a class.
> 
> I think the idea is to use a bus_type that has devices but no drivers
> associated with it, but I might be misremembering things.

but then drivers wouldn't probe ever, although devices would get
created, so maybe it'll work...

> > Greg, can you pitch your suggestion here ? It would be great to hear
> > your rationale behind dropping class infrastructure, couldn't find
> > anything through Google and since feature-removal-schedule.txt has been
> > removed (without adding it to feature-removal-schedule.txt, I must add
> > :-) I don't know what's the idea behind removing classes.
> 
> I believe for now, the idea is to not add any new classes, but keep
> the existing ones for compatibility. 'struct class_device' however
> was already removed and got turned into 'struct device'.

was there ever a "struct class_device".

What about struct class ?

<linux/device.h> ::

 334 struct class {
 335         const char              *name;
 336         struct module           *owner;
 337 
 338         struct class_attribute          *class_attrs;
 339         struct device_attribute         *dev_attrs;
 340         struct bin_attribute            *dev_bin_attrs;
 341         struct kobject                  *dev_kobj;
 342 
 343         int (*dev_uevent)(struct device *dev, struct kobj_uevent_env *env);
 344         char *(*devnode)(struct device *dev, umode_t *mode);
 345 
 346         void (*class_release)(struct class *class);
 347         void (*dev_release)(struct device *dev);
 348 
 349         int (*suspend)(struct device *dev, pm_message_t state);
 350         int (*resume)(struct device *dev);
 351 
 352         const struct kobj_ns_type_operations *ns_type;
 353         const void *(*namespace)(struct device *dev);
 354 
 355         const struct dev_pm_ops *pm;
 356 
 357         struct subsys_private *p;
 358 };

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/19000cc2/attachment-0001.sig>
