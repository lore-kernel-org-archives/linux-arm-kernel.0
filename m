From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 19:37:33 +0000
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <4F7B2324.8000706@wwwdotorg.org>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de> <4F7B2324.8000706@wwwdotorg.org>
Message-ID: <201204031937.33897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Stephen Warren wrote:
> On 04/03/2012 07:47 AM, Arnd Bergmann wrote:
> > On Tuesday 03 April 2012, Viresh Kumar wrote:
> >> This adds pinctrl driver for SPEAr family. Currently it contains machine/SoC
> >> drivers for SPEAr3xx family only. SPEAr13xx family drivers will follow.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> > 
> > Hi Viresh,
> > 
> > This is quite a lot of data, especially for the spear320. Have you
> > tried moving some or all of the data into device tree properties?
> > 
> > I can only guess that the spear13xx file would be even larger than
> > these.
> 
> Didn't we decide (at Linaro Connect) that is was perfectly acceptable to
> put this data into the pinctrl drivers; it's just going to get parsed
> out into exactly the same tables, and the data is presumably static for
> each SoC, and hence there's little point putting it into DT.

Yes, but it's also acceptable to put it into the device tree. It's mostly
a question of how you prioritise it as a maintainer. For platforms that
have a lot of different socs, it may make much more sense than it does
for those that only have a couple of different pincontrol variants.

> >> +/* pingroups */
> >> +static struct spear_pingroup *spear310_pingroups[] = {
> >> +    SPEAR3XX_COMMON_PINGROUPS,
> >> +    &emi_cs_0_to_5_pingroup,
> >> +    &uart1_pingroup,
> >> +    &uart2_pingroup,
> >> +    &uart3_pingroup,
> >> +    &uart4_pingroup,
> >> +    &uart5_pingroup,
> >> +    &fsmc_pingroup,
> >> +    &rs485_0_pingroup,
> >> +    &rs485_1_pingroup,
> >> +    &tdm_pingroup,
> >> +};
> >> +
> >> +/* functions */
> >> +static struct spear_function *spear310_functions[] = {
> >> +    SPEAR3XX_COMMON_FUNCTIONS,
> >> +    &emi_cs_0_to_5_function,
> >> +    &uart1_function,
> >> +    &uart2_function,
> >> +    &uart3_function,
> >> +    &uart4_function,
> >> +    &uart5_function,
> >> +    &fsmc_function,
> >> +    &rs485_0_function,
> >> +    &rs485_1_function,
> >> +    &tdm_function,
> >> +};
> > 
> > I believe the macros like SPEAR3XX_COMMON_FUNCTIONS are not
> > needed any more, you can simply register multiple sets of pingroups
> > and functions.
> 
> For a given pin controller, there's a single set of pins, groups, and
> functions; no incremental registration. You can register multiple pin
> controllers, but that only makes sense if there really are multiple
> physically separate pin controller modules in hardware.

Right, my fault. I confused this with pinmux_register_mappings, which
can be called multiple times.

	Arnd
