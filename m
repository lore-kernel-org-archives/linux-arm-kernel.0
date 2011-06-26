From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 26 Jun 2011 17:27:13 -0600
Subject: [PATCH 2/6] serial: samsung: Add device tree support for s5pv210
	uart driver
In-Reply-To: <BANLkTimyEQfRjfbOj9ULnTcmQ3GLJnWxrw@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
	<BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
	<BANLkTi=RxEpBrALEQbBD_z6ZiEW24-wsng@mail.gmail.com>
	<BANLkTi=EVA6LckzWSFMQ07okD4gw-z5Zag@mail.gmail.com>
	<BANLkTimyEQfRjfbOj9ULnTcmQ3GLJnWxrw@mail.gmail.com>
Message-ID: <BANLkTi=7zYkrLmSEiZZ69gACaG+8k4oa_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 6:27 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> Hi Grant,
>
> On 24 June 2011 01:38, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Despite the fact that this is exactly what I asked you to write, this
>> ends up being rather ugly. ?(I originally put in the '*4' to match the
>> behaviour of the existing of_read_number(), but that was a mistake.
>> tglx also pointed it out). ?How about this instead:
>
> Your draft implementation below is suggesting that the offset should
> be in bytes and not cells and so maybe you are suggesting the new
> approach to support multi-format property values. I have changed the
> implementation as per your code below.

I've been going back and forth on this.  The offset is most flexible
if it is in bytes, but most DT data is organized into cells, so a byte
offset is a little intuitive.  For string properties, it really
doesn't make sense to have the offset in bytes because the offset
generally either cannot be known until after reading earlier values in
the property, or is meaningless without the earlier data in the case
of mixed value properties.  However, I think I've gotten caught up
into a case of feature creep on these functions and I've tried to make
them as flexible as possible.  The reality is that it will almost
never be useful to obtain only the 2nd or 3rd cell in a property.  In
those cases, the driver probably needs to parse all the data in the
property, and therefore it is better to obtain a pointer to the entire
data block for parsing instead of searching for the property over and
over again (which is what of_getprop_u32() will do).

So, I'm changing the design (for the last time, I promise!).  Rather
than trying to solve some future theoretical use case, the functions
should focus on what is actually needed immediately.  Let's drop the
u64 version, and only implement of_getprop_u32() and
of_getprop_string().  u64 can always be added at a later date if we
need it.  Also, we'll drop the offset parameter because I don't
foresee any situation where it is the right thing to do.  Something
like this (modifying your latest code):

/**
 * of_property_read_u32 - Find a property in a device node and read a
32-bit value
 * @np: ? ? ? ? ? ? ? ?device node from which the property value is to be read.
 * @propname: ? name of the property to be searched.
 * @out_value: returned value.
 *
 * Search for a property in a device node and read a 32-bit value from a
 * property. Returns -EINVAL, if the property does not exist, -ENODATA, if
 * property does not have a value, -EOVERFLOW, if the property data isn't large
 * enough, and 0 on success.
 *
 * The out_value is only modified if a valid u32 can be decoded.
 */
int of_property_read_u32(struct device_node *np, char *propname, u32 *out_value)
{
 ? ? ? struct property *prop = of_find_property(np, propname, NULL),
 ? ? ? if (!prop)
 ? ? ? ? ? ? ? return -EINVAL;
 ? ? ? if (!prop->value)
 ? ? ? ? ? ? ? return -ENODATA;
 ? ? ? if (sizeof(*out_value) > prop->length)
 ? ? ? ? ? ? ? return -EOVERFLOW;
 ? ? ? *out_value = be32_to_cpup(prop->value);
 ? ? ? return 0;
}
EXPORT_SYMBOL_GPL(of_property_read_u32);

/**
 * of_property_read_u32 - Find a property in a device node and read a
32-bit value
 * @np: ? ? ? ? ? ? ? ?device node from which the property value is to be read.
 * @propname: ? name of the property to be searched.
 * @out_string: ? ?pointer to a null terminated string, valid only if the return
 * ? ? ? ? ? ? value is 0.
 *
 * Returns a pointer to a null terminated property string value.
Returns -EINVAL,
 * if the property does not exist, -ENODATA, if property does not have a value,
 * -EILSEQ, if the string is not null-terminated within the length of
the property.
 *
 * The out_string value is only modified if a valid string can be decoded.
 */
int of_property_read_u32(struct device_node *np, char *propname, char
**out_string)
{
 ? ? ? struct property *prop = of_find_property(np, propname, NULL),
 ? ? ? if (!prop)
 ? ? ? ? ? ? ? return -EINVAL;
 ? ? ? if (!prop->value)
 ? ? ? ? ? ? ? return -ENODATA;
 ? ? ? if (strnlen(prop->value, prop->length) == prop->length)
 ? ? ? ? ? ? ? return -EILSEQ;
 ? ? ? *out_string = prop->value;
 ? ? ? return 0;
}
EXPORT_SYMBOL_GPL(of_property_read_u32);

I think overall this will be the most useful, and it can always be
expanded at a later date if more use cases show up.

g.
