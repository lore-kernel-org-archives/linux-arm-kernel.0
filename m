From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 2 Jun 2011 10:46:18 -0600
Subject: [RFC 3/3] ARM:Tegra: Device Tree Support: Initialize from wm8903
	the device tree
In-Reply-To: <20110512074917.GA16250@opensource.wolfsonmicro.com>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232711.10362.53256.stgit@riker>
	<20110512074917.GA16250@opensource.wolfsonmicro.com>
Message-ID: <BANLkTimqf+BC=R3qRn3z3eKOjNXohGUsHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 1:49 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 11, 2011 at 04:27:18PM -0700, John Bonesio wrote:
>> - ? ? if (pdata && pdata->gpio_base)
>> + ? ? wm8903->gpio_chip.base = -1;
>> + ? ? if (pdata && pdata->gpio_base) {
>> ? ? ? ? ? ? ? wm8903->gpio_chip.base = pdata->gpio_base;
>> - ? ? else
>> - ? ? ? ? ? ? wm8903->gpio_chip.base = -1;
>> + ? ? } else if (codec->dev->of_node) {
>> + ? ? ? ? ? ? prop = of_get_property(codec->dev->of_node, "gpio-base", NULL);
>> + ? ? ? ? ? ? if (prop)
>> + ? ? ? ? ? ? ? ? ? ? wm8903->gpio_chip.base = be32_to_cpup(prop);
>> + ? ? }
>
> We have to do manual endianness conversions to read from the device
> tree? ?Oh, well.

Yeah, it's not great.  I'd really like to have a set of helper
functions that locate and decode the data for the most common types of
properties, but I've not sat down to focus on it and I've not seen a
pattern I'm happy with yet.  It does need to be solved though.  The
issue is I want something that handles fetching the property, error
checking and decoding, all in a consistent way so that it actually
reduces the amount of parsing code required.

Perhaps something like:

/* Not sure about this; in this case the return value is an error code
so that bad properties can be detected */
int dt_decode_cell(struct *property, int index, u32 *out_val);
int dt_decode_string(struct *property, int index, char **out_val);
int dt_decode_number(struct *property, int start, int len, unsigned
long long *out_val);

and perhaps a set of companion functions:
int dt_get_prop_cell(struct *device_node, char *propname, int index,
u32 *out_val);
int dt_get_prop_string(struct *device_node, char *propname, int index,
char **out_val);
int dt_get_prop_number(struct *device_node, char *propname, int start,
int len, unsigned long long *out_val);

The first set would be used when the property pointer has already be
obtained, and multiple datum need to be extracted.  The second would
be most useful when only one value will be extracted from a property.
I'm not totally happy with returning the value via a passed in pointer
though.  Thoughts?

g.
