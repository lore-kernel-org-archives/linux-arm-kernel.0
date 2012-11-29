From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 29 Nov 2012 10:08:08 +0000
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
In-Reply-To: <20121128163105.GA28698@sirena.org.uk>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
 <20121128085731.GH2013@gmail.com>
 <20121128163105.GA28698@sirena.org.uk>
Message-ID: <20121129100808.GW2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Nov 2012, Mark Brown wrote:

> On Wed, Nov 28, 2012 at 08:57:31AM +0000, Lee Jones wrote:
> 
> > > I applied these 3 patches, but for DT we also need to specify compatible
> > > ID and set up of_match_table pointer. 
> 
> > Why do you need a compatible string?
> 
> The I2C subsystem guesses at a compatible string by default but it's
> much better to explicitly set one as conflicts do arise from time to
> time (eg, Wolfson parts are called WMxxxx but the WM prefix is also used
> by at least WonderMedia).

It uses the exact device name, rather than guessing. I don't think
you're allowed to have duplicate device names in the system, or there
would be clashes at registration time.

The system is the same for platform data and DT alike.

In platform data we have: 

> struct i2c_board_info mop500_i2c0_devices_stuib[] = {
>         {
>                 .type = "bu21013_tp",
>                 .addr = 0x5C,
>         }
> };

Where (i2c_client)client->name is populated by 'type', which should
then match 'driver.name' exactly.

And in DT we have:

bu21013_tp at 0x5c {
        compatible = "rhom,bu21013_tp";
        reg = <0x5c>;
};

Where (i2c_client)client->name is populated by of_modalias_node(), which
uses the compatible string in the DTS(I) file and takes off the
'<vendor>,' which should then match 'driver.name' exactly.

Hence, there should be no need to have a compatible string in any i2c
driver registration information.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
