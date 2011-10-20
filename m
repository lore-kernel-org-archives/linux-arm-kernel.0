From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Oct 2011 09:14:16 +0200
Subject: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
In-Reply-To: <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20111020091416.1e90828c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 19 Oct 2011 18:18:54 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> +void __init at91_add_device_adc(struct at91_adc_data *data)
> +{
> +	if (!data)
> +		return;
> +
> +	at91_set_A_periph(AT91_PIN_PC0, 0);
> +	at91_set_A_periph(AT91_PIN_PC1, 0);
> +	at91_set_A_periph(AT91_PIN_PC2, 0);
> +	at91_set_A_periph(AT91_PIN_PC3, 0);

As suggested, the decision of which ADC channels are used and therefore
which pins should be muxed to function A is a board-specific decision
and should not be enforced by SoC code.

> +static struct at91_adc_data ek_adc_data = {
> +	.channels = 4,
> +	.adc_clock = 5000000,
> +	.startup_time = 10,
> +};

And on the opposite, those informations are specific to a SoC, not to a
board. So to avoid duplication in all board files, they should be moved
to the corresponding SoC file.

Maybe something like:

#define AT91_ADC_MAX_CHANNELS 8

struct at91_adc_data {
    unsigned int adc_clock;
    u8 channels_used[AT91_ADC_MAX_CHANNELS];
    u8 startup_time;
    u8 channels;
};

at91_add_device_adc() {
	if (data->channels_used[0])
		at91_set_A_periph(AT91_PIN_PC0, 0);
	if (data->channels_used[1])
		at91_set_A_periph(AT91_PIN_PC1, 0);
	if (data->channels_used[2])
		at91_set_A_periph(AT91_PIN_PC2, 0);
	if (data->channels_used[3])
		at91_set_A_periph(AT91_PIN_PC3, 0);
	data->startup_time = ...
	data->channels = ...
	data->adc_clock = ...
}

and the board file would do:

struct at91_adc_data ek_adc_data = {
	.channels_used = { 1, 0, 1, 1 },;
};

Or maybe others have different suggestions ?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
