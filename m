From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 09 Mar 2015 07:13:17 +0000
Subject: [PATCH v1 1/6] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <20150307150035.GN28806@sirena.org.uk>
References: <1425548685-12887-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1425548741-12930-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150307150035.GN28806@sirena.org.uk>
Message-ID: <54FD480D.40604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/03/15 15:00, Mark Brown wrote:
> On Thu, Mar 05, 2015 at 09:45:41AM +0000, Srinivas Kandagatla wrote:
>
>> +
>> +	return eeprom;
>> +}
>> +EXPORT_SYMBOL(eeprom_register);
>
> This framework uses regmap but regmap is EXPORT_SYMBOL_GPL() and this is
> using EXPORT_SYMBOL().
>
Thanks for spotting this, I will fix this in next version.

>> +int eeprom_unregister(struct eeprom_device *eeprom)
>> +{
>> +	mutex_lock(&eeprom_mutex);
>> +	if (atomic_read(&eeprom->users)) {
>> +		mutex_unlock(&eeprom_mutex);
>
> Atomic reads and a mutex - isn't the mutex enough?  Atomics are
> generally a recipie for bugs due to the complexity in using them.
Yes, you are right as long as we protect users variable with mutex, 
using atomic is really redundant, will fix it in next version.
>
