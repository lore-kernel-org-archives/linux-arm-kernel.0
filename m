From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 19 Apr 2014 11:18:17 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140419094633.2fa0b190@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BC5DA.7030106@gmail.com> <20140419094633.2fa0b190@skate>
Message-ID: <53523F59.60209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added devtree ML and Sascha Hauer]

On 04/19/2014 09:46 AM, Thomas Petazzoni wrote:
> Dear Sebastian Hesselbarth,
> 
> On Mon, 14 Apr 2014 13:26:18 +0200, Sebastian Hesselbarth wrote:
> 
>>> +	chosen {
>>> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
>>
>> + [linux,]stdout-path = &uart0;
> 
> Done. Should it be linux,stdout-path, or stdout-path? As of 3.15-rc1,
> it seems that only linux,stdout-path is being used.

I remember some discussion on devtree ML that mentioned stdout-path as
possibly generic enough to loose its "linux," prefix.

Maybe Sascha can give a comment on this.

>>> +		devbus-bootcs {
>>
>> Use node label references where applicable.
> 
> Ok. Which node labels do you suggest for the devbus-* nodes?

I'd say, just pick the foo in devbus-foo, e.g. "bootcs" for the
one above. Or "devbus_bootcs" if you like.

[...]
>>> +&mdio {
>>> +	status = "okay";
>>> +
>>> +	ethphy: ethernet-phy {
>>> +		reg = <8>;
>>
>> Can you evaluate if it is GMII or RGMII[-id] and add a
>> phy-connection-type property now? This is something that
>> bothers me already on kirkwood.
> 
> I'll try to do this for this board for which I believe I have the
> schematics, but for edmini_v2 or d2net, I don't have the schematics.
> I'll see if I can infer the information from some U-Boot output, or by
> dumping some register.

If you find it out now, great. If not just leave it that way.

>>> + * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
>>
>> Maybe add Ronen to the Signed-off tag, too? Or at least put him
>> on Cc?
> 
> Signed-off-by looks a bit strong, because Ronen has never seen this
> patch nor been involved in writing it. I'll Cc him.

Well, you make him the number one person to ask if there is something
wrong with the DT ;) Cc is ok.

>>> +	pin = RD88F5182_PCI_SLOT0_IRQ_A_PIN;
>>> +	if (gpio_request(pin, "PCI IntA") == 0) {
>>> +		if (gpio_direction_input(pin) == 0) {
>>> +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
>>> +		} else {
>>> +			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
>>
>> I am not sure, what is the correct way of using it, but maybe it is
>> pr_err()? I'd also be interested in the latest policy of using it.
> 
> Indeed pr_err() is the right thing to use now. However here I'm just
> replicating existing code, so I'd prefer to keep it as is in this
> commit, if possible. I'm anyway planning on removing this PCI platform
> code soon, but this is going to be for after this series is merged.

Ok, makes sense to me, feel free to leave it that way it is.

Sebastian
