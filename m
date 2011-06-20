From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 20 Jun 2011 15:26:08 +0900
Subject: [PATCH 1/2] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <20110618151227.GB25163@sirena.org.uk>
References: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
	<20110618151227.GB25163@sirena.org.uk>
Message-ID: <BANLkTiniwMCW-ED4CX=qybMvk243Zdki4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2011 at 12:12 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jun 16, 2011 at 06:09:31PM +0900, MyungJoo Ham wrote:
>
>> ?static struct regulator_init_data emmc_fixed_voltage_init_data = {
>> ? ? ? .constraints ? ? ? ? ? ?= {
>> + ? ? ? ? ? ? .min_uV ? ? ? ? = 2800000,
>> + ? ? ? ? ? ? .max_uV ? ? ? ? = 2800000,
>> ? ? ? ? ? ? ? .name ? ? ? ? ? = "VMEM_VDD_2.8V",
>> ? ? ? ? ? ? ? .valid_ops_mask = REGULATOR_CHANGE_STATUS,
>
> Since the regualtor can't change voltage specifying the voltage here
> isn't going to achieve anything - to get the voltage reported through
> get_voltage() you need to put the voltage in the platform data for the
> fixed regulator.

Ah.. they are useless. I'll remove them.

>
>> +static struct regulator_consumer_supply nuri_max8997_ldo1_consumer[] = {
>> + ? ? REGULATOR_SUPPLY("vadc", NULL), /* Used by CPU's ADC drv */
>> +};
>
> In the ADC regulator patch you called the supply vdd (though the chip
> normally calls it vadc so that's the better name)...

Um.. this happened as I have seperated NURI-board platform patch for
ADC and PMIC.
After ADC patch, that name became ("vdd", "s5p-adc").
I'll let them either be merged or be disjoint completely.

Anyway, do you think "vadc" is better than "vdd" for ADC drivers? The
circuit schematics says the pin on the consumer side is "VDD33_ADC"
(VDD 3.3V for ADC).


>
> Extra ' too.
>
>> +static struct regulator_consumer_supply nuri_max8997_ldo8_consumer[] = {
>> + ? ? REGULATOR_SUPPLY("vusb_d", NULL), /* Used by CPU */
>> + ? ? REGULATOR_SUPPLY("vdac", NULL), /* Used by CPU */
>> +};
>
> Another VADC? ?For a different supply?

That's DAC (opposite to ADC).

>
>> + ? ? ? ? ? ? .state_mem ? ? ?= {
>> + ? ? ? ? ? ? ? ? ? ? .enabled ? ? ? ?= 0,
>
> No need to initialize to zero.

Ok, I'll remove every zero-initialization from the patch.

>
>> +static struct regulator_init_data nuri_max8997_ldo10_data = {
>> + ? ? .constraints ? ?= {
>
> You should be able to use __initdata for a lot of this by the way.

Ah.. way to reduce some weight. Fine.

>
>> +#define NURI_PMIC_GPIO ? ? ? ? ? ? ? EXYNOS4_GPX0(7)
>> +static void __init nuri_pmic_init(void)
>> +{
>> + ? ? int gpio;
>> +
>> + ? ? nuri_max8997_pdata.irq_base = irq_get_next_irq(IRQ_GPIO_END);
>> + ? ? gpio = NURI_PMIC_GPIO;
>> + ? ? gpio_request(gpio, "AP_PMIC_IRQ");
>> + ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
>> + ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
>> +}
>
> I'm not sure both the #define and the variable make sense here...
>

I've defined them because two statements are using the gpio address of
NURI_PMIC.



Thanks you very much!

- MyungJoo
-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
