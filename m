From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Nov 2014 10:25:40 +0000
Subject: [PATCH v3 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <71C24A547111EA4E84AE759B748D9EAE4B976C@DBDE04.ent.ti.com>
References: <1415694844-11230-1-git-send-email-vigneshr@ti.com>
 <1415694844-11230-4-git-send-email-vigneshr@ti.com>
 <20141111122623.GA24004@x1>
 <71C24A547111EA4E84AE759B748D9EAE4B976C@DBDE04.ent.ti.com>
Message-ID: <20141113102540.GJ24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Nov 2014, R, Vignesh wrote:
> On Tue, 11 Nov 2014, Vignesh R wrote:
> > In one shot mode, sequencer automatically disables all enabled steps 
> > at the end of each cycle. (both ADC steps and TSC steps) Hence these 
> > steps need not be saved in reg_se_cache for clearing these steps at a 
> > later stage.
> > Also, when ADC wakes up Sequencer should not be busy executing any of 
> > the config steps except for the charge step. Previously charge step 
> > was 1 ADC clock cycle and hence it was ignored.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---

[...]

> > -	tsadc->reg_se_cache |= val;
> 
> You didn't answer my question about this?
> I did reply to the question in the previous thread.  
> 
> Previously, TSC did not reliably re-enable its steps as the TSC irq handler received 
> false pen up events. Hence, in order to use TSC after ADC operation, it was necessary to
>  save and re-enable TSC steps (basically, to keep TSC steps enabled always).
> The change was more of a workaround to overcome limitation of TSC irq handler. With 
> this series of patches, TSC irq handler is very reliable and the workaround is no longer required.

Okay, thanks for the explanation.

By the way, your mailer doesn't appear to quote previous messages.  Is
there any way to fix that?

> >  	am335x_tscadc_need_adc(tsadc);
> >  
> >  	tscadc_writel(tsadc, REG_SE, val);
> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h 
> > b/include/linux/mfd/ti_am335x_tscadc.h
> > index c99be5dc0f5c..fcce182e4a35 100644
> > --- a/include/linux/mfd/ti_am335x_tscadc.h
> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> > @@ -128,6 +128,7 @@
> >  
> >  /* Sequencer Status */
> >  #define SEQ_STATUS BIT(5)
> > +#define CHARGE_STEP		0x11
> >  
> >  #define ADC_CLK			3000000
> >  #define TOTAL_STEPS		16
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
