From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 1 May 2014 10:43:38 +0100
Subject: [PATCH v2] of: Keep track of populated platform devices
In-Reply-To: <20140501092635.05011C409DA@trevor.secretlab.ca>
References: <1398858529.24255.3.camel@hornet>
 <1398866717-20268-1-git-send-email-pawel.moll@arm.com>
 <CAL_JsqL=mxqEKpAsXm7Du0vEDpKk4n+dp5-DyvbuGhTA6bP5Lg@mail.gmail.com>
 <20140501092635.05011C409DA@trevor.secretlab.ca>
Message-ID: <CACxGe6usWdey1qQT2JF=7LuE62H-_xtd1QkRT9z_Tj2pxdQEjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 1, 2014 at 10:26 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, 30 Apr 2014 10:22:25 -0500, Rob Herring <robherring2@gmail.com> wrote:
>> On Wed, Apr 30, 2014 at 9:05 AM, Pawel Moll <pawel.moll@arm.com> wrote:
>> > In "Device Tree powered" systems, platform devices are usually
>> > massively populated with of_platform_populate() call, executed
>> > at some level of initcalls, either by generic architecture
>> > or by platform-specific code.
>> >
>> > There are situations though where certain devices must be
>> > created (and bound with drivers) before all the others.
>> > This presents a challenge, as devices created explicitly
>> > would be created again by of_platform_populate().
>> >
>> > This patch tries to solve that issue in a generic way,
>> > adding a "populated" flag for a DT node description.
>> > Once set, this device will never be created again via
>> > of_* API, so of_platform_populate() will skip such nodes
>> > (and its children) in a similar way to the non-available
>> > ones.
>> >
>> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>>
>> One pondering and one minor change below, otherwise:
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>>
>> > ---
>> >
>> > Changes since v1:
>> >
>> > - added of_node_check_and_set_flag()... (atomic test and set)
>> > - ... used it to atomically mark a node...
>> > - ... clearing the bit on error path.
>> >
>> >  drivers/of/platform.c | 18 +++++++++++++-----
>> >  include/linux/of.h    |  7 +++++++
>> >  2 files changed, 20 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> > index 404d1da..b33927a 100644
>> > --- a/drivers/of/platform.c
>> > +++ b/drivers/of/platform.c
>> > @@ -204,12 +204,13 @@ static struct platform_device *of_platform_device_create_pdata(
>> >  {
>> >         struct platform_device *dev;
>> >
>> > -       if (!of_device_is_available(np))
>> > +       if (!of_device_is_available(np) ||
>> > +                       of_node_check_and_set_flag(np, OF_POPULATED))
>> >                 return NULL;
>> >
>> >         dev = of_device_alloc(np, bus_id, parent);
>> >         if (!dev)
>> > -               return NULL;
>> > +               goto err_clear_flag;
>>
>> I wonder if leaving it set would be the right behavior. I can't see
>> that we would want to process the node again. But this is the
>> exceptional case, so its probably not too important and can stay like
>> this.
>
> That doesn't work in the case where drivers use of_platform_populate().
> MFD devices in particular make use of it. If the driver does not get
> cleared on removal of the devices, then all MFD users will be broken on
> driver unbind/rebind. *
>
> We really need to have the inverse of of_platform_populate which will
> remove all child and child's child devices and clear all flags and such.
> Right now moany drivers are open-coding the removal.
>
> * most drivers are somewhat broken on unbind/rebind anyway, but I don't
>   want to make it impossible for a driver to get it right.

The function shouldn't be too difficult. I would expect it to look
something like this. You'll need to check the details.

static int __of_platform_unpopulate_device(struct device *dev, void *c)
{
    if (!dev->of_node || !of_node_get_flag(dev->of_node, OF_POPULATED)
        return 0;

    // recursively remove the children too --- I'd like to find a way
to do this non-recursively
    device_for_each_child(dev, NULL, __of_platform_unpopulate_device);

    // Need to check if the device should be explicitly unbound from
it's driver before removing it. However, I think the driver core takes
care of this for us.

    // Remove based on the bus type
    switch (dev->bus) {
        case &platform_bus_type:
            platform_device_remove(to_platform_device(dev));
            break;
        case &amba_bus_type:
            amba_device_remove(to_platform_device(dev));
            break;
    }

    // Should check here if there are any other children to the
device. It is probably bad to remove a device that still has children.
Need to check what the driver core will do.
}

void of_platform_unpopulate(struct device *parent)
{
    device_for_each_child(parent, NULL, __of_platform_unpopulate_device);
}

>
>>
>> >
>> >  #if defined(CONFIG_MICROBLAZE)
>> >         dev->archdata.dma_mask = 0xffffffffUL;
>> > @@ -227,10 +228,14 @@ static struct platform_device *of_platform_device_create_pdata(
>> >
>> >         if (of_device_add(dev) != 0) {
>> >                 platform_device_put(dev);
>> > -               return NULL;
>> > +               goto err_clear_flag;
>> >         }
>> >
>> >         return dev;
>> > +
>> > +err_clear_flag:
>> > +       of_node_clear_flag(np, OF_POPULATED);
>> > +       return NULL;
>> >  }
>> >
>> >  /**
>> > @@ -262,14 +267,15 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>> >
>> >         pr_debug("Creating amba device %s\n", node->full_name);
>> >
>> > -       if (!of_device_is_available(node))
>> > +       if (!of_device_is_available(node) ||
>> > +                       of_node_check_and_set_flag(node, OF_POPULATED))
>> >                 return NULL;
>> >
>> >         dev = amba_device_alloc(NULL, 0, 0);
>> >         if (!dev) {
>> >                 pr_err("%s(): amba_device_alloc() failed for %s\n",
>> >                        __func__, node->full_name);
>> > -               return NULL;
>> > +               goto err_clear_flag;
>> >         }
>> >
>> >         /* setup generic device info */
>> > @@ -309,6 +315,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>> >
>> >  err_free:
>> >         amba_device_put(dev);
>> > +err_clear_flag:
>> > +       of_node_clear_flag(node, OF_POPULATED);
>> >         return NULL;
>> >  }
>> >  #else /* CONFIG_ARM_AMBA */
>> > diff --git a/include/linux/of.h b/include/linux/of.h
>> > index 3bad8d1..534cab8 100644
>> > --- a/include/linux/of.h
>> > +++ b/include/linux/of.h
>> > @@ -130,6 +130,12 @@ static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
>> >         return test_bit(flag, &n->_flags);
>> >  }
>> >
>> > +static inline int of_node_check_and_set_flag(struct device_node *n,
>>
>> Please keep the well known naming convention of the called function:
>> of_node_test_and_set_flag
>
