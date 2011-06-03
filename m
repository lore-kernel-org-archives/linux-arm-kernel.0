From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 3 Jun 2011 10:06:00 +0100
Subject: [RFC 3/3] ARM:Tegra: Device Tree Support: Initialize from wm8903
	the device tree
In-Reply-To: <BANLkTimqf+BC=R3qRn3z3eKOjNXohGUsHA@mail.gmail.com>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232711.10362.53256.stgit@riker>
	<20110512074917.GA16250@opensource.wolfsonmicro.com>
	<BANLkTimqf+BC=R3qRn3z3eKOjNXohGUsHA@mail.gmail.com>
Message-ID: <20110603090600.GC21286@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 10:46:18AM -0600, Grant Likely wrote:

> Yeah, it's not great.  I'd really like to have a set of helper
> functions that locate and decode the data for the most common types of
> properties, but I've not sat down to focus on it and I've not seen a
> pattern I'm happy with yet.  It does need to be solved though.  The

Yes, looking at the examples you've got below it looks like you've got a
similar set of issues to the ones that I've been running into trying to
factor the register map access code out of ASoC.

> Perhaps something like:

> /* Not sure about this; in this case the return value is an error code
> so that bad properties can be detected */
> int dt_decode_cell(struct *property, int index, u32 *out_val);
> int dt_decode_string(struct *property, int index, char **out_val);
> int dt_decode_number(struct *property, int start, int len, unsigned
> long long *out_val);

> and perhaps a set of companion functions:
> int dt_get_prop_cell(struct *device_node, char *propname, int index,
> u32 *out_val);
> int dt_get_prop_string(struct *device_node, char *propname, int index,
> char **out_val);
> int dt_get_prop_number(struct *device_node, char *propname, int start,
> int len, unsigned long long *out_val);

> The first set would be used when the property pointer has already be
> obtained, and multiple datum need to be extracted.  The second would
> be most useful when only one value will be extracted from a property.
> I'm not totally happy with returning the value via a passed in pointer
> though.  Thoughts?

Yes, I think this sort of format with the error out of band from the
number is best if a little ugly, and especially the second set is
definitely going to cut down the amount of boiler plate code.  It's a
little painful having to pass a pointer to the result but otherwise the
error handling gets a bit rubbish, especially for the numbers where
there really isn't a sensible invalid value.
