From: jeffy.chen@rock-chips.com (jeffy)
Date: Wed, 23 Aug 2017 09:32:39 +0800
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20170822172653.GJ6008@atomide.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com> <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com> <20170822172653.GJ6008@atomide.com>
Message-ID: <599CDB37.3070307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 08/23/2017 01:26 AM, Tony Lindgren wrote:
> OK, let's fix any wakeriq ordering issues to make it more
> usable. Sounds like in your case the wakeirq needs to be enabled
> late and disabled early, while in my test cases I can keep it
> enabled basically any time.

yes, in my case it's a level triggered irq, which needs to be disabled 
when receive it(by irq_pm_check_wakeup(my hack) or inside of the custom 
irq handler)


and for eage irq, maybe we should enable it right after(or before) the 
driver activate wake function(for example activate WOWLAN or WOLAN), 
otherwise would it be possible to miss some irqs(triggered before we 
actually enable the wake irq)?

>
> If this is for suspend/resume, You could just register the
> wakeirq on suspend and then remove it on resume. We do have at
> least network drivers doing device_init_wakeup(dev, true) and
> device_init_wakeup(dev, false) as needed for WOL, see for example
> bfin_mac_ethtool_setwol().
>
> Regards,
>
> Tony
>
>
>
>
