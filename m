From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 23 Jun 2011 14:08:17 -0600
Subject: [PATCH 2/6] serial: samsung: Add device tree support for s5pv210
	uart driver
In-Reply-To: <BANLkTi=RxEpBrALEQbBD_z6ZiEW24-wsng@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
	<BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
	<BANLkTi=RxEpBrALEQbBD_z6ZiEW24-wsng@mail.gmail.com>
Message-ID: <BANLkTi=EVA6LckzWSFMQ07okD4gw-z5Zag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 10:22 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
>
> I have added the functions as you have suggested and the diff is
> listed below. Could you please review the diff and suggest any changes
> required.

Thanks Thomas.  Comments below...

> ?drivers/of/base.c ?| ?129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> ?include/linux/of.h | ? 10 ++++
> ?2 files changed, 139 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 632ebae..73f0144 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -596,6 +596,135 @@ struct device_node
> *of_find_node_by_phandle(phandle handle)
> ?EXPORT_SYMBOL(of_find_node_by_phandle);
>
> ?/**
> + * of_read_property_u32 - Reads a indexed 32-bit property value
> + * @prop: ? ? ?property to read from.
> + * @offset: ? ?cell number to read.
> + * value: ? ? ?returned cell value
> + *
> + * Returns a indexed 32-bit value of a property cell, -EINVAL in case the cell
> + * does not exist
> + */
> +int of_read_property_u32(struct property *prop, u32 offset, u32 *value)
> +{
> + ? ? ? if (!prop || !prop->value)
> + ? ? ? ? ? ? ? return -EINVAL;

Hmmm, it would probably be a good idea to differentiate return code
depending on whether or not the property was found vs. the property
data not large enough.

> + ? ? ? if ((offset + 1) * 4 > prop->length)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? *value = of_read_ulong(prop->value + (offset * 4), 1);
> + ? ? ? return 0;

Despite the fact that this is exactly what I asked you to write, this
ends up being rather ugly.  (I originally put in the '*4' to match the
behaviour of the existing of_read_number(), but that was a mistake.
tglx also pointed it out).  How about this instead:

int of_read_property_u32(struct property *prop, unsigned int offset,
u32 *out_value)
{
        if (!prop || !out_value)
                return -EINVAL;
        if (!prop->value)
                return -ENODATA;
        if (offset + sizeof(*out_value) > prop->length)
                return -EOVERFLOW;
        *out_value = be32_to_cpup(prop->data + offset);
        return 0;
}
int of_read_property_u64(struct property *prop, unsigned int offset,
u64 *out_value)
{
        if (!prop || !out_value)
                return -EINVAL;
        if (!prop->value)
                return -ENODATA;
        if (offset + sizeof(*out_value) > prop->length)
                return -EOVERFLOW;
        *out_value = be32_to_cpup(prop->value + offset);
        *out_value = (*out_value << 32) | be32_to_cpup(prop->value +
offset + sizeof(u32));
        return 0;
}


> +}
> +EXPORT_SYMBOL(of_read_property_u32);

EXPORT_SYMBOL_GPL()

> +
> +/**
> + * of_getprop_u32 - Find a property in a device node and read a 32-bit value
> + * @np: ? ? ? ? ? ? ? ?device node from which the property value is to be read.
> + * @propname ? name of the property to be searched.
> + * @offset: ? ?cell number to read.
> + * @value: ? ? returned value of the cell
> + *
> + * Search for a property in a device node and read a indexed 32-bit value of a
> + * property cell. Returns the 32-bit cell value, -EINVAL in case the
> property or
> + * the indexed cell does not exist.
> + */
> +int
> +of_getprop_u32(struct device_node *np, char *propname, int offset, u32 *value)
> +{
> + ? ? ? return of_read_property_u32(of_find_property(np, propname, NULL),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? offset, value);
> +}
> +EXPORT_SYMBOL(of_getprop_u32);
> +
> +/**
> + * of_read_property_u64 - Reads a indexed 64-bit property value
> + * @prop: ? ? ?property to read from.
> + * @offset: ? ?cell number to read (each cell is 64-bits).
> + * @value: ? ? returned cell value
> + *
> + * Returns a indexed 64-bit value of a property cell, -EINVAL in case the cell
> + * does not exist
> + */
> +int of_read_property_u64(struct property *prop, int offset, u64 *value)
> +{
> + ? ? ? if (!prop || !prop->value)
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? if ((offset + 1) * 8 > prop->length)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? *value = of_read_number(prop->value + (offset * 8), 2);
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(of_read_property_u64);
> +
> +/**
> + * of_getprop_u64 - Find a property in a device node and read a 64-bit value
> + * @np: ? ? ? ? ? ? ? ?device node from which the property value is to be read.
> + * @propname ? name of the property to be searched.
> + * @offset: ? ?cell number to read (each cell is 64-bits).
> + * @value: ? ? returned value of the cell
> + *
> + * Search for a property in a device node and read a indexed 64-bit value of a
> + * property cell. Returns the 64-bit cell value, -EINVAL in case the
> property or
> + * the indexed cell does not exist.
> + */
> +int
> +of_getprop_u64(struct device_node *np, char *propname, int offset, u64 *value)
> +{
> + ? ? ? return of_read_property_u64(of_find_property(np, propname, NULL),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? offset, value);
> +}
> +EXPORT_SYMBOL(of_getprop_u64);
> +
> +/**
> + * of_read_property_string - Returns a pointer to a indexed null terminated
> + * ? ? ? ? ? ? ? ? ? ? ? ? ? ? property value string
> + * @prop: ? ? ?property to read from.
> + * @offset: ? ?index of the property string to be read.
> + * @string: ? ?pointer to a null terminated string, valid only if the return
> + * ? ? ? ? ? ? value is 0.
> + *
> + * Returns a pointer to a indexed null terminated property cell string, -EINVAL
> + * in case the cell does not exist.
> + */
> +int of_read_property_string(struct property *prop, int offset, char **string)
> +{
> + ? ? ? char *c;
> +
> + ? ? ? if (!prop || !prop->value)
> + ? ? ? ? ? ? ? return -EINVAL;

Ditto here about return values.

> +
> + ? ? ? c = (char *)prop->value;

You don't need the cast.  prop->value is a void* pointer.  However,
'c' does need to be const char.

> + ? ? ? while (offset--)
> + ? ? ? ? ? ? ? while (*c++)
> + ? ? ? ? ? ? ? ? ? ? ? ;

Rather than open coding this, you should use the string library
functions.  Something like:

        c = prop->value;
        while (offset-- && (c - prop->value) < prop->size)
                c += strlen(c) + 1;
        if ((c - prop->value) + strlen(c) >= prop->size)
                return -EOVERFLOW;
        *out_value = c;

Plus it catches more error conditions that way.

g.
