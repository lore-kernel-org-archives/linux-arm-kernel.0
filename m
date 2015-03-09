From: stefan@agner.ch (Stefan Agner)
Date: Mon, 09 Mar 2015 13:43:49 +0100
Subject: [PATCH 1/5] mtd: nand: =?UTF-8?Q?vf=36=31=30=5Fnfc=3A=20Frees?=
 =?UTF-8?Q?cale=20NFC=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=20and=20oth?=
 =?UTF-8?Q?ers?=
In-Reply-To: <20150309095843.GA31289@pengutronix.de>
References: <1425510624-22250-1-git-send-email-stefan@agner.ch>
 <1425510624-22250-2-git-send-email-stefan@agner.ch>
 <20150306061502.GB10997@pengutronix.de>
 <fdfc84d92bbcb8abc98f2c29e1aa368b@agner.ch>
 <20150309095843.GA31289@pengutronix.de>
Message-ID: <975eaa91737584f8b45b36942cece523@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-09 10:58, Sascha Hauer wrote:
> On Fri, Mar 06, 2015 at 02:31:51PM +0100, Stefan Agner wrote:
>> On 2015-03-06 07:15, Sascha Hauer wrote:
>> > Hi Stefan,
>> >
>> > On Thu, Mar 05, 2015 at 12:10:20AM +0100, Stefan Agner wrote:
>> >> +
>> >> +static int vf610_nfc_probe_dt(struct device *dev, struct vf610_nfc_config *cfg)
>> >> +{
>> >> +	struct device_node *np = dev->of_node;
>> >> +	int buswidth;
>> >> +	u32 clkrate;
>> >> +
>> >> +	if (!np)
>> >> +		return 1;
>> >> +
>> >> +	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
>> >> +
>> >> +	if (!of_property_read_u32(np, "clock-frequency", &clkrate))
>> >> +		cfg->clkrate = clkrate;
>> >
>> > Normally the clock-frequency property tells the driver at which
>> > frequency the device actually is running, not to tell the driver at
>> > which frequency the device *should* run. It's strange to use the value
>> > of the clock-frequency property as input to clk_set_rate(). Maybe the
>> > assigned clock binding is more appropriate here, see
>> > Documentation/devicetree/bindings/clock/clock-bindings.txt.
>>
>> What we try to do here is to specify the hardware limitations. There
>> seem to be some hardware restrictions when it comes to clock
>> frequencies. There has been a rather long discussion over at Freescales
>> community about it:
>> https://community.freescale.com/thread/317074
>>
>> Not sure if this is the right way to specify the supported frequencies,
>> or should we create a custom property for this, something like
>> fsl,max-nfc-frequency = <33000000>?
> 
> What's wrong with the assigned clock binding? All you have to do is to
> add it to the device node. The rest will be done from the generic clock
> framework with no additional driver code.

Ah yes, assigned clock bindings seems like a match. So, the NFC node
would look something like

...
        assigned-clocks = <&clks VF610_CLK_NFC>;
        assigned-clock-rates = <33000000>;
...

Will try to use that, thx.

--
Stefan
