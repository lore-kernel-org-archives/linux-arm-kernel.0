From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 26 Aug 2017 22:46:15 -0500
Subject: [RESEND PATCH 1/1] arm64: dts: Add Variscite DART-SD410
 Evaluation board dts
In-Reply-To: <20170825104418.fb7thsfukgh3im2k@tarshish>
References: <014701d31418$8e419670$aac4c350$@variscite.com>
 <20170818203505.GB4042@hector.attlocal.net>
 <CAP6K80Sj9=im4CpXTAL+oR6XLmiBQYPeNMmvpC6v2W0xOP-j4g@mail.gmail.com>
 <20170825104418.fb7thsfukgh3im2k@tarshish>
Message-ID: <20170827034615.GD4042@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 01:44:18PM +0300, Baruch Siach wrote:
> Hi Leonid,
> 
> On Wed, Aug 23, 2017 at 08:44:56PM +0300, Leonid Segal wrote:
> > Thank you very much for the tips.
> > I have updated the documentation and schematics of our web site.
> > I also tried to implement all other fixes, but seems that I cannot file the git
> > you are talking about.
> > The patches i sent were done to:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > and there is no -next branch.
> > I tried to check out the linaro git:
> > http://git.linaro.org/landing-teams/working/qualcomm/kernel.git
> > there is a -next branch, but the USB section is in old format.
> > 
> > I tried to complile the latest version from
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > the usb there in new format, but nothing works (even LEDS) on Dragonboard too.
> > So, I think I am missing something global on the way.
> > 
> >    If you can help me with it, I will appreciate it.
> 
> The linux-next tree is at [1]. Stephen Rothwell generates this tree on a daily 
> basis semi-automatically from subsystem maintainers branches that feed the 
> -next tree. Read more about it in the linux-next web page[2]. The branch that 
> feeds the arm64 changes is for-next/core[3]. See the full list in the 
> Next/Trees file in the -next tree.
> 
> Hope this helps,
> baruch
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Thanks for sending this.  I should have been more clear.

Once you pull the current next tag from linux-next, take a look at the
SBC dtsi.  Specifically this excerpt from the file:

	usb at 78d9000 {
		extcon = <&usb_id>;
		status = "okay";
		adp-disable;
		hnp-disable;
		srp-disable;
		dr_mode = "host";
		pinctrl-names = "default";
		pinctrl-0 = <&usb_sw_sel_pm>;
		ulpi {
			phy {
				v1p8-supply = <&pm8916_l7>;
				v3p3-supply = <&pm8916_l13>;
				extcon = <&usb_id>;
			};
		};
	};

	usb2513 {
		compatible = "smsc,usb3503";
		reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
		initial-mode = <1>;
	};

	usb_id: usb-id {
		compatible = "linux,extcon-usb-gpio";
		vbus-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
		pinctrl-names = "default";
		pinctrl-0 = <&usb_id_default>;

Looking at the Dart, you are using a USB2514, but it should be similar.

Regards,

Andy Gross
