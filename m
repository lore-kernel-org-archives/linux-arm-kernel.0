From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 09 May 2013 15:00:16 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <20130509132600.GA3200@sirena.org.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com> <518A8E6C.6070907@st.com>
 <20130509095143.GB7478@sirena.org.uk> <518B8F49.5020902@st.com>
 <20130509132600.GA3200@sirena.org.uk>
Message-ID: <518BABF0.7040201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 14:26, Mark Brown wrote:
> On Thu, May 09, 2013 at 12:58:01PM +0100, Srinivas KANDAGATLA wrote:
> 
>> Currently, we have two bits of information which come from device trees.
>> 1> The syscon bank/group definition itself.
>> 2> syscon register offsets and bits information to the drivers.
> 
>> These are the 2 things which keep changing per each SOC.
> 
>> There is no other way to pass this information to the drivers other than
>> passing them as part of their own device node and syscon node.
> 
> Sure there is, for example the drivers could have this information
> internally as part of knowing which device they're working with or they
> could take advantage of some patterns in the register map to store some
> higher level information that they use to configure.
> 
Some of layouts of the sysconf registers are totally changed for each SOC.

Looking at driver by driver maybe some drivers can take advantage of the
patterns, but Am not sure if this will be a sustainable solution for all
the drivers.

The big disadvantage of this approach is that
- Every driver has to be touched for new SOC,
- Secondly the drivers will end up having more of such information than
code over a time.

>>>  and to the extent that it is sensible it feels like something
>>> which might be useful with any device using register maps, not just
>>> syscon.
> 
>> If you think this is going to be useful for other drivers, Am happy to
>> move this out of syscon to regmap something like adding
>> of_regmap_field_claim/regmap_field_claim/regmap_field_read/regmap_field_write/regmap_field_release
>> functions.
> 
>> so any exiting drivers can still use the old syscon API to get the
>> regmap instance.
>> Alternatively they can use the new regmap APIs directly.
> 
> Well, I'd need to see the code to decide if it was sane but I do think
> that if this is a good approach it's not syscon specific.  Anything like
> this needs to be independent of DT too since not all architectures use
> DT.
In the suggested approach, the API supports, both DT and non-DT style.

for DT style user can use.
of_regmap_field_claim -> regmap_field_read -> regmap_field_write-
->regmap_field_release

and for NON-DT user can use
regmap_field_claim  -> regmap_field_read -> regmap_field_write-
->regmap_field_release


thanks,
srini


> 
