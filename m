From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 21 Nov 2011 15:32:56 +0100
Subject: [PATCH] Initial DT support for SIMpad devices.
In-Reply-To: <20111121095020.GA7314@totoro>
References: <1321821470-32396-1-git-send-email-jochen@scram.de>
 <20111121095020.GA7314@totoro>
Message-ID: <4ECA6118.1050806@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

>> +	localbus {
>> +		compatible = "intel,sa1110-localbus";
>
> Could this claim compatibility with simple-bus?

I wasn't sure about this. I took a look in the powerpc DTS files for reference and they used
some kind of <chip>-localbus compatible entries. So I took the same approach here.

>> +		uart2: serial at 0x80050000 {
>> +			compatible = "intel,sa1100-uart";
>> +			reg =<0x80050000 0x24>;
>> +			interrupts =<17>;
>> +			status = "disabled";
>
> Hmm, I couldn't see status defined in the UART binding or where it was
> used...  Is this required?

status is a global property and it's being used in drivers/of/base.c, of_device_is_available().
It is used in other dtsi files like e.g. at91sam9g45.dtsi as well to define optional nodes.

>> +/ {
>> +	model = "SIEMENS, SIMpad";
>> +	compatible = "siemens,simpad";
>
> It may be worth adding the SoC compatible string after the board one for
> completeness.

Do you mean something like this?

	compatible = "siemens,simpad", "intel,sa1100";

>> +	chosen {
>> +		bootargs = "console=ttySA0";
>
> It is preferred for the bootloader to set these up rather than having
> them statically in the DTS if at all possible.

Yes, my boot loader does this, but simpad support is not in official U-BOOT yet.
This allows testing with a different boot loader like the hh.org one and a Linux
binary with DTB appended.

>> +const struct of_device_id simpad_bus_match_table[] = {
>> +	{ .compatible = "simple-bus", },
>> +	{ .compatible = "intel,sa1110-localbus", },
>> +	{} /* Empty terminated list */
>> +};
>> +
>> +static void __init simpad_dt_device_init(void)
>> +{
>> +	of_platform_populate(NULL, simpad_bus_match_table, NULL, NULL);
>> +}
>
> If the localbus was compatible with simple-bus then you could do:
>
> 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>
> and remove simpad_bus_match_table.

True, I just wasn't sure if it's OK to do so.

>> +static const char *simpad_dt_board_compat[] __initdata = {
>
> I think this should be __initconst.

OK.

Thanks,
Jochen
