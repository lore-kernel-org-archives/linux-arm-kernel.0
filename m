From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 May 2015 10:12:31 +0100
Subject: [PATCH v5 00/11] Add simple NVMEM Framework via regmap.
In-Reply-To: <E5772084-6CF5-41DE-B68B-073D9F75F0BC@konsulko.com>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <E5772084-6CF5-41DE-B68B-073D9F75F0BC@konsulko.com>
Message-ID: <556438FF.7020105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pantelis,

On 25/05/15 17:51, Pantelis Antoniou wrote:
> Hi Srinivas,
>
>> On May 21, 2015, at 19:42 , Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>>
>> Thankyou all for providing inputs and comments on previous versions of this patchset.
>> Here is the v5 of the patchset addressing all the issues raised as
>> part of previous versions review.
>>
>
>>
>
> [snip]
>
> I tried to use the updated patchset with my at24 & beaglebone capemanager patches.
Thanks for trying it out and migrating at24 to it.

>
> I have a big problem with the removal of the raw of_* access APIs.
Ok,
>
> Take for instance the case where you have multiple slot accessing different EEPROMs.
>
>> slots {
>> 	slot at 0 {
>> 		eeprom = <&cape0_data>;
>> 	};
>>
>> 	slot at 1 {
>> 		eeprom = <&cape1_data>;
>> 	};
>> };

Can I ask you why should the slots be in sub-nodes?
Do you expect to have more properties associated with each slot in future?
Or is it just to get hold of eeprom data?

>
> In that case there is no per-device node mapping; it?s a per-sub node.
>
> For now I?m exporting the of_* accessors again, please consider exposing the of_* API again.
Sure, we can export of_nvmem_cell_get symbol for usecases like this.

Having said that, I got one comment on the way the nvmem is used in your 
case. You should try to use nvmem_device_get() and then use 
nvmem_device_read() apis, These apis are for consumers like this one. 
The advantage of this would be you do not need read and store all data 
in the driver and parse them internally. Basically your ee_field_get 
would just do nvmem_device_read(); Does it make sense?

We can work on how to get the of_*based once you decide to move to this api.



--srini
>
>> --
>> 1.9.1
>>
>
> Regards
>
> ? Pantelis
>
