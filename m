From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Mon, 20 Jun 2016 16:08:47 +0300
Subject: [linux-sunxi] Auto-detecting touchscreen controller and dealing
 with hw configuration differences on q8 tablets
In-Reply-To: <b16c2b42-5628-c0b9-6486-f8a4728a0a33@redhat.com>
References: <bc978925-46a4-c069-8793-903a87ec70b8@redhat.com>
 <5E70AD96-4E8E-4430-AF99-0AA0FCF5F8E7@konsulko.com>
 <17e69e9e-06be-dc4f-cd47-152f6290d2ec@redhat.com>
 <7FA186CB-9BF2-47A6-835C-06AD63CF8837@konsulko.com>
 <b16c2b42-5628-c0b9-6486-f8a4728a0a33@redhat.com>
Message-ID: <19098CD8-6BC1-4FFE-858F-A6DF4BE655D5@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

> On Jun 20, 2016, at 16:02 , Hans de Goede <hdegoede@redhat.com> wrote:
> 
> Hi,
> 
> On 20-06-16 14:22, Pantelis Antoniou wrote:
>> Hi Hans,
>> 
>>> On Jun 20, 2016, at 14:03 , Hans de Goede <hdegoede@redhat.com> wrote:
>>> 
>>> Hi,
>>> 
>>> On 20-06-16 11:27, Pantelis Antoniou wrote:
> 
> <snip>
> 
>>>> Yes, it?s quite possible. You can even have stacked overlays.
>>> 
>>> Ok, is there any example code how to change an overlay before applying it out there,
>>> or if not can you point to the functions to use to do this ?
>>> 
>> 
>> The canonical place for all the dynamic DT stuff is
>> 
>> https://github.com/pantoniou/linux-beagle-track-mainline/tree/bbb-overlays
>> 
>> The beaglebone cape manager is here.
>> 
>> https://github.com/pantoniou/linux-beagle-track-mainline/commit/5028d1ed3beb8c75b28fce37b1bb5ee551b2ae9e
>> 
>>> Specifically my plan is to:
>>> 
>>> 1) Have a single overlay for q8 tablets with gsl1680 tablets
>>> 
>>> 2) Write an in kernel overlay manager which when it detects a gsl1680 touchscreen
>>> will pick a best-default firmware-file + matching resolution + swap-x-y based on
>>> which SoC (A13/A23/A33) the tablet is based on as well as the gsl1680's chip-id
>>> and will then "patch" this info into the overlay before applying it. This
>>> means being able to set / modify several string, int and bool dt properties.
>>> 
>>> 3) Offer a kernel-module option for the overlaymanager which will allows
>>> overriding the defaults for the firmware-filename, etc. This is also
>>> why I want to go with the patch approach instead of having multiple
>>> dt-overlay files.
>>> 
>> 
>> Hmm, your problem appears to be simpler. You already know all the possible
>> parts that your touchscreen/video/thingy is going to use.
>> 
>> You don?t have to use an overlay then. Overlays are built on top of
>> changesets.
>> 
>> For example, let?s say that you have various options for a touchscreen out
>> of a finite set.
>> 
>> You just put the basic configuration for each in a disable node and your
>> manager only needs to update the properties and set the status to enabled
>> for it to be enabled.
>> 
>> For instance let?s say you have an option of two devices (only one of them
>> being present).
>> 
>> devA {
>> 	status = ?disabled?;
>> 	compatible = ?foo,A?;
>> };
>> 
>> devB {
>> 	status = ?disabled?;
>> 	compatible = ?bar,B?;
>> };
>> 
>> Your manager can simply use a changeset to enable A and put a property there
>> (example done using the extended helper API for clarity).
>> 
>> 	struct of_changeset cset;
>> 	struct device_node *np = of_find_node_by_path(?/devA?);
>> 
>> 	of_changeset_init(&cset);
>> 	of_changeset_add_property_bool(&cset, np, ?invert-x?);
>> 	of_changeset_update_property_string(&cset, np, ?status?, ?okay?);
>> 
>> 	of_changeset_apply(&cset);
> 
> Cool that looks quite nice / easy. 2 questions on the above:
> 
> 1) Is the functionality needed by the above snippet in mainline ?

Changesets are in mainline; The extended API for the example above is not.
So you?ll have to create the property/ies to pass to the bare 
of_changeset_update_property/of_changeset_add_property methods.

Dig into the bbb-overlays branch and you?ll figure it out.

> 2) I assume you'vc e left out error handling from the above
> for simplicity. I assume that of_changeset_apply() needs some
> error return checking ? What about the others ?

Error checking is removed for clarity. On error you simply
destroy the changeset. Changes to the tree apply atomically
or not at all.

> 
> And one new question, the overlay manager will need access
> to (several) i2c busses, preferably I can pass in a phandle
> to these in devicetree, do you have any experience with /
> examples of doing such a thing ?

No problems there. There?s an I2C API to get the bus from a phandle.

> 
> Regards,
> 
> Hans

Regards

? Pantelis
