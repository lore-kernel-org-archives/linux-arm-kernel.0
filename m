From: stefan@agner.ch (Stefan Agner)
Date: Mon, 08 Jan 2018 21:52:36 +0100
Subject: [PATCH v2 1/5] pinctrl: imx: use struct imx_pinctrl_soc_info as a
 const
In-Reply-To: <20180108164855.GA6504@t450s.lan>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-2-stefan@agner.ch> <20180108164855.GA6504@t450s.lan>
Message-ID: <f12aa7b7b3aea7a691a1acd14b8daa58@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-08 17:48, Gary Bisson wrote:
> Hi Stefan,
> 
> On Sat, Jan 06, 2018 at 03:25:49PM +0100, Stefan Agner wrote:
>> For some SoCs the struct imx_pinctrl_soc_info is passed through
>> of_device_id.data which is const. Most variables are already const
>> or otherwise not written. However, some fields are modified at
>> runtime. Move those fields to the dynamically allocated struct
>> imx_pinctrl.
>>
>> Fixes: b3060044e495 ("pinctrl: freescale: imx7d: make of_device_ids const")
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> Cc: Dong Aisheng <aisheng.dong@nxp.com>
>> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> This is actually more or less a revert of a previous commit:
> b28742be4709 pinctrl: imx: remove const qualifier of imx_pinctrl_soc_info

Hm, I see. However, back then imx_pinctrl_probe still consumed a
non-const struct imx_pinctrl_soc_info pointer. So this constifies all
the way through. 

> 
> Note that the idea for this commit was to get dt-overlays working and
> able to do pinctrl changes using configfs interface to load an overlay
> (using Pantelis patch). Not sure where we stand on loading such overlay
> from user-space, is it still something that will happen?

I am all for dt-overlays and actually also hope that it will make it
completely into mainline. So whatever prevents using device tree
overlays should be addressed.

It seems that ngroups is now part of struct pinctrl_dev (num_groups),
which is still writable. So we should be fine?

As far as I can tell all remaining properties come from the drivers
directly and should not be influenced by anything in the device tree....

--
Stefan
