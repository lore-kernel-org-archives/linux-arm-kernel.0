From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 06 Nov 2012 13:39:12 +0800
Subject: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
In-Reply-To: <50974DE6.50506@atmel.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
 <20121101144315.GM4413@opensource.wolfsonmicro.com>
 <5093312D.4070408@atmel.com>
 <20121102142444.GY4413@opensource.wolfsonmicro.com>
 <50974DE6.50506@atmel.com>
Message-ID: <5098A280.7070301@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark Brown,

On 11/5/2012 13:25, Bo Shen wrote:
> Hi Mark Brown,
>
> On 11/2/2012 22:24, Mark Brown wrote:
>> On Fri, Nov 02, 2012 at 10:34:21AM +0800, Bo Shen wrote:
>>> On 11/1/2012 22:43, Mark Brown wrote:
>>>> On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:
>>
>>>>> +dai: dai {
>>>>> +    compatible = "atmel,atmel-ssc-dai";
>>>>> +    atmel,dai-master = <&ssc0>;
>>>>> +};
>>
>>>> This seems to be a purely virtual device which remaps the SSC onto the
>>>> Linux audio subsystem?  If that is the case then it shouldn't appear in
>>>> the device tree,
>>
>>> Yes. This is a purely virtual device. I add this as to the following
>>> reason.
>>
>>> In our case, the ssc can connect to audio codec, DAC and other
>>> devices. In order to avoid duplicate the code, so keep ssc as a
>>> library, register it directly in Linux and use remap method to let
>>> it work onto other different subsystem.
>>
>> Your quote appears to have deleted the bit of my mail where I told you
>> how to fix this.  Is there something unclear in my suggestion that the
>> machine driver directly reference the SSC node?
>>
>
> Sorry for misunderstand. I split your e-mail into two parts. May be you
> miss some parts of my e-mail. You can check the last mail from me. Or
> check the following fully quote.

Anyway, I will sent out a RFC patch series (which will be v3) which 
register dai and platform directly in Linux.

BRs,
Bo Shen

> --------------------------------------------------------------------------
> On 11/1/2012 22:43, Mark Brown wrote:
>  > On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:
>  >
>  >> +Required properties:
>  >> +  - compatible: "atmel,atmel-ssc-dai"
>  >> +  - atmel,dai-master: this dai base on which ssc controller
>  >
>  >> +Example:
>  >> +dai: dai {
>  >> +    compatible = "atmel,atmel-ssc-dai";
>  >> +    atmel,dai-master = <&ssc0>;
>  >> +};
>  >
>  > This seems to be a purely virtual device which remaps the SSC onto the
>  > Linux audio subsystem?  If that is the case then it shouldn't appear in
>  > the device tree,
>
> Yes. This is a purely virtual device. I add this as to the following
> reason.
>
> In our case, the ssc can connect to audio codec, DAC and other devices.
> In order to avoid duplicate the code, so keep ssc as a library, register
> it directly in Linux and use remap method to let it work onto other
> different subsystem.
>
> So, for ssc connect to audio codec, use dai to remap the SSC onto the
> Linux audio subsystem. In this way, just let the dai know which ssc
> channel it based on. The remap is just a simple way. Please take
> following code as a reference.
>
> ---<8---
>          if (pdev->dev.of_node) {
>                  struct device_node *np = pdev->dev.of_node;
>                  struct device_node *dai_master_np;
>
>                  dai_master_np = of_parse_phandle(np,
> "atmel,dai-master", 0);
>                  if (!dai_master_np) {
>                          dev_err(&pdev->dev, "No SSC for atmel dai");
>                          return -EINVAL;
>                  }
>
>                  id = of_alias_get_id(dai_master_np, "ssc");
>          } else {
>                  id = to_platform_device(pdev->dev.parent)->id;
>          }
>
>          ssc = ssc_request(id);
>          if (IS_ERR(ssc)) {
>                  dev_err(&pdev->dev, "Failed to request SSC %d\n", id);
>                  return PTR_ERR(ssc);
>          }
>          ssc_info.ssc = ssc;
>          pdev->dev.parent = &(ssc->pdev->dev);
> --->8---
>
> If ssc connect to other devices, also need to remap to other subsystem.
>
>  > the machine driver should just directly reference the
>  > SSC and instantiate any devices required in Linux directly.
>
> I am not fully understand this. So, which do you mean as the following
> two method or any other else?
>
> Our old method:
>    using audio machine driver (e.g: sam9g20_wm8731.c) call
> atmel_ssc_set_audio function to allocate the platform device for
> atmel-ssc-dai and atmel-pcm-audio and then add device.
>
> Code as following:
> ---<8---
> /* Allocate a dummy device for DMA if we don't have one already */
>          if (!dma_pdev) {
>                  dma_pdev = platform_device_alloc("atmel-pcm-audio", -1);
>                  if (!dma_pdev)
>                          return -ENOMEM;
>
>                  ret = platform_device_add(dma_pdev);
>                  if (ret < 0) {
>                          platform_device_put(dma_pdev);
>                          dma_pdev = NULL;
>                          return ret;
>                  }
>          }
>
>          ssc_pdev = platform_device_alloc("atmel-ssc-dai", ssc_id);
>          if (!ssc_pdev)
>                  return -ENOMEM;
>
>          /* If we can grab the SSC briefly to parent the DAI device off
> it */
>          ssc = ssc_request(ssc_id);
>          if (IS_ERR(ssc))
>                  pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
>                          PTR_ERR(ssc));
>          else {
>                  ssc_pdev->dev.parent = &(ssc->pdev->dev);
>                  ssc_free(ssc);
>          }
>
>          ret = platform_device_add(ssc_pdev);
> --->8---
>
> Other SoC do like this:
>    register i2s device, and then register dai, finally register
> platform. So, only one device.
> --------------------------------------------------------------------------
>
> Best regards,
> Bo Shen
