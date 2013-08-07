From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 7 Aug 2013 16:52:51 -0700
Subject: [PATCH v3 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <51FAA6F4.2010002@arm.com>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-2-git-send-email-markus.mayer@linaro.org>
 <51FAA6F4.2010002@arm.com>
Message-ID: <CAPdLdqk45yHhiRo=99yTXYEQfiPs83=Un2YTLwpR851H+=0gyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2013 11:20, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> On 26/07/13 21:25, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This patch adds the GPIO driver for the bcm281xx family of chips.
>>
> May be I am missing my mails, but I could not find even in archives.
> The patch says its v3, I could not trace v1/v2 and not change log.

No, you didn't miss any e-mails. We had some internal reviews and the
plan was for me to renumber the patches and start from v1 again for
the public review, but I clearly forgot. Hence v3 is really the first
public version of this patch.

> Why these macros can't be something like this ?
> #define GPIO_GPOR_OFFSET(bank)  (0x00000000 + (bank) << 2)

Done.

> Can this be embed in bcm_kona_gpio?
> You can then get rid of all the accesses to global variable
> bcm_kona_gpio.

Still working on this one, but the global variable will go away. The
same is true of the other globals.

>> +static inline u32 bcm_kona_gpio_out_status(int bank)
>> +{
>> +       return GPIO_GPOR0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_in_status(int bank)
>> +{
>> +       return GPIO_GPIR0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_out_set(int bank)
>> +{
>> +       return GPIO_GPORS0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_out_clear(int bank)
>> +{
>> +       return GPIO_GPORC0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_int_status(int bank)
>> +{
>> +       return GPIO_ISR0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_int_mask(int bank)
>> +{
>> +       return GPIO_IMR0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_int_mskclr(int bank)
>> +{
>> +       return GPIO_IMRC0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_pwd_status(int bank)
>> +{
>> +       return GPIO_GPPLSR0_OFFSET + (bank << 2);
>> +}
>> +
>> +static inline u32 bcm_kona_gpio_control(int gpio)
>> +{
>> +       return GPIO_GPCTR0_OFFSET + (gpio << 2);
>> +}
> All these functions can go away if you can have the macros as shown above ?

I took those functions out.

>> +static int bcm_kona_count_irq_resources(struct platform_device *pdev)
>> +{
>> +       struct resource *res;
>> +       int count = 0;
>> +
>> +       for (;;) {
>> +               res = platform_get_resource(pdev, IORESOURCE_IRQ, count);
> platform_get_irq instead

Done.

>> +               if (!res)
>> +                       break;
>> +               count++;
>> +       }
>> +       return count;
>> +}

> IMO, you don't require any global data or pointers if probe populates
> all the pdev, irq/gpio_chip data member appropriately

Yes, they'll go away in the next revision of this driver which I am
hoping to post shortly.

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
