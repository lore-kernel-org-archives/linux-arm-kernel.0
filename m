From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 16:09:08 +0100
Subject: [PATCH 1/5] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <20120731145614.GZ4468@opensource.wolfsonmicro.com>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
 <20120731145614.GZ4468@opensource.wolfsonmicro.com>
Message-ID: <5017F514.4030106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 15:56, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 03:45:40PM +0100, Lee Jones wrote:
>> If a list of widgets is provided and one of them fails to be added as
>> a control, the present semantics fail all subsequent widgets. A better
>> solution would be to only fail that widget, but pursue in attempting
>> to add the rest of the list.
>
> To reiterate, this is in *no* way urgent or even a bug fix.

It fixes sound in our driver.

Without this the card failes to instantiate.

>>   			dev_err(dapm->dev,
>>   				"ASoC: Failed to create DAPM control %s\n",
>>   				widget->name);
>> -			ret = -ENOMEM;
>> -			break;
>
> Indeed, removing the error return is a regression.

Isn't the return code incorrect? There are a multitude of reasons why 
snd_soc_dapm_new_control() would fail. No-memory is just one of them, so 
why do we force this probable lie?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
