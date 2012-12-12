From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 12 Dec 2012 16:45:51 +0530
Subject: [PATCH v3 2/3] mtd: devices: elm: Add support for ELM error
 correction
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA1FA14@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-3-git-send-email-avinashphilip@ti.com>
 <50C1C6E3.5020300@ti.com>
 <518397C60809E147AF5323E0420B992E3EA1FA14@DBDE01.ent.ti.com>
Message-ID: <50C86767.60806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2012 12:13 PM, Philip, Avinash wrote:
> On Fri, Dec 07, 2012 at 16:07:23, Nori, Sekhar wrote:
>> On 11/29/2012 5:16 PM, Philip, Avinash wrote:

[...]

>>> +struct device *elm_request(enum bch_ecc bch_type)
>>> +{
>>> +	struct elm_info *info;
>>> +
>>> +	list_for_each_entry(info, &elm_devices, list) {
>>> +		if (info && info->dev) {
>>> +				info->bch_type = bch_type;
>>> +				elm_config(info);
>>> +				return info->dev;
>>> +		}
>>> +	}
>>
>> This will always return the first ELM device probed since you never
>> remove the allocated device from the list.
> 
> But now I realized that, there is no mechanism of freeing the requested
> resource.

Right. You essentially want to assign an ELM instance to work with a
given instance of GPMC and that could be done statically too. Just pass
phandle of ELM node in GPMC DT data?

> So I will add mechanism to request ELM module successfully only if ELM
> module is not requested already and add mechanism to free it, on NAND
> driver module unload (loadable module support). This way ELM driver
> can achieve multi instance support.
> 
>> I wonder why you really need a list?
> 
> The prime motivation for the list is the driver should support multi
> instances of ELM by removing global symbols.

I still think a request/free API is bit too much for something that will
turn out to be a simple 1-to-1 match anyway. Can you please look at the
phandle suggestion above? I am no DT expert, but I think that will work
for your use case.

Thanks,
Sekhar
