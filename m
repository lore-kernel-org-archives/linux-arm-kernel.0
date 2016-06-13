From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 12 Jun 2016 23:12:41 -0400
Subject: [PATCH V6 7/8] vfio: platform: check reset call return code
 during open
In-Reply-To: <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
 <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
Message-ID: <575E24A9.2070204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/7/2016 4:21 PM, Auger Eric wrote:
>> -		vfio_platform_call_reset(vdev, NULL);
>> > +		ret = vfio_platform_call_reset(vdev, &extra_dbg);
>> > +		if (ret && vdev->reset_required) {
>> > +			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
>> > +				 ret, extra_dbg ? extra_dbg : "");
>> > +			goto err_irq;
> I am afraid you need to tear down the resources allocated by vfio_platform_irq_init. 
> 
> Best Regards
> 
> Eric

I added this to the error path and replaced the goto above with err_rst.

+err_rst:
+        vfio_platform_irq_cleanup(vdev);
err_irq:
        vfio_platform_regions_cleanup(vdev);

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
