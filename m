From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Thu, 28 Nov 2013 07:45:54 +0000
Subject: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI device for
 Vybrid VF610 TOWER board.
In-Reply-To: <87r4a879rs.fsf@nbsps.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
 <87bo1hk2i7.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828AD451@039-SN2MPN1-012.039d.mgd.msft.net>
 <87hab7hxfx.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828B5046@039-SN2MPN1-012.039d.mgd.msft.net>
 <87wqk1hkiv.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828C79F5@039-SN2MPN1-012.039d.mgd.msft.net>
 <87r4a879rs.fsf@nbsps.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828CFA43@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > The following logs are the situation:
> > 1, Plug in the TWR-AUDIO-SGTL sub-board.
> > 2, Enable the SGTL5000 driver.
> > 3, Disable the CPU DAI driver, here it's the SAI driver.
> > ++++++++++++
> > sgtl5000 0-000a: sgtl5000 revision 0x11
> > vf610-sgtl5000 sound.3: ASoC: CPU DAI (null) not registered
> > vf610-sgtl5000 sound.3: register soc sound card failed :-517
> > ------------
> 
> > And the failed numeric is '-517' too.
> 
> Won't that be prevented by,
> 
> +config SND_SOC_FSL_SGTL5000_VF610
> +	tristate "SoC Audio support for FSL boards with sgtl5000"
> +	depends on OF && I2C
> +	select SND_SOC_FSL_SAI
> 
> Or do you have to manually edit the '.config' to get this?

Yes, it is.


> >> That is just a suggestion.  I know when I booted the TimeSys version of
> >> Linux and before I looked at the schematic, I didn't know why the codec
> >> failed to register and I thought I had a u-boot issue and/or the code
> was
> >> not working for my board.
> 
> >> PS: For those not familiar with the tower.  The VF610-TWR has riser
> cards
> >> at the sides and different boards can be connected.  The TWR-AUDIO-SGTL
> >> is another board that needs to be plugged in.
> 
> I look for other places that a board has an optional daughter board.  For
> the most part, the menuconfig had an option to include the driver and
> then platform initialization code 'probed' the device and provide a
> message.
> 
> For instance, the 3ds_debugboard.c in mxc_expio_init() has a message,
> 
>  pr_info("3-Stack Debug board not detected\n");
> 
> I don't know if there is an Alsa standard mechanism for handling this or
> something in the device tree infrastructure.  However, I am pretty sure
> that we could say the board is not there if the i2c device doesn't
> respond with it's id.  But maybe this is hidden by the ASOC
> infrastructure?
> 
> It will be quite common for people to run a 'imx_v6_v7_defconfig' with
> the 'vf610-twr.dts'.  These people won't read a menu config; in fact the
> binary maybe delivered to them.
> 
> I read the error as 'EPROBE_DEFER'.  We have this in the SGTL5000 codec
> and soc_core.c.  The sgtl5000_i2c_probe() will never be called if the
> board is not present.  So I think the error is from soc_bind_dai_link(),
> 
> 	if (!rtd->codec) {
> 		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
> 			dai_link->codec_name);
> 		return -EPROBE_DEFER;
> 	}
> 
> I guess the issue is the order of the sub-system initialization and the
> soc-core doesn't want to make any assumptions about this.  I am not sure
> if there is some way an SOC machine file can look to see if a codec is
> not populated in it's probe.  Or if it is expected that the machine file
> will be probed multiple times when '-EPROBE_DEFER' is returned.  This
> maybe for either the DAI or the codec and is abnormal for the machine.
> 
> In any case, an "TWR-AUDIO-SGTL board required.\n" would be fairly
> obvious to anyone reading the logs.  They should be able to see if they
> have this board or not.  If they have it, then the error -517 is from
> something else.  I agree that always printing this out is not the most
> elegant, but I think it is the more pragmatic than not having it.
> 

Okey, I will think it over and revise this.

--
Best Regards,
