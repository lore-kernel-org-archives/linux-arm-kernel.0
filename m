From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 17:57:04 +0000
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
 irq handler
In-Reply-To: <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
Message-ID: <20140218175703.GJ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:09:38PM +0000, Russell King wrote:
> There's no requirement to have the card tasklet separate now that we
> have a threaded interrupt handler, so kill this and move the called
> code into the threaded part of the handler.

This patch breaks sdhci-spear's build due to this:

/* gpio card detection interrupt handler */
static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
{
        struct platform_device *pdev = dev_id;
        struct sdhci_host *host = platform_get_drvdata(pdev);
        struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
        unsigned long gpio_irq_type;
        int val;
        
        val = gpio_get_value(sdhci->data->card_int_gpio);
        
        /* val == 1 -> card removed, val == 0 -> card inserted */
        /* if card removed - set irq for low level, else vice versa */
        gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
        irq_set_irq_type(irq, gpio_irq_type);
 
        if (sdhci->data->card_power_gpio >= 0) {   
                if (!sdhci->data->power_always_enb) {
                        /* if card inserted, give power, otherwise remove it */
                        val = sdhci->data->power_active_high ? !val : val ;
                        gpio_set_value(sdhci->data->card_power_gpio, val);
                }
        }
  
        /* inform sdhci driver about card insertion/removal */
        tasklet_schedule(&host->card_tasklet);
                
        return IRQ_HANDLED;  
}

which is really nice code.  WTF is this doing?

1) You're controlling the card power GPIO via the insertion/removal
   interrupt handler?  What's wrong with using a vmmc regulator for
   that, which will be controlled via the MMC subsystem as required?

2) card detection GPIO is handled natively by sdhci.c, there's really
   no need for sdhci users to implement this themselves.

Viresh, can this custom code be killed?

Lastly, you do realise that using sdhci-spear with DT results in it
always claiming GPIO 0 for power control, since you use devm_kzalloc()
to allocate the private data and never set card_power_gpio to a
negative number.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
