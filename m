From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Jun 2018 10:43:26 +0100
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <20180606155501.704583e1412996a1a2c6fa61@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
Message-ID: <30e98462-237f-df2f-39d9-f0414f52b950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 09:55 PM, Kim Phillips wrote:
> On Wed, 6 Jun 2018 10:46:36 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> 
>> And while we are at this, I also realised that we hold references to the
>> parent devices for each connection (via bus_find_device() from
>> of_coresight_get_endpoint_device()), while parsing the platform data,
>> which is never released.
> 
> Would this fix that?:

Not completely. We store the dev_name() as a reference, which itself can 
be free'd, when the device is gone. I have a fix for this in my next
version of the DT clean up series [0], where I clean up most of the
platform parsing code.


[0] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582904.html

Cheers
Suzuki

> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index a33a92ebe74b..a43ab078c85e 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -181,6 +181,8 @@ of_get_coresight_platform_data(struct device *dev,
>                          pdata->child_names[i] = dev_name(rdev);
>                          pdata->child_ports[i] = rendpoint.id;
>   
> +                       put_device(rdev);
> +
>                          i++;
>                  } while (ep);
>          }
