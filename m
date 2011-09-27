From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 27 Sep 2011 18:04:59 +0200
Subject: [PATCH v3 2/2] OMAP: omap_device: Add a method to build an
	omap_device from a DT node
In-Reply-To: <20110927014632.GB20588@ponder.secretlab.ca>
References: <1316724745-24896-1-git-send-email-b-cousson@ti.com>
	<1316724745-24896-3-git-send-email-b-cousson@ti.com>
	<20110927014632.GB20588@ponder.secretlab.ca>
Message-ID: <4E81F42B.5070806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/27/2011 3:46 AM, Grant Likely wrote:
> On Thu, Sep 22, 2011 at 10:52:25PM +0200, Benoit Cousson wrote:

[...]

>> +Required properties:
>> +- compatible: Every devices present in OMAP SoC should be in the
>> +  form: "ti,XXX"
>> +- ti,hwmods: list of hwmods attached to a device. Must contain at least
>> +  one hwmod.
> 
> Nit: This should specify that ti,hwmods is a list of hwmod names
> (ascii strings), and that the hwmod names come from the OMAP
> documentation.  Don't respin the patch over this though, just do a
> follow-up patch.

OK, but since you asked later to remove the DT helpers, I will have to resend it anyway:-)

[...]

>> +/*
>> + * XXX: DT helper functions that should be replaced by more generic
>> + * API introduced by Stephen Warren once they'll be in mainline.
>> + */
>> +static int _dt_count_property_string(const char *prop, int len)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlen(prop) + 1;
>> +		if (*prop != 0)
>> +			i++;
>> +	}
>> +	return i;
>> +}
>> +
>> +static int _dt_get_property(const char *prop, int len, int index, char *output,
>> +			    int size)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlcpy(output, prop, size) + 1;
>> +		if (*prop != 0) {
>> +			if (i++ == index)
>> +				return 0;
>> +		}
>> +	}
>> +	return -ENODEV;
>> +}
> 
> Don't merge this.  Kevin or I could put Stephen's patch into a separate
> branch that both Kevin and I pull.  There's no need to merge temporary
> code.
> 
> That said, I just looked at Stephen's iterator, and even without it
> this particular hunk shouldn't be merged here.  A
> of_property_count_strings() function is useful in and of itself, and
> of_property_read_string() could be extended with an
> of_property_read_string_index() version.  Both changes should be in
> the common drivers/of code, and you can easily do them.

I'm fine with that, but in that case, and in order to be consistent with the existing of_property_read_string, I should include the find_property in these functions. Whereas in my case, it was supposed to be done before.

Please find below a first version of this patch.

Regards,
Benoit

---
