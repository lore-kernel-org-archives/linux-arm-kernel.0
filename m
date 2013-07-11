From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 11 Jul 2013 12:59:49 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <20130711063209.GZ5523@atomide.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org>
 <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi>
 <20130710161158.GA19716@arwen.pp.htv.fi> <20130711063209.GZ5523@atomide.com>
Message-ID: <51DE8215.5060306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/11/2013 09:32 AM, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130710 09:18]:
>>
>> On Wed, Jul 10, 2013 at 07:07:04PM +0300, Felipe Balbi wrote:
>>> how about something like below ? It makes omap_device/hwmod and
>>> pm_runtime agree on the initial state of the device and will prevent
>>> ->runtime_resume() from being called on first pm_runtime_get*() done
>>> during probe.
>>>
>>> This is similar to what PCI bus does (if you look at pci_pm_init()).
>>>
>>> commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
>>> Author: Felipe Balbi <balbi@ti.com>
>>> Date:   Wed Jul 10 18:50:16 2013 +0300
>>>
>>>      arm: omap2plus: unidle devices which are about to probe
>>>
>>>      in order to make HWMOD and pm_runtime agree on the
>>>      initial state of the device, we will unidle the device
>>>      and call pm_runtime_set_active() to tell pm_runtime
>>>      that the device is really active.
Don't think that it's good idea (
I've checked some driver's and think this patch will enable some devices 
unpredictably:
- hwspinlock
- mailbox
- iommu
- ipu
All above devices need to be enabled on demand only (no 
pm_runtime_get*() calls in probe). More over, some of them have very 
specific enabling sequence - like ipu).

May be Summan can say more on that.

>>>
>>>      By the time driver's probe() is reached, a call to
>>>      pm_runtime_get_sync() will not cause driver's
>>>      ->runtime_resume() method to be called at first, only
>>>      after a successful ->runtime_suspend().
>>>
>>>      Signed-off-by: Felipe Balbi <balbi@ti.com>
>>
>> btw, this is RFC, haven't tested at all.
>
> Yes it does not compile, then removing the extra ; at the end
> of the functions, it oopses with a NULL pointer exception.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
