From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 1 Mar 2018 01:49:51 +0000
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
In-Reply-To: <2424862.oPtAVTfrB9@jernej-laptop>
References: <2424862.oPtAVTfrB9@jernej-laptop>
Message-ID: <87fu5kk1mm.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jernej

Thank you for your report

> with todays linux-next (next-20180228), kernel on Allwinner H3 SoC crashes 
> with dmesg like that: https://pastebin.com/raw/0D5JeaJ8
> 
> I bisected the kernel and first offending commit is:
> be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: replace platform to 
> component")
> 
> I know that crash message is completely unrelated to sound subsystem, but it 
> turns out that if I disable CONFIG_SND_SUN4I_CODEC kernel works ok, but this 
> way I lose analog audio output.
> 
> Any suggestions what can be the issue?

Hmm... I'm sorry but I have no idea...

One thing I noticed is that...

=>	[    1.662605] Unable to handle kernel NULL pointer dereference at virtual address 00000004
	...
	[    1.703312] PC is at strlen+0x0/0x2c
	[    1.706976] LR is at kobject_get_path+0x1c/0xb4

my guess this "strlen" is from get_kobj_path_length() (?)
and it is below.

static int get_kobj_path_length(struct kobject *kobj)
{
	...
=>	if (kobject_name(parent) == NULL)
		return 0;
=>	length += strlen(kobject_name(parent)) + 1;
	...
}

Your "parent name" is 0x00000004 instead of NULL somehow...

	[    2.170203] [<c063efbc>] (strlen) from [<c0633f08>] (kobject_get_path+0x1c/0xb4)
	[    2.183581] [<c0633f08>] (kobject_get_path) from [<c0635178>] (kobject_uevent_env+0xd4/0x5d0)
	[    2.198143] [<c0635178>] (kobject_uevent_env) from [<c0428c54>] (device_add+0x3b4/0x5b4)
	[    2.212252] [<c0428c54>] (device_add) from [<c05205d0>] (extcon_dev_register+0x348/0x6c0)
	[    2.226443] [<c05205d0>] (extcon_dev_register) from [<c05210a4>] (devm_extcon_dev_register+0x38/0x70)
	[    2.241717] [<c05210a4>] (devm_extcon_dev_register) from [<c037505c>] (sun4i_usb_phy_probe+0x180/0x614)
	[    2.257279] [<c037505c>] (sun4i_usb_phy_probe) from [<c042d0c0>] (platform_drv_probe+0x50/0xac)

According to log, this crash came from edev of extcon_dev_register()
which is *alocated* by devm_extcon_dev_allocate().
I guess "parent" is set by it ?
Hmm... does "snd_dmaengine_xxx" and "devm_extcon_dev_allocate" has relation ?

static int sun4i_usb_phy_probe(struct platform_device *pdev)
{
	...
=>	data->extcon = devm_extcon_dev_allocate(dev, sun4i_usb_phy0_cable);
	...

	ret = devm_extcon_dev_register(dev, data->extcon);
	...                                 ~~~~~~~~~~~~
}


Best regards
---
Kuninori Morimoto
