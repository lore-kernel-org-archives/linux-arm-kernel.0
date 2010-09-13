From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 13 Sep 2010 12:56:34 +0200
Subject: mv643xx_eth and MDIO bus PM resume
In-Reply-To: <20100912213239.GA2614@kw.sim.vm.gnt>
References: <20100911140717.GA21622@kw.sim.vm.gnt>
	<AANLkTint1UycmX-of4LS2Pw9Co+Ctq=fwWYEFgX99rwr@mail.gmail.com>
	<20100912213239.GA2614@kw.sim.vm.gnt>
Message-ID: <AANLkTinisrn3G9Jq-OcXCCrv9VUTMfQQCQUwYnROGCMM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 12, 2010 at 11:32 PM, Simon Guinot <simon@sequanux.org> wrote:
> Hi Saeed,
>
> On Sun, Sep 12, 2010 at 01:17:28PM +0200, saeed bishara wrote:
>> On Sat, Sep 11, 2010 at 4:07 PM, Simon Guinot <simon@sequanux.org> wrote:
>> > Hi,
>> >
>> > I am trying to get some PM support for Kirkwood machines and I have to
>> > deal with the MDIO bus driver which trigger a kernel crash at resume.
>> >
>> > The Kirkwood SoC Ethernet driver is mv643xx_eth and don't use the PAL
>> > machine state. The PHY is handled by calling manually PHY functions.
>> >
>> > The problem is that the current mdio_bus_resume() implementation
>> > _always_ start at resume the PAL state machine even if the driver can't
>> > handle that. That's the mv643xx_eth case, which don't provide the
>> > adjust_link() method.
>> >
>> > Any hint to fix this issue is welcome.
>> Simon, can you please post your patch to this driver that adds PM support?
attached my patch for mv643xx_eth pm support. The Marvell Dove has
complete pm support, but this still not merged into mainline, you can
look at this git tree where you can find patches for usb, spi, pcie
http://kernel.ubuntu.com/git?p=ycmiao/ubuntu-lucid.git;a=shortlog;h=refs/heads/mvl-dove
saeed
>
> Sorry I don't have a such patch yet. For now, I am still working on the
> core power management support.
>
> If you want test, some patches are available at:
>
> git://lacie-nas.org/lacie-orion.git pm
>
> And the web url is:
>
> http://git.lacie-nas.org/?p=lacie-orion.git;a=shortlog;h=refs/heads/pm
>
> The next step is to add PM support for the driver mv643xx_eth. As the PM
> core turn off the GE unit clock, probably that some driver code is
> needed to handle suspend and resume. Maybe do you have a such patch ?
>
> Concerning the mdio_bus_resume() issue, I think it is not related with
> the Ethernet driver. At resume the MDIO bus automatically start the PAL
> state machine, even if the adjust_link() function is not supplied. Just
> add a check is probably good enough.
>
> Simon
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyNRvcACgkQgtp0PDeOcDrcTACfVDQPWDsoALforv2wSCJ4sbwy
> 8cIAn0FDzNcMUjuhHJsp5BRsTQ8jdqIm
> =I4UJ
> -----END PGP SIGNATURE-----
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mv643xx-add-power-management-support.patch
Type: application/octet-stream
Size: 3714 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100913/ebf0287c/attachment.obj>
