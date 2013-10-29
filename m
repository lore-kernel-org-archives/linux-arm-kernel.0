From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Oct 2013 10:31:33 +0800
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <526E66DC.3090003@de.bosch.com>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <526E66DC.3090003@de.bosch.com>
Message-ID: <20131029023131.GI2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 02:30:04PM +0100, Dirk Behme wrote:
> We have a similar problem, some boards need no pin mux at all (it's
> already done by the boot loader), some boards need some pin mux.
> Doing it the way it's done at the moment, we have ~10k dead pin mux
> stuff in the dtb for the boards without any pin mux. As you describe
> above.
> 
> While thinking about several options to solve this, we found
> 
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/19694
> 
> Adding then something like
> 
> &iomuxc {
>        status = "disabled";
> };
> 
> to the dts which don't want any pin mux and then using the
> --strip-disabled option dramatically reduces the resulting dtb size.

Ah, I like the approach.  But it does not actually address my problem,
which is most of boards need iomuxc node but only a small set of
pinctrl sub-nodes under it.

It does help to solve another concern from Matt regarding to DTB size,
that is those nodes with 'disabled' property do not have to be in DTB
to consume space and hurt run-time lookup efficiency.  This is the Pros
point that you listed below.

> There are several pros and cons to consider, though:
> 
> Pros:
> 
> * You remove additional unused parts, too. Not only the pin mux.
> I.e. the resulting dtb should be even smaller as with only removing
> the pin mux.
> 
> Cons:
> 
> * Non mainline dtc patch
> * Not boot tested, yet. I have tried this only regarding the size of
> the resulting dtb. I haven't tested if the resulting dtb still
> boots, i.e. if everything essential isn't removed.

They do not sound like any real Cons points to me :)

Shawn
