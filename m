From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Tue, 26 May 2015 20:54:08 +0300
Subject: [PATCH v5 00/11] Add simple NVMEM Framework via regmap.
In-Reply-To: <556438FF.7020105@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <E5772084-6CF5-41DE-B68B-073D9F75F0BC@konsulko.com>
 <556438FF.7020105@linaro.org>
Message-ID: <F4E26B97-E90C-4C34-A106-D44C875BCEFB@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> On May 26, 2015, at 12:12 , Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
> Hi Pantelis,
> 
> On 25/05/15 17:51, Pantelis Antoniou wrote:
>> Hi Srinivas,
>> 
>>> On May 21, 2015, at 19:42 , Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>>> 
>>> Thankyou all for providing inputs and comments on previous versions of this patchset.
>>> Here is the v5 of the patchset addressing all the issues raised as
>>> part of previous versions review.
>>> 
>> 
>>> 
>> 
>> [snip]
>> 
>> I tried to use the updated patchset with my at24 & beaglebone capemanager patches.
> Thanks for trying it out and migrating at24 to it.
> 

Don?t mention it?

>> 
>> I have a big problem with the removal of the raw of_* access APIs.
> Ok,
>> 
>> Take for instance the case where you have multiple slot accessing different EEPROMs.
>> 
>>> slots {
>>> 	slot at 0 {
>>> 		eeprom = <&cape0_data>;
>>> 	};
>>> 
>>> 	slot at 1 {
>>> 		eeprom = <&cape1_data>;
>>> 	};
>>> };
> 
> Can I ask you why should the slots be in sub-nodes?
> Do you expect to have more properties associated with each slot in future?
> Or is it just to get hold of eeprom data?
> 

For now I don?t have any more properties besides the eeprom phandle.
I?ve reworked capemanager to work with the API as it is, but it?s not very intuitive IMHO.

The problem is that I have both the baseboard and the slot eeproms in a single property list.

If more per-slot properties are required, I?ll have to add again the slots node and
then the nvmem eeprom handles would stick out like a sore thumb.

>> 
>> In that case there is no per-device node mapping; it?s a per-sub node.
>> 
>> For now I?m exporting the of_* accessors again, please consider exposing the of_* API again.
> Sure, we can export of_nvmem_cell_get symbol for usecases like this.
> 
> Having said that, I got one comment on the way the nvmem is used in your case. You should try to use nvmem_device_get() and then use nvmem_device_read() apis, These apis are for consumers like this one. The advantage of this would be you do not need read and store all data in the driver and parse them internally. Basically your ee_field_get would just do nvmem_device_read(); Does it make sense?
> 

Hmm, good idea; I?ll give it a shot.

> We can work on how to get the of_*based once you decide to move to this api.
> 
> 

OK, thanks a lot for taking the time to think about this Srinivas.

> 
> --srini
>> 

Regards

? Pantelis

>>> --
>>> 1.9.1
>>> 
>> 
>> Regards
>> 
>> ? Pantelis
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
