From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Sep 2011 11:33:21 -0700
Subject: [PATCH v4 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <201109281516.42513.arnd@arndb.de>
References: <1317171902-14736-1-git-send-email-pdeschrijver@nvidia.com>
	<1317171902-14736-4-git-send-email-pdeschrijver@nvidia.com>
	<201109281516.42513.arnd@arndb.de>
Message-ID: <CAOesGMgv5wqZPMZPS4UKO4owgxBRLP9T6NPSFAVVcLd3vPYkiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 6:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 28 September 2011, Peter De Schrijver wrote:
>> --- a/arch/arm/mach-tegra/board-dt.c
>> +++ b/arch/arm/mach-tegra/board-dt.c
>> @@ -47,7 +47,7 @@
>>
>> ?void harmony_pinmux_init(void);
>> ?void seaboard_pinmux_init(void);
>> -
>> +void ventana_pinmux_init(void);
>>
>> ?struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
>> ? ? ? ? OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
>> @@ -95,6 +95,8 @@ static void __init tegra_dt_init(void)
>> ? ? ? ? ? ? ? ? harmony_pinmux_init();
>> ? ? ? ? else if (of_machine_is_compatible("nvidia,seaboard"))
>> ? ? ? ? ? ? ? ? seaboard_pinmux_init();
>> + ? ? ? else if (of_machine_is_compatible("nvidia,ventana"))
>> + ? ? ? ? ? ? ? ventana_pinmux_init();
>
> Are you (Peter, Colin, Olof) confident that this is not getting out
> of hand before it's getting better?
>
> If we are keeping the per-board pinmux configuration in the kernel
> for longer, I think it would be better to do this table-driven than
> having a list of top-level of_machine_is_compatible() statements
> and do something like:
>
> static struct {
> ? ? ? ?const char *machine;
> ? ? ? ?struct tegra_pingroup_config *config[];
> } pinmux_configs[] __initdata = {
> ? ? ? ?{ "nvidia,ventana", &ventana_pinmux },
> ? ? ? ?{ "nvidia,seaboard, &seaboard_pinmux },
> };

That is definitely a nicer solution. I didn't see a strong need to
switch to that model now since it should hopefully be a temporary
thing, but given Stephen's mention of Cardhu, I think it does make
sense.

Peter, care to respin this patch with the above solution instead?
Also, please print a warning if no match is found.


Thanks,

-Olof
