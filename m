From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 18 Jan 2017 01:34:22 +0200
Subject: [PATCH net-next v4 05/10] drivers: base: Add
 device_find_in_class_name()
In-Reply-To: <20170117232152.1661-6-f.fainelli@gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170117232152.1661-6-f.fainelli@gmail.com>
Message-ID: <CAHp75VfE8t+_2Yu1NYMErKopnCNwFakO6pyDRmqAU-ZsGuyvmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 1:21 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Add a helper function to lookup a device reference given a class name.
> This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
> make it more generic.


> +static int device_class_name_match(struct device *dev, void *class)

And why not const char *class?

> +{
> +       if (dev->class != NULL && !strcmp(dev->class->name, class))

if (dev->class && ...)

> +               return 1;
> +
> +       return 0;

Perhaps even one line:

return dev->class && ...;

> +}
> +
> +/**
> + * device_find_in_class_name - device iterator for locating a particular device
> + * within the specified class name
> + * @parent: parent struct device
> + * @class_name: Class name to match against
> + *
> + * This function returns 1 if the device (specified by @parent), or one of its child
> + * is in the class whose name is specified by @class_name. Returns 0 otherwise.
> + *
> + * NOTE: you will need to drop the reference with put_device() after use.
> + */
> +struct device *device_find_in_class_name(struct device *parent,
> +                                        char *class_name)

const char *class_name

> +{
> +       if (device_class_name_match(parent, class_name)) {
> +               get_device(parent);
> +               return parent;
> +       }
> +
> +       return device_find_child(parent, class_name, device_class_name_match);
> +}
> +EXPORT_SYMBOL_GPL(device_find_in_class_name);

> +extern struct device *device_find_in_class_name(struct device *parent,
> +                                               char *class_name);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
