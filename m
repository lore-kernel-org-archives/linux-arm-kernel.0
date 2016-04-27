From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 27 Apr 2016 13:45:01 +0530
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <571F9D76.2060809@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
 <20160426033029.GB2274@localhost>
 <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
 <20160426162529.GK2274@localhost> <571F9D76.2060809@codeaurora.org>
Message-ID: <20160427081501.GV2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 12:55:18PM -0400, Sinan Kaya wrote:
> On 4/26/2016 12:25 PM, Vinod Koul wrote:
> > On Tue, Apr 26, 2016 at 08:08:16AM -0400, okaya at codeaurora.org wrote:
> >> On 2016-04-25 23:30, Vinod Koul wrote:
> >>> On Mon, Apr 11, 2016 at 10:21:12AM -0400, Sinan Kaya wrote:
> >>>
> >>>> +static int hidma_chan_stats(struct seq_file *s, void *unused)
> >>>> +{
> >>>> +	struct hidma_chan *mchan = s->private;
> >>>> +	struct hidma_desc *mdesc;
> >>>> +	struct hidma_dev *dmadev = mchan->dmadev;
> >>>> +
> >>>> +	pm_runtime_get_sync(dmadev->ddev.dev);
> >>>
> >>> debug shouldn't power up device, why do you want to do that
> >>
> >>
> >> Clocks are turned off while the hw is idle. I can?t reach hw
> >> registers without restoring power.
> > 
> > Hmm, have you thought about using regmap?
> > 
> 
> To be honest, I didn't know what regmap is but I just read some code
> and looked at how it is used. Feel free to correct me if I got it 
> wrong. 
> 
> Regmap seems to be designed for *slow* speed peripherals to improve frequent
> accesses by the SW. It looks like it is used by MFD, SPI and I2C drivers.
> 
> It seems to cache the register contents and flush/invalidate them only when
> needed.
> 
> The MMIO version seems to be assuming the presence of device-tree like CLK
> API which doesn't exist on ACPI systems and is not portable.
> 
> My reaction is that it is a lot of code with no added functionality to what
> HIDMA driver is trying to achieve. 
> 
> Given that the use case here is only for debug purposes; I think it is OK 
> to keep this runtime call here. I don't want to add any overhead into the
> existing code just to support the debug use case.  
> 
> None of my register read/writes are slow. This file will only be used to 
> troubleshoot customer issues.

$ is always faster than MMIO. This way you can give reg contents to users
without waking up hw.

Also we at Intel use regmap on ACPI systems without CLK API

-- 
~Vinod
