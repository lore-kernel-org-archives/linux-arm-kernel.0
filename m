From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 May 2016 14:55:52 +0530
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <57258799.70803@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
 <20160426033029.GB2274@localhost>
 <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
 <20160426162529.GK2274@localhost> <571F9D76.2060809@codeaurora.org>
 <20160427081501.GV2274@localhost>
 <2c7ac0732fb16f952db24b7c70065318@codeaurora.org>
 <57258799.70803@codeaurora.org>
Message-ID: <20160502092552.GC2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01, 2016 at 12:35:37AM -0400, Sinan Kaya wrote:
> >>> >
> >>> > Hmm, have you thought about using regmap?
> >>>
> >>> To be honest, I didn't know what regmap is but I just read some code
> >>> and looked at how it is used. Feel free to correct me if I got it
> >>> wrong.
> >>>
> >>> Regmap seems to be designed for *slow* speed peripherals to improve frequent
> >>> accesses by the SW. It looks like it is used by MFD, SPI and I2C drivers.
> >>>
> >>> It seems to cache the register contents and flush/invalidate them only when
> >>> needed.
> >>>
> >>> The MMIO version seems to be assuming the presence of device-tree like CLK
> >>> API which doesn't exist on ACPI systems and is not portable.
> >>>
> >>> My reaction is that it is a lot of code with no added functionality to what
> >>> HIDMA driver is trying to achieve.
> >>>
> >>> Given that the use case here is only for debug purposes; I think it is OK
> >>> to keep this runtime call here. I don't want to add any overhead into the
> >>> existing code just to support the debug use case.
> >>>
> >>> None of my register read/writes are slow. This file will only be used to
> >>> troubleshoot customer issues.
> >>
> >> $ is always faster than MMIO. This way you can give reg contents to users
> >> without waking up hw.
> >>
> >> Also we at Intel use regmap on ACPI systems without CLK API
> > 
> > I can try and see the performance impact is. What happens to registers that hw updates like status registers. Those will be most interesting during debug. How does remap get updated for those? Is there a way to tell it not to cache certain registers
> 
> My evaluation turned out negative. The regmap code is nice for bus like peripherals
> like I2C and SPI where everything is bitwise accessed. This is not the case
> in this code. 

I do not entirely agree with the statements here, it does give big benefit
on our systems with MMIO. I am going to ask Mark to comment on this, he
know better and understands ARM.

I am probably going to be okay with this not using regmap and it is debug
but you should give that a try in future for better performance and ofcourse
you can add to regmap to get a better model for your device

> Regmap is a nice tool if used properly but it doesn't mean that it will work
> in every single case. It doesn't match with the goal of this driver. 
> 
> As soon as I abstract register accesses, the regmap code writes all MMIO registers
> with the readl variant functions.
> 
> Barriers are really expensive on ARM. I paid very special attention in the 
> code to decide when to use relaxed version vs. the readl version. I lose 
> all of this optimization. 
> 
> Since the clocks are restored only during the debug case, I don't see any
> problems here. It is not worth the effort to do redo the whole thing and 
> introduce errors as I see a lot of tripping points like regmap_sync variants.

-- 
~Vinod
