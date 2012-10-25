From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 09:37:22 -0600
Subject: [PATCH] ARM: dt: tegra: ventana: define pinmux for ddc
In-Reply-To: <5088DCF2.7030000@nvidia.com>
References: <1350626311-18131-1-git-send-email-markz@nvidia.com>
 <50817668.6020709@wwwdotorg.org> <5084F5D1.7050005@nvidia.com>
 <50857EEF.2070707@wwwdotorg.org> <5088DCF2.7030000@nvidia.com>
Message-ID: <50895CB2.8040103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 12:32 AM, Mark Zhang wrote:
> On 10/23/2012 01:14 AM, Stephen Warren wrote:
...
>> I don't recall why pta was defined to be HDMI. The issue isn't that this
>> patch changes the pinmux selection for the pta pingroup, but simply that
>> both the pinctrl node's state definition, and the new I2C mux node's
>> state definition both attempt to configure pingroup pta. The solution is
>> most likely to simply remove the pta configuration from the main pinctrl
>> node.
> 
> Understood. I tried to remove the hdmi function definition of pta
> pingroup yesterday then found HDMI can't work anymore. The EDID of HDMI
> monitor can't be fetched. After some debugging, I have found that it's
> caused by "i2c-mux-pinctrl" driver is loaded after drm driver. That
> makes drm driver can't get EDID data via this i2c mux adapter because it
> doesn't exist at that time. So I think we need to promote the load level
> of "i2c-mux-pinctrl" driver. Any other ideas?

(BTW, your message that I'm replying to wasn't word-wrapped correctly)

No, i2c-mux-pinctrl shouldn't need to change. It sounds like tegra-drm
isn't supporting deferred probe correctly; when it needs access to an
I2C adapter that doesn't exist, it should defer its own probe until the
I2C adapter does exist.
